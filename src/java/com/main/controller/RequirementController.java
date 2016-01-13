/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.google.gson.Gson;
import com.main.model.Areamaster;
import com.main.model.RequirementMaster;
import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author pc2
 */
@Controller
@PropertySource("classpath:keyidconfig.properties")
public class RequirementController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

    //redirects to view area master grid
    @RequestMapping(value = "viewrequirementgrid")
    public ModelAndView viewrequirementgrid() {
        ModelAndView modelAndView=new ModelAndView("ViewRequirementGrid");
        modelAndView.addObject("requirementdt", viewService.getanyhqldatalist("from requirementmaster where isdelete='NO' order by length(requirementid) desc,requirementid desc"));
        return modelAndView;
    }
    
    //insert net requirement 
    @RequestMapping(value = "addRequirement")
    public String addRequirement(@ModelAttribute RequirementMaster requirementMaster){
        String pre = env.getProperty("requirementmaster");
        String id = pre + insertService.getmaxcount("requirementmaster", "requirementid", 3);
        requirementMaster.setRequirementid(id);
        insertService.insert(requirementMaster);
        return "redirect:viewrequirementgrid";
    }
    
    //code gets data in dialog to update called from ajax
    @RequestMapping(value = "editRequirementLink", method = RequestMethod.POST)
    public void editRequirementLink(@RequestParam(value = "id") String requirementid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from requirementmaster where requirementid='" + requirementid + "'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }
    
    //code to update 
    @RequestMapping(value = "updateRequirement")
    public String updateRequirement(@ModelAttribute RequirementMaster requirementMaster){
        updateService.update(requirementMaster);
        return "redirect:viewrequirementgrid";
    }
    
}
