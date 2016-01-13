/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author pc2
 */
@Controller
@PropertySource("classpath:keyidconfig.properties")
public class LeadOwnerController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;//redirects to view area master grid

    @RequestMapping(value = "viewVerifyLeadOwnergridLink")
    public ModelAndView viewVerifyLeadOwnergridLink() {
        ModelAndView modelAndView = new ModelAndView("ViewVerifyLeadOwnerGrid");
        modelAndView.addObject("verifyleadownerdt", viewService.getanyjdbcdatalist("SELECT lv.*,u.name as newleadownername \n"
                + "FROM leadownerverification lv\n"
                + "left join userdetails u on u.id=lv.newleadowner where lv.isdelete='NO'"));
        return modelAndView;
    }

}
