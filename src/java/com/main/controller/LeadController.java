/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.google.gson.Gson;
import com.main.model.LeadMaster;
import com.main.model.LeadSource;
import com.main.model.UserDetails;
import com.main.model.ViciDialComments;
import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
public class LeadController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

    //redirects to view area master grid
    @RequestMapping(value = "viewleadsourcegrid")
    public ModelAndView viewleadsourcegrid() {
        ModelAndView modelAndView = new ModelAndView("ViewLeadSourceGrid");
        modelAndView.addObject("leadsourcedt", viewService.getanyhqldatalist("from leadsource where isdelete='No' order by length(leadsourceid) desc,leadsourceid desc"));
        return modelAndView;
    }

    //code gets data in dialog to update called from ajax
    @RequestMapping(value = "editLeadSourceLink", method = RequestMethod.POST)
    public void editLeadSourceLink(@RequestParam(value = "id") String areaId, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from leadsource where leadsourceid='" + areaId + "'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //INserts new lead source to leadsource table
    @RequestMapping(value = "addLeadSource")
    public String addLeadSource(@ModelAttribute LeadSource leadSource) {
        String pre = env.getProperty("leadsource");
        String id = pre + insertService.getmaxcount("leadsource", "leadsourceid", 3);
        leadSource.setLeadsourceid(id);
        insertService.insert(leadSource);
        return "redirect:viewleadsourcegrid";
    }

    //code to update leadsource
    @RequestMapping(value = "updateLeadSource")
    public String updateLeadSource(@ModelAttribute LeadSource leadSource) {
        updateService.update(leadSource);
        return "redirect:viewleadsourcegrid";
    }

    //redirects to view LEad Grid page
    @RequestMapping(value = "viewLeadGridLink")
    public String viewLeadGridLink(Map<String, Object> map,
            @RequestParam(value = "recordcnt", required = false) String recordcnt,
            @RequestParam(value = "page", required = false) String page,
            @RequestParam(value = "startpage", required = false) String startpage,
            @RequestParam(value = "txtoldsearch", required = false) String txtoldsearch,
            @RequestParam(value = "txtsearch", required = false) String txtsearch,
            @RequestParam(value = "condition", required = false) String condition,
            @RequestParam(value = "stSearchURL", required = false) String stSearchURL,
            HttpSession session) {

        //code for datatable data here
        String usertype = session.getAttribute("USERTYPE").toString();
        String userid = session.getAttribute("USERID").toString();
        String projectname = session.getAttribute("USERPROJECT").toString();
        String query1 = "";
        String query2 = "";
        String orderdt = " ORDER BY length(leadid) desc,leadid desc";
        if (usertype.equals("Sales Executive") || usertype.equals("Sales Manager") || usertype.equals("Project Manager")) {
            query1 = "select distinct leadid from leadmaster where leadowner='" + userid + "' and isdelete='NO'";
            query2 = "select distinct leadmaster.* from leadmaster where leadowner='" + userid + "' and isdelete='NO'";
        } else if (usertype.equals("Calling Executive")) {
            query1 = "select distinct leadid from leadmaster where leadowner='" + userid + "' and isdelete='NO' order by Date desc";
            query2 = "select distinct leadmaster.* from leadmaster where leadowner='" + userid + "' and isdelete='NO' order by Date desc";
        } else if (usertype.equals("Loan Manager")) {
            query1 = "select distinct leadid from leadmaster where loan='Yes' and isdelete='NO' order by cast(substring(leadid,3,char_length(leadid))as decimal(10,0)) desc";
            query2 = "select distinct leadmaster.* from leadmaster where loan='Yes' and isdelete='NO' order by cast(substring(leadid,3,char_length(leadid))as decimal(10,0)) desc";
        } else if (usertype.equals("Broker")) {
            query1 = "SELECT distinct leadid FROM leadmaster where (broker='" + userid + "' or leadowner='" + userid + "') and isdelete='NO' order by cast(substring(leadid,3,char_length(leadid))as decimal(10,0)) desc";
            query2 = "SELECT distinct leadmaster.* FROM leadmaster where (broker='" + userid + "' or leadowner='" + userid + "') and isdelete='NO' order by cast(substring(leadid,3,char_length(leadid))as decimal(10,0)) desc";
        } else if (usertype.equals("Builder")) {
            query1 = "select distinct leadid from leadmaster where projectname='" + projectname + "' and isdelete='NO' order by cast(substring(leadid,3,char_length(leadid))as decimal(10,0)) desc";
            query2 = "select distinct leadmaster.* from leadmaster where projectname='" + projectname + "' and isdelete='NO' order by cast(substring(leadid,3,char_length(leadid))as decimal(10,0)) desc";
        } else if (usertype.equals("Admin") || usertype.equals("Calling Executive Manager")) {
            query1 = "select distinct leadid from leadmaster where isdelete='NO'";
            query2 = "select distinct leadmaster.* from leadmaster where isdelete='NO'";
        } else {
            query1 = "select distinct leadid from leadmaster where leadid='abc'";
            query2 = "select distinct leadmaster.* from leadmaster where leadid='abc'";
        }

        int substringvalue = env.getProperty("userid").length();

        FillGrid(map, recordcnt, page, startpage, txtoldsearch, txtsearch, condition, "", stSearchURL,
                query1, query2, "leadid", "leadid", "leaddt", substringvalue, orderdt);
        return "ViewLeadGrid";
    }

    //code to insert new lead
    @RequestMapping(value = "addLeadLink")
    public ModelAndView addLeadLink() {
        ModelAndView modelAndView = new ModelAndView("AddLead");
        modelAndView.addObject("userdt", viewService.getanyhqldatalist("from userdetails where type='Broker' and isdelete='NO'"));
//        modelAndView.addObject("sourcedt", viewService.getanyhqldatalist("FROM leadsource where isdelete='NO'"));
        modelAndView.addObject("executivedt", viewService.getanyhqldatalist("FROM userdetails where isdelete='NO' and type='Calling Executive'"));
        modelAndView.addObject("projectdt", viewService.getanyhqldatalist("FROM projectmaster where isdelete='NO'"));
        return modelAndView;
    }

    //code gets data in dialog to update called from ajax
    @RequestMapping(value = "getrequirements", method = RequestMethod.POST)
    public void getrequirements(@RequestParam(value = "projectid") String projectid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from projectrequirement where projectid='" + projectid + "' and isdelete='NO'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to add new broker
    @RequestMapping(value = "addBroker")
    public String addBroker() {
        return "AddBroker";
    }

//    inserts new broker in userdetails page
    @RequestMapping(value = "insertBroker")
    public String insertBroker(@ModelAttribute UserDetails userDetails) {
        String pre = env.getProperty("userid");
        String id = pre + insertService.getmaxcount("userdetails", "id", 4);
        userDetails.setId(id);
        insertService.insert(userDetails);
        return "redirect:addLeadLink";
    }

    //insert lead code begins here
    @RequestMapping(value = "insertLead")
    public String insertLead(@ModelAttribute LeadMaster leadMaster) throws UnsupportedEncodingException, MalformedURLException, IOException {
        String pre = env.getProperty("leadmaster");
        String id = pre + insertService.getmaxcount("leadmaster", "leadid", 3);
        leadMaster.setLeadid(id);
//        leadMaster.setSalesexceutive("");
        insertService.insert(leadMaster);

        //some sms code send here
        String userid = "2000133894";
        String password = "123456";
        String msg = "Welcome To Jain Estate.We Are Happy To Help You.";
        String mURL = "http://enterprise.smsgupshup.com/GatewayAPI/rest?method=SendMessage&send_to=" + leadMaster.getMobile() + "&msg=" + URLEncoder.encode(msg, "UTF-8") + "&msg_type=TEXT&userid=" + userid + "&auth_scheme=plain&password=" + password + "&v=1.1&format=text";
        URL url = new URL(mURL);
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
            for (String line; (line = reader.readLine()) != null;) {
                System.out.println(line);
            }
        } finally {

            if (reader != null) {
                try {
                    reader.close();
                    System.out.println("sms is sent");
                } catch (IOException ignore) {
                }

            }
        }
        return "redirect:viewLeadGridLink";
    }

    //edit lead code begin here
    @RequestMapping(value = "editLeadLink")
    public ModelAndView editLeadLink(@RequestParam(value = "id") String id) {
        ModelAndView modelAndView = new ModelAndView("EditLead");
        List<LeadMaster> leadlist = viewService.getanyhqldatalist("from leadmaster where id='" + id + "'");
        modelAndView.addObject("executivedt", viewService.getanyhqldatalist("FROM userdetails where isdelete='NO' and type='Calling Executive'"));
        modelAndView.addObject("brokerdt", viewService.getanyhqldatalist("FROM userdetails where type='Broker' and isdelete='NO'"));
        modelAndView.addObject("projectdt", viewService.getanyhqldatalist("FROM projectmaster where isdelete='NO'"));
        modelAndView.addObject("projectddr", viewService.getanyhqldatalist("FROM projectmaster where projectid='" + leadlist.get(0).getProjectname() + "' and isdelete='NO'"));
        modelAndView.addObject("leaddt", viewService.getanyjdbcdatalist("SELECT l.*, u.name as brokernameJ,ls.LeadName as leadsourcenameJ,p.Name as projectnameJ,p.Requirement as projectreqJ,us.Name as leadownernameJ FROM leadmaster l left join userdetails u on l.broker=u.id left join leadsource ls on l.leadsource=ls.LeadSourceId left join projectmaster p on l.projectname=p.ProjectId left join userdetails us on l.leadowner=us.id  where l.LeadId='" + id + "' and l.isdelete='NO'").get(0));

        modelAndView.addObject("commentsdt", viewService.getanyjdbcdatalist("select c.comments as comments,u.Name as commentsby,c.date as date \n"
                + "from vicidialcomments c \n"
                + "left join userdetails u on c.commentsby=u.id \n"
                + "where c.phonenumber='" + leadlist.get(0).getMobile() + "' and c.isdelete='NO'"));
        return modelAndView;
    }

    //code to update lead begin here
    @RequestMapping(value = "updateLead")
    public String updateLead(@ModelAttribute LeadMaster master) {
        updateService.update(master);
        return "redirect:viewLeadGridLink";
    }

    //Datatable server side processing code goes here
    public Map<String, Object> FillGrid(Map<String, Object> map,
            String recordcnt, String page, String startpage, String txtoldsearch, String txtsearch, String condition, String group_by, String stSearchURL,
            String query1, String query2, String field1, String field2, String mapname, int substringvalue, String orderby) {
        if (recordcnt == null) {
            recordcnt = "10";
        }
        map.put("recordcnt", recordcnt);

        if (page == null || page == "") {
            page = "1";
        }
        map.put("page", page);

        if (startpage == "" || startpage == null) {
            startpage = "1";
        }
        map.put("startpage", startpage);

        if (condition == null) {
            condition = "";
        } else {
            map.put("txtsearch", txtsearch);
            map.put("condition", condition);
            map.put("stSearchURL", stSearchURL);

            condition = condition.replace("null", "");
        }

        if (txtsearch == "" || txtsearch == null) {
            txtsearch = "";

            map.put("txtsearch", "");
            map.put("stSearchURL", "");
        } else {
            if (!txtoldsearch.equals(txtsearch)) {
                page = "1";
                map.put("page", "1");
                startpage = "1";
                map.put("startpage", "1");
            }

            map.put("txtsearch", txtsearch);
            map.put("stSearchURL", stSearchURL);
        }

        int rec_cnt = Integer.parseInt(recordcnt);

        map.put("pagecnt", viewService.Get_Page_Count(query1 + condition + group_by, rec_cnt));

        int pg = 0;
        int min = 0;
        if (page == null) {
            pg = 1;
            min = 0;
        } else {
            pg = Integer.parseInt(page);
            min = (pg - 1) * rec_cnt;
        }

        int record_cnt = viewService.Get_Record_Count(query1 + condition + group_by + orderby);

        //map.put("tabledetails", viewService.Get_JDBC_DataList("select distinct * from tabledemo LIMIT " + min + ", " + rec_cnt));
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        list = viewService.getanyjdbcdatalist(query1 + condition + group_by + orderby + " LIMIT " + min + ", " + rec_cnt);
        if (list.size() > 0) {
            int cnt = list.size();
            int min_id = Integer.parseInt(list.get(0).get(field1).toString().replaceAll("[^0-9]", ""));
            int max_id = Integer.parseInt(list.get(cnt - 1).get(field1).toString().replaceAll("[^0-9]", ""));
            if (max_id > min_id) {
                map.put(mapname, viewService.getanyjdbcdatalist(query2 + " and CAST(SUBSTRING(" + field2 + " FROM " + substringvalue + ") AS UNSIGNED) BETWEEN " + min_id + " AND " + max_id + " " + condition + group_by + " ORDER BY length(leadid) desc,leadid desc"));
            } else if (min_id > max_id) {
                map.put(mapname, viewService.getanyjdbcdatalist(query2 + " and CAST(SUBSTRING(" + field2 + " FROM " + substringvalue + ") AS UNSIGNED) BETWEEN " + max_id + " AND " + min_id + " " + condition + group_by + " ORDER BY length(leadid) desc,leadid desc"));
            } else {
                map.put(mapname, viewService.getanyjdbcdatalist(query2 + " and CAST(SUBSTRING(" + field2 + " FROM " + substringvalue + ") AS UNSIGNED) BETWEEN " + min_id + " AND " + max_id + " " + condition + group_by + " ORDER BY length(leadid) desc,leadid desc"));
            }

        }

        map.put("recdet", "Showing " + String.valueOf(min + 1) + " to " + String.valueOf(min + list.size()) + " of " + String.valueOf(record_cnt) + " entries");

        if (list.size() == 0) {
            map.put("recdet", "Showing 0 to 0 of 0 entries");
        }

        return map;
    }

    @RequestMapping(value = "insertVicidialComments")
    public String insertVicidialComments(@ModelAttribute ViciDialComments vdc,@RequestParam(value = "editleadid")String leadid) {
        insertService.insert(vdc);
        return "redirect:editLeadLink?id="+leadid;
    }

}
