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
public class BrokeragePaymentController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

    @RequestMapping(value = "brokeragepaymentgridlink")
    public ModelAndView brokeragepaymentgridlink() {
        ModelAndView modelAndView = new ModelAndView("ViewBrokeragePaymentGrid");
        List<Map<String, Object>> brokerageList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> theList = viewService.getanyjdbcdatalist("select ifnull(a.totalamount,0) as totalamount,ifnull(a.totalpaid,0) as totalpaid ,a.brokerage as brokerage,a.brokername as brokername,a.userid as userid from(\n"
                + "select(select sum(brokerageamt) amt from signupmaster where broker=usr.id) as totalamount,\n"
                + "(select sum(paidamount) p from brokerpaymentdetails where UserId=usr.id) as totalpaid,\n"
                + " usr.brokerage as brokerage,usr.Name as brokername,usr.id as userid\n"
                + "from userdetails usr\n"
                + "where usr.Type='Broker' and usr.isdelete='NO'\n"
                + ")a");
        
        for (int i = 0; i < theList.size(); i++) {
            Map<String, Object> setMap = new HashMap<String, Object>();
            double total,balance;
            
            total=Double.parseDouble(theList.get(i).get("totalamount").toString())*Double.parseDouble(theList.get(i).get("totalamount").toString());
            String status = "UNPAID";
            if (theList.get(i).get("totalpaid") != null && theList.get(i).get("totalpaid") != "") {
                setMap.put("paid", theList.get(i).get("totalpaid"));
            }else{
                setMap.put("paid", "0");
            }
            balance=total-Double.parseDouble(setMap.get("paid").toString());
            if (balance == 0) {
                status = "PAID";
            }
            if(balance==0 && total==0){
                status="Not Started";
            }
            setMap.put("status", status);
            setMap.put("total", total);
            setMap.put("balance", balance);
            setMap.put("totalpaid", theList.get(i).get("totalpaid"));
            setMap.put("name", theList.get(i).get("brokername"));
            setMap.put("brokerage", theList.get(i).get("brokerage"));
            setMap.put("id", theList.get(i).get("userid"));
            brokerageList.add(setMap);
        }
        modelAndView.addObject("brokeragedt", brokerageList);
        return modelAndView;
    }

}
