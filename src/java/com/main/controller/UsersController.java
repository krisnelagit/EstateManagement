/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.main.model.Detailsofprojectandarea;
import com.main.model.UserDetails;
import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
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
public class UsersController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

    //redirects to add user Page
    @RequestMapping(value = "adduserlink")
    public ModelAndView adduserlink() {
        ModelAndView modelAndView = new ModelAndView("AddUsers");
        modelAndView.addObject("projectdt", viewService.getanyhqldatalist("from projectmaster where isdelete='NO' order by length(projectid) desc,projectid desc"));
        modelAndView.addObject("areadt", viewService.getanyhqldatalist("from areamaster where isdelete='NO' order by length(areaid) desc,areaid desc"));
        return modelAndView;
    }

    //redirects to view users grid
    @RequestMapping(value = "viewusersgrid")
    public ModelAndView viewusersgrid() {
        ModelAndView modelAndView = new ModelAndView("ViewUsersGrid");
        modelAndView.addObject("usersdt", viewService.getanyhqldatalist("from userdetails where isdelete='NO' order by length(id) desc,id desc"));
        return modelAndView;
    }

    //code to insert new users begin here
    @RequestMapping(value = "insertUsers")
    public String insertUsers(@ModelAttribute UserDetails userDetails,
            @RequestParam(value = "drpNewUserproject", required = false) String singleproject,
            @RequestParam(value = "drpNewUserMultiproject", required = false) String[] multiprojarray,
            @RequestParam(value = "drpNewUserMultiArea", required = false) String[] multiareaarray,
            @RequestParam(value = "txtNewUserIncentives", required = false) String incentives,
            @RequestParam(value = "txtNewUserBrokerage", required = false) String brokerage) {

        //insert into users 
        String multipleproject = "", multiplearea = "";
        String pre = env.getProperty("userid");
        String id = pre + insertService.getmaxcount("userdetails", "id", 4);
        userDetails.setId(id);

        if (multiprojarray != null) {
            for (int i = 0; i < multiprojarray.length; i++) {
                multipleproject += multiprojarray[i] + " ";
            }
        }

        if (multiareaarray != null) {
            for (int j = 0; j < multiareaarray.length; j++) {
                multiplearea += multiareaarray[j] + " ";
            }
        }

        if (singleproject.equals("Select Project")) {
            singleproject = null;
        }

        if (incentives != "" && incentives != null) {
            userDetails.setIncentives(incentives);
        } else {
            userDetails.setIncentives("0");
        }
        if (brokerage != "" && brokerage != null) {
            userDetails.setBrokerage(brokerage);
        } else {
            userDetails.setBrokerage("0");
        }

        if (singleproject != null) {
            userDetails.setProject(singleproject);
        } else if (multipleproject != "" && multipleproject != null) {
            userDetails.setProject(multipleproject);
        } else {
            userDetails.setProject("NO");
        }

        if (multiplearea != "" && multiplearea != null) {
            userDetails.setArea(multiplearea);
        } else {
            userDetails.setArea("NO");
        }
        insertService.insert(userDetails);

        //code to insert into detailsofprojectandarea
        if (multiprojarray != null) {
            for (int i = 0; i < multiprojarray.length; i++) {
                String pre2 = env.getProperty("detailsofprojectandareaid");
                String id2 = pre2 + insertService.getmaxcount("detailsofprojectandarea", "detailid", 4);
                Detailsofprojectandarea detailsofprojectandarea=new Detailsofprojectandarea();
                detailsofprojectandarea.setDetailid(id2);
                detailsofprojectandarea.setUserid(userDetails.getId());
                detailsofprojectandarea.setUserprojectname(multiprojarray[i]);
                insertService.insert(detailsofprojectandarea);
            }
        }
        
        //code to insert into detailsofprojectandarea again dont know why? beings here
        if (multiareaarray != null) {
            for (int j = 0; j < multiareaarray.length; j++) {
                String pre2 = env.getProperty("detailsofprojectandareaid");
                String id2 = pre2 + insertService.getmaxcount("detailsofprojectandarea", "detailid", 4);
                Detailsofprojectandarea detailsofprojectandarea=new Detailsofprojectandarea();
                detailsofprojectandarea.setDetailid(id2);
                detailsofprojectandarea.setUserid(userDetails.getId());
                detailsofprojectandarea.setUserprojectname(multiareaarray[j]);
                insertService.insert(detailsofprojectandarea);
            }
        }
        return "redirect:viewusersgrid";
    }
    //code to insert new users ends! here

    @RequestMapping(value = "editusersLink")
    public ModelAndView editusersLink(@RequestParam(value = "id")String userid) {
        ModelAndView modelAndView = new ModelAndView("EditUsers");
        List<UserDetails> userList=viewService.getanyhqldatalist("from userdetails where id='"+userid+"'");
        modelAndView.addObject("usersdt", viewService.getspecifichqldata(UserDetails.class, userid));
        modelAndView.addObject("projectsdt", viewService.getanyhqldatalist("from projectmaster where isdelete='NO' order by length(projectid) desc,projectid desc"));
        modelAndView.addObject("areasdt", viewService.getanyhqldatalist("from areamaster where isdelete='NO' order by length(areaid) desc,areaid desc"));
        
        List<Map<String,Object>> customList=new ArrayList<Map<String,Object>>();
        if (userList.get(0).getType().equals("Project Manager") || userList.get(0).getType().equals("Sales Executive")
                || userList.get(0).getType().equals("Sales Manager") || userList.get(0).getType().equals("Campaign Manager")) {
            customList=viewService.getanyjdbcdatalist("select d.detailid as detailid,p.ProjectId as projid,p.Name as projareaname from detailsofprojectandarea d left join projectmaster p on p.ProjectId=d.userprojectname where p.isdelete='NO' and d.isdelete='NO' and d.userid='"+userid+"'");
        } else if(userList.get(0).getType().equals("Area Manager")) {
            customList=viewService.getanyjdbcdatalist("select d.detailid as detailid,a.AreaId as areaid,a.Name as projareaname from detailsofprojectandarea d left join areamaster a on a.AreaId=d.userareaname where a.isdelete='NO' and d.isdelete='NO' and d.userid='"+userid+"'");
        }
        modelAndView.addObject("customList", customList);
        return modelAndView;
    }
    
    //code to update users begin here
    @RequestMapping(value = "updateusers")
    public String updateusers(@ModelAttribute UserDetails userDetails,@RequestParam(value = "drpExistUserMultiproject",required = false)String[] multiprojarray,@RequestParam(value = "drpExistUserMultiArea",required = false)String[] multiareaarray,HttpServletRequest request ){
        if (multiprojarray != null) {
            for (int j = 0; j < multiprojarray.length; j++) {
                String pre2 = env.getProperty("detailsofprojectandareaid");
                String id2 = pre2 + insertService.getmaxcount("detailsofprojectandarea", "detailid", 4);
                Detailsofprojectandarea detailsofprojectandarea=new Detailsofprojectandarea();
                detailsofprojectandarea.setDetailid(id2);
                detailsofprojectandarea.setUserid(userDetails.getId());
                detailsofprojectandarea.setUserprojectname(multiprojarray[j]);
                insertService.insert(detailsofprojectandarea);
            }
        }
        if (multiareaarray != null) {
            for (int j = 0; j < multiareaarray.length; j++) {
                String pre2 = env.getProperty("detailsofprojectandareaid");
                String id2 = pre2 + insertService.getmaxcount("detailsofprojectandarea", "detailid", 4);
                Detailsofprojectandarea detailsofprojectandarea=new Detailsofprojectandarea();
                detailsofprojectandarea.setDetailid(id2);
                detailsofprojectandarea.setUserid(userDetails.getId());
                detailsofprojectandarea.setUserareaname(multiareaarray[j]);
                insertService.insert(detailsofprojectandarea);
            }
        }
        
        //code to update userdetails table begin here
        updateService.update(userDetails);
        String referrer = ((HttpServletRequest) request).getHeader("referer");
        return "redirect:"+referrer;
    }
    
    //redirect to view builder master begins! here
    @RequestMapping(value = "viewBuilderGridLink")
    public ModelAndView viewBuilderGrid(){
        ModelAndView modelAndView=new ModelAndView("ViewBuilderGrid");
        modelAndView.addObject("builderdt", viewService.getanyhqldatalist("from userdetails where type='Builder' and isdelete='NO' order by length(id) desc,id desc"));
        return modelAndView;
    }
    
    //redirect to view broker master begins! here
    @RequestMapping(value = "viewBrokerGridLink")
    public ModelAndView viewBrokerGridLink(){
        ModelAndView modelAndView=new ModelAndView("ViewBrokerGrid");
        modelAndView.addObject("brokerdt", viewService.getanyhqldatalist("from userdetails where type='Broker' and isdelete='NO' order by length(id) desc,id desc"));
        return modelAndView;
    }
    
   

}
