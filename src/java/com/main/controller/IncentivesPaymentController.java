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
public class IncentivesPaymentController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

    @RequestMapping(value = "incentivepaymentGridLink")
    public ModelAndView incentivepaymentGridLink() {
        ModelAndView modelAndView = new ModelAndView("ViewIncentivesPaymentGrid");
        List<Map<String, Object>> incentiveList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> theList = viewService.getanyjdbcdatalist("select (select count(name) from leadmaster\n"
                + "where Confirmed='YES' and leadowner=l.leadowner and isdelete='NO') as totalamount,\n"
                + "(select sum(ifnull(caldt.paidamount,0) )p from callerpaymentdetails caldt \n"
                + "where caldt.userid=l.leadowner and  caldt.isdelete='NO') totalpaid,ursdt.incentives as incentives,\n"
                + "ursdt.`name` as callername,ursdt.id as uid\n"
                + "from leadmaster l\n"
                + "left join callerpaymentdetails caldt on l.leadowner=caldt.userid\n"
                + "right join userdetails ursdt on l.leadowner=ursdt.id\n"
                + "where l.Confirmed='YES' and l.isdelete='NO' and( ursdt.Type='Calling Executive' or  ursdt.Type='Sales Executive' or  ursdt.Type='Sales Manager')\n"
                + "group by ursdt.id");

        for (int i = 0; i < theList.size(); i++) {
            Map<String, Object> setMap = new HashMap<String, Object>();
            
            int balance, total;
            String status = "UNPAID";
            total = Integer.parseInt(theList.get(i).get("totalamount").toString()) * Integer.parseInt(theList.get(i).get("incentives").toString());
            if (theList.get(i).get("totalpaid") != null && theList.get(i).get("totalpaid") != "") {
                setMap.put("paid", theList.get(i).get("totalpaid"));
            } else {
                setMap.put("paid", "0");
            }
            balance = total - Integer.parseInt(setMap.get("paid").toString());
            if (balance == 0) {
                status = "PAID";
            }

            setMap.put("callername", theList.get(i).get("callername"));
            setMap.put("total", total);
            setMap.put("balance", balance);
            setMap.put("totalpaid", setMap.get("paid"));
            setMap.put("status", status);
            setMap.put("incentives", theList.get(i).get("incentives"));
            setMap.put("id", theList.get(i).get("uid"));
            incentiveList.add(setMap);
        }
        modelAndView.addObject("incentivesdt", incentiveList);
        return modelAndView;
    }

}
