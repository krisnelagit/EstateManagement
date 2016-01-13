/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.google.gson.Gson;
import com.main.model.FlatDetails;
import com.main.model.ProjectMaster;
import com.main.model.ProjectRequirement;
import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author pc2
 */
@Controller
@PropertySource("classpath:keyidconfig.properties")
public class ProjectController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

    //redirects to view area master grid
    @RequestMapping(value = "viewprojectgrid")
    public ModelAndView viewprojectgrid() {
        ModelAndView modelAndView = new ModelAndView("ViewProjectGrid");
        modelAndView.addObject("projectdt", viewService.getanyjdbcdatalist("SELECT p.*,b.name as buildernameJ \n"
                + "FROM projectmaster p \n"
                + "inner join  userdetails b on b.id =p.BuilderName\n"
                + "where p.isdelete='NO'"));
        return modelAndView;
    }

    //redirects to add new project code begins here
    @RequestMapping(value = "addProjectlink")
    public ModelAndView addProjectlink() {
        ModelAndView modelAndView = new ModelAndView("AddProject");
        modelAndView.addObject("buildersdt", viewService.getanyhqldatalist("from userdetails where type='Builder' and isdelete='NO'"));
        modelAndView.addObject("requirementdt", viewService.getanyhqldatalist("from requirementmaster where isdelete='NO'"));
        modelAndView.addObject("areadt", viewService.getanyhqldatalist("from areamaster where isdelete='NO'"));
        return modelAndView;
    }

    //code to insert new project begins here
    @RequestMapping(value = "insertProject")
    public String insertProject(@ModelAttribute ProjectMaster projectMaster,
            @RequestParam(value = "drprequirement", required = false) String[] requirement,
            @RequestParam(value = "drparea", required = false) String area,
            @RequestParam(value = "txtcarpetSqrFeet", required = false) String[] carpet,
            @RequestParam(value = "txtProjectSqrFeet", required = false) String[] srqfeets) {

        String allrequirement = "", allarea = "";
        if (requirement != null) {
            for (int i = 0; i < requirement.length; i++) {
                allrequirement += requirement[i] + " ";
            }
        }
//        if (area != null) {
//            for (int i = 0; i < area.length; i++) {
//                allarea += area[i] + " ";
//            }
//        }

        String pre = env.getProperty("projectmaster");
        String id = pre + insertService.getmaxcount("projectmaster", "projectid", 4);
        projectMaster.setProjectid(id);
        projectMaster.setRequirement(allrequirement.trim());
        projectMaster.setArea(area);
        insertService.insert(projectMaster);

        //insert into flatdetails begin here
        if (projectMaster.getWings() != null && !projectMaster.getWings().equals("")
                && projectMaster.getFloors() != null && !projectMaster.getFloors().equals("")
                && projectMaster.getFlats() != null && !projectMaster.getFlats().equals("")) {
            int count = 1;
            for (int i = 0; i < Integer.parseInt(projectMaster.getWings()); i++) {
                for (int j = 0; j < Integer.parseInt(projectMaster.getFloors()); j++) {
                    for (int k = 0; k < Integer.parseInt(projectMaster.getFlats()); k++) {
                        FlatDetails flatDetails = new FlatDetails();
                        flatDetails.setFlatid(projectMaster.getProjectid() + i + "F" + j + "R" + k);
                        flatDetails.setOfbuilding(projectMaster.getProjectid());
                        flatDetails.setWingnum("" + count);
                        insertService.insert(flatDetails);
                    }
                }
                count++;
            }
        }

        if (requirement != null) {
            for (int i = 0; i < requirement.length; i++) {
                ProjectRequirement projectRequirement = new ProjectRequirement();
                String pre2 = env.getProperty("projectrequirement");
                String id2 = pre2 + insertService.getmaxcount("projectrequirement", "id", 4);
                projectRequirement.setId(id2);
                projectRequirement.setProjectid(projectMaster.getProjectid());
                projectRequirement.setRequirement(requirement[i]);
                projectRequirement.setSqrfeets(srqfeets[i]);
                projectRequirement.setCarpet(carpet[i]);
                projectRequirement.setArea(area);
                insertService.insert(projectRequirement);
            }
        }

//        if (area != null) {
//            for (int i = 0; i < area.length; i++) {
//                ProjectRequirement projectRequirement = new ProjectRequirement();
//                String pre2 = env.getProperty("projectrequirement");
//                String id2 = pre2 + insertService.getmaxcount("projectrequirement", "id", 4);
//                projectRequirement.setId(id2);
//                projectRequirement.setProjectid(projectMaster.getProjectid());
//                projectRequirement.setArea(area[i]);
//            }
//        }
        updateService.updateanyhqlquery("update userdetails set project='" + projectMaster.getProjectid() + "',modifydate=now() where id='" + projectMaster.getBuildername() + "'");

        return "redirect:viewprojectgrid";
    }

    //edit project code begins here
    @RequestMapping(value = "editprojectLink")
    public ModelAndView editprojectLink(@RequestParam(value = "id") String id) {
        ModelAndView modelAndView = new ModelAndView("EditProject");
        modelAndView.addObject("projectdt", viewService.getanyjdbcdatalist("SELECT p.*,u.Name as buildernameJ,pr.requirement as reqJ,pr.sqrfeets as sqrJ,pr.id as reqidJ,pr.carpet as carpet FROM projectmaster p left join userdetails u on p.BuilderName=u.id left join (select * from projectrequirement where isdelete='NO' and requirement is not null and requirement<>'null') pr on pr.projectid=p.ProjectId where p.projectid='" + id + "' and p.isdelete='NO'"));
        modelAndView.addObject("requirementdt", viewService.getanyhqldatalist("from requirementmaster where isdelete='NO'"));

        return modelAndView;
    }

    //update project master begins here
    @RequestMapping(value = "updateproject")
    public String updateproject(@ModelAttribute ProjectMaster projectMaster,
            @RequestParam(value = "drprequirementADD", required = false) String insertreq[],
            @RequestParam(value = "txtProjectSqrFeetADD", required = false) String insertsrqfeet[],
            @RequestParam(value = "txtcarpetSqrFeetADD", required = false) String carpet[],
            @RequestParam(value = "drprequirement", required = false) String updatereq[],
            @RequestParam(value = "txtProjectSqrFeet", required = false) String updatesqrfeet[],
            @RequestParam(value = "txtCarpetSqrFeet", required = false) String updatecarpet[],
            @RequestParam(value = "txtreqid", required = false) String updateid[]) {

        //updates projectmaster table
        updateService.updateanyhqlquery("update projectmaster set name='" + projectMaster.getName() + "', location='" + projectMaster.getLocation() + "', address='" + projectMaster.getAddress() + "', modifydate=now(), jepercent='" + projectMaster.getJepercent() + "' where projectid='" + projectMaster.getProjectid() + "'");

        //inserts into projectrequirement table which also acts as slab details
        if (insertsrqfeet != null && insertsrqfeet.length > 0) {
            for (int i = 0; i < insertreq.length; i++) {
                if (insertsrqfeet[i].lastIndexOf("") > 0) {
                    ProjectRequirement prjrequirement = new ProjectRequirement();
                    String pre = env.getProperty("projectrequirement");
                    String id = pre + insertService.getmaxcount("projectrequirement", "id", 4);
                    prjrequirement.setId(id);
                    prjrequirement.setProjectid(projectMaster.getProjectid());
                    prjrequirement.setRequirement(insertreq[i]);
                    prjrequirement.setSqrfeets(insertsrqfeet[i]);
//                prjrequirement.setSaleable(saleable[i]); nitz
                    prjrequirement.setCarpet(carpet[i]);
                    prjrequirement.setArea(projectMaster.getArea());
                    insertService.insert(prjrequirement);
                }
            }
        }

        //updates requirement code begins here ak.a slabdetails
        if (updatereq != null && updatesqrfeet != null && updateid != null) {
            for (int i = 0; i < updatereq.length; i++) {
                updateService.updateanyhqlquery("update projectrequirement set requirement='" + updatereq[i] + "', modifydate=now(), sqrfeets='" + updatesqrfeet[i] + "', carpet='" + updatecarpet[i] + "' where id='" + updateid[i] + "'");
            }
        }
        return "redirect:viewprojectgrid";
    }

    @RequestMapping("deleterequirement")
    public @ResponseBody
    String deleterequirement(@RequestParam(value = "id") String id) {
        updateService.updateanyhqlquery("update projectrequirement set isdelete='YES' where id='" + id + "'");
        return "Success";
    }

    //code for view wing grid page begin here
    @RequestMapping(value = "viewWingGridLink")
    public ModelAndView viewWingGridLink(@RequestParam(value = "projectid") String projectid) {
        ModelAndView modelAndView = new ModelAndView("ViewWingsGrid");
        modelAndView.addObject("wingsdt", viewService.getspecifichqldata(ProjectMaster.class, projectid));
//        modelAndView.addObject("wingsdt", viewService.getanyhqldatalist("from projectmaster where projectid='" + projectid + "'"));
        return modelAndView;
    }

    //code to show building view begins here
    @RequestMapping(value = "showbuildingviewofprojects")
    public ModelAndView showbuildingviewofprojects(@RequestParam(value = "projectid") String projectid,
            @RequestParam(value = "wings") int wings,
            @RequestParam(value = "floorscount") int flors) {
        ModelAndView modelAndView = new ModelAndView("ShowBuildingView");
//        modelAndView.addObject("projectdt", viewService.getanyhqldatalist("from projectmaster where projectid='" + projectid + "' and isdelete='NO'"));
        List<ProjectMaster> projectlist = viewService.getanyhqldatalist("from projectmaster where projectid='" + projectid + "' and isdelete='NO'");

        int floors = Integer.parseInt(projectlist.get(0).getFloors());
        int flats = Integer.parseInt(projectlist.get(0).getFlats());
        List<Map<String, Object>> buildingList = new ArrayList<Map<String, Object>>();

        for (int i = 0; i < wings; i++) {
            List<Map<String, Object>> floorList = new ArrayList<Map<String, Object>>();
            Map<String, Object> setmap = new HashMap<String, Object>();
            setmap.put("wingsdt", wings);
//            int countfloor = floors;
            for (int j = 0; j < floors; j++) {
                List<Map<String, Object>> flatList = new ArrayList<Map<String, Object>>();
                Map<String, Object> setmapfloor = new HashMap<String, Object>();
                setmapfloor.put("floorsdt", floors);

                for (int k = 0; k < flats; k++) {
                    int flatid = wings - 1;
                    String customid = projectid + flatid + "F" + j + "R" + k;
//                    List<Map<String, Object>> customidListd = viewService.getanyjdbcdatalist("SELECT s.date as Sdate,s.name as Sname,s.signupid as signupid,s.sqrfeet as Ssquarfeet,s.total as Stotal,fd.Status as status,fd.flatname as flatname \n"
//                            + "FROM flatsdetails fd \n"
//                            + "left join signupmaster s on s.flatnum=fd.flatname and s.projectname=fd.OfBuilding\n"
//                            + "where fd.FlatId='" + customid + "' and fd.wingnum='" + wings + "' and (s.isdelete='NO' or s.isdelete is null)");
                    
                    //get wing detail begin here
                    List<FlatDetails> flatlist=viewService.getanyhqldatalist("from flatsdetails where flatid='"+customid+"'");

                    List<Map<String, Object>> customidList = viewService.getanyjdbcdatalist("SELECT s.date as Sdate,s.name as Sname,s.signupid as signupid,s.sqrfeet as Ssquarfeet,s.total as Stotal,fd.Status as status,fd.flatname as flatname \n"
                            + "FROM flatsdetails fd \n"
                            + "left join signupmaster s on s.flatnum=fd.flatname and s.projectname=fd.OfBuilding\n"
                            + "where fd.FlatId='" + customid + "' and fd.wingnum='" + flatlist.get(0).getWingnum() + "' and (s.isdelete='NO' or s.isdelete is null)");
                    Map<String, Object> setflat = new HashMap<String, Object>();

                    if (customidList.isEmpty() || customidList.get(0).get("flatname") == null) {
                        setflat.put("status", "UNSOLD");
                        setflat.put("flatname", "NONE");
                        setflat.put("customid", customid);
                    } else {
                        setflat.put("sdate", customidList.get(0).get("Sdate"));
                        setflat.put("sname", customidList.get(0).get("Sname"));
                        setflat.put("ssquarfeet", customidList.get(0).get("Ssquarfeet"));
                        setflat.put("stotal", customidList.get(0).get("Stotal"));
                        setflat.put("signupid", customidList.get(0).get("signupid"));
                        setflat.put("status", customidList.get(0).get("status"));
                        setflat.put("flatname", customidList.get(0).get("flatname"));
                        setflat.put("customid", customid);
                    }
                    flatList.add(setflat);
                    setmapfloor.put("flatdt", flatList);

                }
                floorList.add(setmapfloor);
                setmap.put("floorsdt", floorList);
            }

            buildingList.add(setmap);
        }
        modelAndView.addObject("buildingdt", buildingList);
//        System.out.println("the list is :"+buildingList);

        String json = new Gson().toJson(buildingList);
        System.out.println("the list is :" + json);

        return modelAndView;
    }

    //code to get flatdetials in ajax dialog on building view page here
    @RequestMapping(value = "getflatdetails", method = RequestMethod.POST)
    public void getflatdetails(@RequestParam(value = "id") String areaId, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from flatsdetails where flatid='" + areaId + "' and isdelete='NO'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //code to get flat area/rewuirment table in ajax dialog on building view page here
    @RequestMapping(value = "getflatareadetails", method = RequestMethod.POST)
    public void getflatareadetails(@RequestParam(value = "id") String areaId, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from projectrequirement where projectid='" + areaId + "' and requirement is not null and requirement<>''");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    @RequestMapping(value = "updateflatdetails")
    public String updateflatdetails(@ModelAttribute FlatDetails flatDetails,
            @RequestParam(value = "redirectprojid") String projectid,
            @RequestParam(value = "redirectfloorscount") String floors,
            @RequestParam(value = "redirectwings") String wing) {
        updateService.updateanyhqlquery("update flatsdetails set bhk='" + flatDetails.getBhk() + "',price='" + flatDetails.getPrice() + "',status='" + flatDetails.getStatus() + "',modifydate=now(),flatname='" + flatDetails.getFlatname() + "' where flatid='" + flatDetails.getFlatid() + "'");
        return "redirect:showbuildingviewofprojects?projectid=" + projectid + "&wings=" + wing + "&floorscount=" + floors;
    }

}
