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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author pc2
 */
@Controller
@PropertySource("classpath:keyidconfig.properties")
public class AllDeleteController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;
    //Hello Nitya
    
    

    //delete any record
    @RequestMapping(value = "deleterecord", method = RequestMethod.POST)
    public @ResponseBody
    String deleterecord(@RequestParam(value = "id") String id, @RequestParam(value = "deskname") String tablename) {
        String query = "update " + tablename + " set isdelete='YES',modifydate=now() where id='" + id + "'";
        updateService.updateanyhqlquery(query);
        return "true";
    }
    
    //delete multiple user record
    @RequestMapping(value = "multipleDeleteUser")
    public String multipleDeleteUser(@RequestParam(value = "chkuser")String multideleteid[]){
        if (multideleteid != null && multideleteid.length > 0) {
            for (int i = 0; i < multideleteid.length; i++) {
                String updatequery = "update userdetails set isdelete='YES',modifydate=now() where id='" + multideleteid[i] + "'";
                updateService.updateanyjdbcdatalist(updatequery);
            }
        }
        return "redirect:viewBuilderGridLink";
    }

    //delete any project  record
    @RequestMapping(value = "deleteprojectrecord", method = RequestMethod.POST)
    public @ResponseBody
    String deleteprojectrecord(@RequestParam(value = "id") String id, @RequestParam(value = "deskname") String tablename) {
        String query = "update " + tablename + " set isdelete='YES',modifydate=now() where projectid='" + id + "'";
        updateService.updateanyhqlquery(query);
        return "true";
    }
    
    //delete multiple project record
    @RequestMapping(value = "multipleDeleteProject")
    public String multipleDeleteProject(@RequestParam(value = "chkuser")String multideleteid[]){
        if (multideleteid != null && multideleteid.length > 0) {
            for (int i = 0; i < multideleteid.length; i++) {
                String updatequery = "update projectmaster set isdelete='YES',modifydate=now() where projectid='" + multideleteid[i] + "'";
                updateService.updateanyjdbcdatalist(updatequery);
            }
        }
        return "redirect:viewprojectgrid";
    }
    
    //delete multiple broker record
    @RequestMapping(value = "multipleDeleteBroker")
    public String multipleDeleteBroker(@RequestParam(value = "chkuser")String multideleteid[]){
        if (multideleteid != null && multideleteid.length > 0) {
            for (int i = 0; i < multideleteid.length; i++) {
                String updatequery = "update userdetails set isdelete='YES',modifydate=now() where id='" + multideleteid[i] + "'";
                updateService.updateanyjdbcdatalist(updatequery);
            }
        }
        return "redirect:viewBrokerGridLink";
    }
    
    //delete multiple broker record
    @RequestMapping(value = "multipleDeleteCreateUser")
    public String multipleDeleteCreateUser(@RequestParam(value = "chkuser")String multideleteid[]){
        if (multideleteid != null && multideleteid.length > 0) {
            for (int i = 0; i < multideleteid.length; i++) {
                String updatequery = "update userdetails set isdelete='YES',modifydate=now() where id='" + multideleteid[i] + "'";
                updateService.updateanyjdbcdatalist(updatequery);
            }
        }
        return "redirect:viewusersgrid";
    }
    
    //delete code for areamaster begins here
    @RequestMapping(value = "deletearearecord", method = RequestMethod.POST)
    public @ResponseBody
    String deletearearecord(@RequestParam(value = "id") String id, @RequestParam(value = "deskname") String tablename) {
        String query = "update " + tablename + " set isdelete='YES',modifydate=now() where areaid='" + id + "'";
        updateService.updateanyhqlquery(query);
        return "true";
    }
    
    //delete code for areamaster begins here
    @RequestMapping(value = "deleteleadrecord", method = RequestMethod.POST)
    public @ResponseBody
    String deleteleadrecord(@RequestParam(value = "id") String id, @RequestParam(value = "deskname") String tablename) {
        String query = "update " + tablename + " set isdelete='YES',modifydate=now() where leadid='" + id + "'";
        updateService.updateanyhqlquery(query);
        return "true";
    }
    
    //delete code for requirementmaster begins here
    @RequestMapping(value = "deleterequirementrecord", method = RequestMethod.POST)
    public @ResponseBody
    String deleterequirementrecord(@RequestParam(value = "id") String id, @RequestParam(value = "deskname") String tablename) {
        String query = "update " + tablename + " set isdelete='YES',modifydate=now() where requirementid='" + id + "'";
        updateService.updateanyhqlquery(query);
        return "true";
    }
    
    //delete multiple user record
    @RequestMapping(value = "multipleDeleteRequirement")
    public String multipleDeleteRequirement(@RequestParam(value = "chkuser")String multideleteid[]){
        if (multideleteid != null && multideleteid.length > 0) {
            for (int i = 0; i < multideleteid.length; i++) {
                String updatequery = "update requirementmaster set isdelete='YES',modifydate=now() where requirementid='" + multideleteid[i] + "'";
                updateService.updateanyjdbcdatalist(updatequery);
            }
        }
        return "redirect:viewrequirementgrid";
    }
    
    //delete code for lead source begins here
    @RequestMapping(value = "deleteleadsourcerecord", method = RequestMethod.POST)
    public @ResponseBody
    String deleteleadsourcerecord(@RequestParam(value = "id") String id, @RequestParam(value = "deskname") String tablename) {
        String query = "update " + tablename + " set isdelete='YES',modifydate=now() where leadsourceid='" + id + "'";
        updateService.updateanyhqlquery(query);
        return "true";
    }
    
    //delete code for lead source begins here
    @RequestMapping(value = "deleteslabdetails", method = RequestMethod.POST)
    public @ResponseBody
    String deleteslabdetails(@RequestParam(value = "id") String id, @RequestParam(value = "deskname") String tablename) {
        String query = "update " + tablename + " set isdelete='YES',modifydate=now() where id='" + id + "'";
        updateService.updateanyhqlquery(query);
        return "true";
    }
    
    //delete code for ViewSignupGridMaster begins here
    @RequestMapping(value = "deletesignupmasterrecord", method = RequestMethod.POST)
    public @ResponseBody
    String deletesignupmasterrecord(@RequestParam(value = "id") String id, @RequestParam(value = "deskname") String tablename) {
        String query = "update " + tablename + " set isdelete='YES',modifydate=now() where signupid='" + id + "'";
        updateService.updateanyhqlquery(query);
        return "true";
    }
    
}
