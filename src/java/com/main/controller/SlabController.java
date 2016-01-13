/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.main.model.ProjectRequirement;
import com.main.model.SlabMaster;
import com.main.model.SlabMasterDetails;
import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author pc2
 */
@Controller
@PropertySource("classpath:keyidconfig.properties")
public class SlabController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

    //redirect to add slab from project master grid
    @RequestMapping(value = "viewSlabMasterLink")
    public ModelAndView viewareagrid(@RequestParam(value = "projectid") String projectid) {
        ModelAndView modelAndView = new ModelAndView("ViewSlabMaster");
        modelAndView.addObject("slabdt", viewService.getanyhqldatalist("from slab_master where project_requirement_id='" + projectid + "'"));
        return modelAndView;
    }

    //inserts in slab
    @RequestMapping(value = "insertSlab")
    public String insertSlab(@ModelAttribute SlabMaster slabMaster) {
        insertService.insert(slabMaster);
        return "redirect:viewSlabMasterLink?projectid=" + slabMaster.getProject_requirement_id();
    }

    //redirect to add slabs project master begins here
    @RequestMapping(value = "addslabsproject")
    public ModelAndView addslabsproject(@RequestParam(value = "projectid") String projectid, @RequestParam(value = "slab_master_id") String slab_master_id) {
        ModelAndView modelAndView = new ModelAndView("AddSlabsProject");
//        modelAndView.addObject("slabdt", viewService.getanyjdbcdatalist("SELECT pr.slabname as slabnameJ,pr.slabpercent,pr.id as reqidJ,pr.projectid as projid FROM projectmaster p left join userdetails u on p.BuilderName=u.id left join (select * from projectrequirement where isdelete='NO' and slabname is not null and slabname<>'null') pr on pr.projectid=p.ProjectId where p.projectid='" + projectid + "' and slab_master_id=" + slab_master_id + " and p.isdelete='NO'"));
        modelAndView.addObject("slabdt", viewService.getanyhqldatalist("from slab_master_details where slab_master_id='"+slab_master_id+"' and isdelete='NO'"));
        return modelAndView;
    }

    //inserts slab calculated here
    @RequestMapping(value = "updateslabprojectrequirement")
    public String updateslabprojectrequirement(@RequestParam(value = "project_id") String project_id,
            @RequestParam(value = "txtreqid",required = false)String updateid[],
            @RequestParam(value = "txtProjectSlab",required = false)String updateslabname[],
            @RequestParam(value = "txtProjectSlabPercent",required = false)String updateslabpercent[],
            @RequestParam(value = "txtProjectSlabADD")String insertslabname[],
            @RequestParam(value = "txtProjectSlabpercentADD")String insertslabpercent[],
            @RequestParam(value = "slab_master_id")String slab_master_id) {
        //get the project master 
        //inserts new slab data in projectrequirm eent aka slabdetails
        if (insertslabname != null && insertslabpercent != null) {
            for (int i = 1; i < insertslabname.length; i++) {
                ProjectRequirement prjrequirement = new ProjectRequirement();
                String pre = env.getProperty("projectrequirement");
                String id = pre + insertService.getmaxcount("projectrequirement", "id", 4);
                prjrequirement.setId(id);
                prjrequirement.setProjectid(project_id);
                prjrequirement.setSlabname(insertslabname[i]);
                prjrequirement.setSlabpercent(insertslabpercent[i]);
                prjrequirement.setSlab_master_id(slab_master_id);
                insertService.insert(prjrequirement);
            }
        }
        
        //update old projectrequirement aka slab details
        if (updateslabname != null && updateslabpercent != null && updateid != null) {
            for (int i = 0; i < updateslabname.length; i++) {
                updateService.updateanyhqlquery("update projectrequirement set modifydate=now(),slabname='"+updateslabname[i]+"',slabpercent='" + updateslabpercent[i] + "' where id='" + updateid[i] + "'");
                
            }
        }
        
        return "redirect:viewprojectgrid";
    }
    
    //new code to insert new slab begins here
    @RequestMapping(value = "insertslabprojectrequirement")
    public String insertslabprojectrequirement(@RequestParam(value = "project_id") String project_id,
            @RequestParam(value = "txtreqid",required = false)String updateid[],
            @RequestParam(value = "txtProjectSlab",required = false)String updateslabname[],
            @RequestParam(value = "txtProjectSlabPercent",required = false)String updateslabpercent[],
            @RequestParam(value = "txtProjectSlabADD")String insertslabname[],
            @RequestParam(value = "txtProjectSlabpercentADD")String insertslabpercent[],
            @RequestParam(value = "slab_master_id")String slab_master_id){
        if (insertslabname != null && insertslabpercent != null) {
            for (int i = 1; i < insertslabname.length; i++) {
                SlabMasterDetails smd=new SlabMasterDetails();
                smd.setSlab_name(insertslabname[i]);
                smd.setSlab_percent(insertslabpercent[i]);
                smd.setSlab_master_id(slab_master_id);
                insertService.insert(smd);
            }
        }
        //update old projectrequirement aka slab details
        if (updateslabname != null && updateslabpercent != null && updateid != null) {
            for (int i = 0; i < updateslabname.length; i++) {
                updateService.updateanyhqlquery("update slab_master_details set modifydate=now(),slab_name='"+updateslabname[i]+"',slab_percent='" + updateslabpercent[i] + "' where id='" + updateid[i] + "'");
                
            }
        }
        return "redirect:viewprojectgrid";
    }

}
