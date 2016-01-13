/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.google.gson.Gson;
import com.main.model.Areamaster;
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
public class AreaController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

    //redirects to view area master grid
    @RequestMapping(value = "viewareagrid")
    public ModelAndView viewareagrid() {
        ModelAndView modelAndView=new ModelAndView("ViewAreaGrid");
        modelAndView.addObject("areadt", viewService.getanyhqldatalist("from areamaster where isdelete='No' order by length(areaid) desc,areaid desc"));
        return modelAndView;
    }
    
    //inserts new area
    @RequestMapping(value = "addArea")
    public String addArea(@ModelAttribute Areamaster areamaster){
        String pre = env.getProperty("areaid");
        String id = pre + insertService.getmaxcount("areamaster", "areaid", 3);
        areamaster.setAreaid(id);
        insertService.insert(areamaster);
        return "redirect:viewareagrid";
    }
    
    //code gets data in dialog to update called from ajax
    @RequestMapping(value = "editAreaLink", method = RequestMethod.POST)
    public void editBrandLink(@RequestParam(value = "id") String areaId, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from areamaster where areaid='" + areaId + "'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }
    
    //code to update 
    @RequestMapping(value = "updateArea")
    public String updateArea(@ModelAttribute Areamaster areamaster){
        updateService.update(areamaster);
        return "redirect:viewareagrid";
    }
    
}
