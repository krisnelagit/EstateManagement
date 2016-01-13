/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
public class BuilderPaymentController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

    //redirects to view area master grid
    @RequestMapping(value = "viewbuilderpaymentgridlink")
    public ModelAndView viewbuilderpaymentgridlink() {
        ModelAndView modelAndView = new ModelAndView("ViewBuilderPaymentGrid");
        List<Map<String, Object>> builderList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> theList = viewService.getanyjdbcdatalist("select sum(ifnull(jeamt,0)) as totalamount,sum(ifnull(bp.paidamount,0)) as totalpaid,s.jepercent as jepercent,p.name as projectname,p.ProjectId as projectid from signupmaster s \n"
                + "left join builderpaymentdetails bp on bp.UserId=s.projectname\n"
                + "left join projectmaster p on p.ProjectId=s.projectname\n"
                + "where p.isdelete='NO' and s.isdelete='NO'\n"
                + "group by s.projectname");

        for (int i = 0; i < theList.size(); i++) {
            String status = "UNPAID", paid;
            double totalpaid, balance;
            if (theList.get(i).get("totalpaid").toString() != null && theList.get(i).get("totalpaid").toString() != "") {
                paid = theList.get(i).get("totalpaid").toString();
            } else {
                paid = "0";
            }
            totalpaid = Double.parseDouble(paid);
            balance = Double.parseDouble(theList.get(i).get("totalamount").toString()) - totalpaid;
            if (balance == 0) {
                status = "PAID";
            }
            Map<String, Object> setMap = new HashMap<String, Object>();
            setMap.put("name", theList.get(i).get("projectname"));
            setMap.put("jepercent", theList.get(i).get("jepercent"));
            setMap.put("total", theList.get(i).get("totalamount"));
            setMap.put("status", status);
            setMap.put("balance", balance);
            setMap.put("totalpaid", paid);
            setMap.put("projectid", theList.get(i).get("projectid"));
            builderList.add(setMap);
        }
        modelAndView.addObject("builderdt", builderList);
        return modelAndView;
    }

}
