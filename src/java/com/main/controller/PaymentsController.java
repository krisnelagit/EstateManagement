/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.main.model.ProjectMaster;
import com.main.model.UserDetails;
import com.main.service.AllInsertService;
import com.main.service.AllViewService;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author pc2
 */
@Controller
public class PaymentsController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    Environment env;

    @RequestMapping(value = "viewPaymentsGridLink")
    public ModelAndView viewPaymentsGridLink() {
        ModelAndView modelAndView = new ModelAndView("ViewPaymentsGrid");
        List<ProjectMaster> projectList = viewService.getanyhqldatalist("from projectmaster where isdelete='No' order by length(projectid) desc,projectid desc");
        List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < projectList.size(); i++) {
            List<Map<String, Object>> sumlist = viewService.getanyjdbcdatalist("SELECT SUM(total) as totalsales FROM signupmaster where projectname='" + projectList.get(i).getProjectid() + "'");
            List<Map<String, Object>> receiptlist = viewService.getanyjdbcdatalist("SELECT SUM(sgp.paidamount) as totalreceipt\n"
                    + "FROM signup_paymentdetails sgp\n"
                    + "inner join signupslabs sus on sus.id=sgp.slab\n"
                    + "inner join signupmaster sm on sm.signupid=sus.signupid\n"
                    + "where sm.projectname='" + projectList.get(i).getProjectid() + "' and sgp.isdelete='NO' and sus.isdelete='NO' and sm.isdelete='NO'");
            List<Map<String, Object>> depositlist = viewService.getanyjdbcdatalist("SELECT count(sgp.deposit) as pendingdeposit\n"
                    + "FROM signup_paymentdetails sgp\n"
                    + "inner join signupslabs sus on sus.id=sgp.slab\n"
                    + "inner join signupmaster sm on sm.signupid=sus.signupid\n"
                    + "where sm.projectname='" + projectList.get(i).getProjectid() + "' and sgp.deposit='No' and sgp.isdelete='NO' and sus.isdelete='NO' and sm.isdelete='NO'");
            List<Map<String, Object>> dishonouredlist = viewService.getanyjdbcdatalist("SELECT count(sgp.cleared) as totaldishonoured\n"
                    + "FROM signup_paymentdetails sgp\n"
                    + "inner join signupslabs sus on sus.id=sgp.slab\n"
                    + "inner join signupmaster sm on sm.signupid=sus.signupid\n"
                    + "where sm.projectname='" + projectList.get(i).getProjectid() + "' and sgp.cleared='No' and sgp.isdelete='NO' and sus.isdelete='NO' and sm.isdelete='NO'");
            Map<String, Object> setMap = new HashMap<String, Object>();
            setMap.put("totalsales", sumlist.get(0).get("totalsales"));
            setMap.put("totalreceipt", receiptlist.get(0).get("totalreceipt"));
            setMap.put("pendingdeposit", depositlist.get(0).get("pendingdeposit"));
            setMap.put("totaldishonoured", dishonouredlist.get(0).get("totaldishonoured"));
            setMap.put("projectid", projectList.get(i).getProjectid());
            setMap.put("projectname", projectList.get(i).getName());
            dataList.add(setMap);
            
        }
        modelAndView.addObject("projectdt", dataList);
        return modelAndView;
    }

    @RequestMapping(value = "viewPaymentExecutiveWiseGridLink")
    public ModelAndView viewPaymentExecutiveWiseGridLink() {
        ModelAndView modelAndView = new ModelAndView("ViewPaymentExecutiveGrid");
        List<UserDetails> executiveList = viewService.getanyhqldatalist("FROM userdetails where type='Sales Executive' and isdelete='NO'");
        List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < executiveList.size(); i++) {
            List<Map<String, Object>> sumlist = viewService.getanyjdbcdatalist("SELECT SUM(total) as totalsales FROM signupmaster where salesperson='" + executiveList.get(i).getId() + "'");
            List<Map<String, Object>> receiptlist = viewService.getanyjdbcdatalist("SELECT SUM(sgp.paidamount) as totalreceipt\n"
                    + "FROM signup_paymentdetails sgp\n"
                    + "inner join signupslabs sus on sus.id=sgp.slab\n"
                    + "inner join signupmaster sm on sm.signupid=sus.signupid\n"
                    + "where sm.salesperson='" + executiveList.get(i).getId() + "' and sgp.isdelete='NO' and sus.isdelete='NO' and sm.isdelete='NO'");
            List<Map<String, Object>> depositlist = viewService.getanyjdbcdatalist("SELECT count(sgp.deposit) as pendingdeposit\n"
                    + "FROM signup_paymentdetails sgp\n"
                    + "inner join signupslabs sus on sus.id=sgp.slab\n"
                    + "inner join signupmaster sm on sm.signupid=sus.signupid\n"
                    + "where sm.salesperson='" + executiveList.get(i).getId() + "' and sgp.deposit='No' and sgp.isdelete='NO' and sus.isdelete='NO' and sm.isdelete='NO'");
            List<Map<String, Object>> dishonouredlist = viewService.getanyjdbcdatalist("SELECT count(sgp.cleared) as totaldishonoured\n"
                    + "FROM signup_paymentdetails sgp\n"
                    + "inner join signupslabs sus on sus.id=sgp.slab\n"
                    + "inner join signupmaster sm on sm.signupid=sus.signupid\n"
                    + "where sm.salesperson='" + executiveList.get(i).getId() + "' and sgp.cleared='No' and sgp.isdelete='NO' and sus.isdelete='NO' and sm.isdelete='NO'");
            Map<String, Object> setMap = new HashMap<String, Object>();
            setMap.put("totalsales", sumlist.get(0).get("totalsales"));
            setMap.put("totalreceipt", receiptlist.get(0).get("totalreceipt"));
            setMap.put("pendingdeposit", depositlist.get(0).get("pendingdeposit"));
            setMap.put("totaldishonoured", dishonouredlist.get(0).get("totaldishonoured"));
            setMap.put("projectname", executiveList.get(i).getName());
            dataList.add(setMap);
            System.out.println("executive "+ executiveList.get(i).getId());
        }
        modelAndView.addObject("projectdt", dataList);
        return modelAndView;
    }

}
