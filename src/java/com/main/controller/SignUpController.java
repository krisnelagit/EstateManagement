/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.google.gson.Gson;
import com.main.model.ProjectMaster;
import com.main.model.ProjectRequirement;
import com.main.model.SignupMaster;
import com.main.model.SignupPaymentDetails;
import com.main.model.SignupSlabs;
import com.main.model.UserDetails;
import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
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
public class SignUpController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

    //redirects to view area master grid
    @RequestMapping(value = "viewSignupPaymentgridLink")
    public ModelAndView viewSignupPaymentgridLink(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("ViewSignUpPaymentGrid");

        String isaccountmanager = "No";
        String query = "";
        if (session.getAttribute("USERTYPE").equals("Project Accounts Manager")) {
            isaccountmanager = "Yes";
        }

        if (isaccountmanager.equals("No")) {
            query = "";
        }

        modelAndView.addObject("projectdt", viewService.getanyjdbcdatalist("SELECT p.*,b.name as buildernameJ \n"
                + "FROM projectmaster p \n"
                + "inner join  userdetails b on b.id =p.BuilderName\n"
                + "where p.isdelete='NO'"));
        return modelAndView;
    }

    //redirects to view area master grid
    @RequestMapping(value = "viewsignupGridLink")
    public ModelAndView viewsignupGridLink(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("ViewSignUpGrid");

        String user = session.getAttribute("USERTYPE").toString();
        String userid = session.getAttribute("USERID").toString();
        List<Map<String, Object>> signupdataList = new ArrayList<Map<String, Object>>();
        if (user.equals("Admin") || user.equals("Calling Executive Manager")) {
            signupdataList = viewService.getanyjdbcdatalist("SELECT s.*,p.Name as projN,s.total - sum(ifnull(sp.paidamount,0)) as balance FROM signupmaster s left join projectmaster p on s.projectname=p.ProjectId left join signup_paymentdetails sp on sp.UserId=s.signupid where s.isdelete='NO' group by s.signupid order by cast(substring(s.signupid,3,char_length(s.signupid))as decimal(10,0)) desc");
        } else if (user.equals("Sign Up Manager")) {
            signupdataList = viewService.getanyjdbcdatalist("SELECT  s . *,p.Name as projN,s.total - sum(ifnull(sp.paidamount, 0)) as balance\n"
                    + "FROM signupmaster \n"
                    + "left join projectmaster p ON s.projectname = p.ProjectId\n"
                    + "left join signup_paymentdetails sp ON sp.UserId = s.signupid\n"
                    + "left join detailsofprojectandarea dp on s.leadowner=dp.userid\n"
                    + "where s.isdelete = 'NO' and s.leadowner='" + userid + "'\n"
                    + "group by s.signupid\n"
                    + "order by cast(substring(s.signupid,3,char_length(s.signupid)) as decimal (10 , 0 )) desc");
        } else {
            signupdataList = viewService.getanyjdbcdatalist("SELECT s.*,p.Name as projN,s.total - sum(ifnull(sp.paidamount,0)) as balance \n"
                    + "FROM signupmaster s \n"
                    + "left join projectmaster p on s.projectname=p.ProjectId \n"
                    + "left join signup_paymentdetails sp on sp.UserId=s.signupid \n"
                    + "where s.leadowner='" + userid + "' and s.isdelete='NO' \n"
                    + "group by s.signupid \n"
                    + "order by cast(substring(s.signupid,3,char_length(s.signupid))as decimal(10,0)) desc");
        }

        modelAndView.addObject("signupdt", signupdataList);
        return modelAndView;
    }

    //redirect to add signup link
    @RequestMapping(value = "addsignupLink")
    public ModelAndView addsignupLink() {
        ModelAndView modelAndView = new ModelAndView("AddSignup");
        modelAndView.addObject("salesexcdt", viewService.getanyhqldatalist("FROM userdetails where type='Sales Executive' and isdelete='NO'"));
        modelAndView.addObject("brokerdt", viewService.getanyhqldatalist("FROM userdetails where type='Broker' and isdelete='NO'"));
        modelAndView.addObject("projectdt", viewService.getanyhqldatalist("FROM projectmaster where isdelete='NO'"));
        return modelAndView;
    }

    //code to get requiremetn sqrfeet for add sugnup page
    @RequestMapping(value = "getsignuprequirements", method = RequestMethod.POST)
    public void getsignuprequirements(@RequestParam(value = "projectid") String projectid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("FROM projectrequirement where projectid='" + projectid + "' and isdelete='NO'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //code to get jepercent for add sugnup page
    @RequestMapping(value = "getsignupjepercent", method = RequestMethod.POST)
    public void getsignupjepercent(@RequestParam(value = "projectid") String projectid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("FROM projectmaster where projectid='" + projectid + "' and isdelete='NO'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //code to get slab details for add sugnup page
    @RequestMapping(value = "getslabdetails", method = RequestMethod.POST)
    public void getslabdetails(@RequestParam(value = "projectid") String projectid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("FROM slab_master where project_requirement_id='" + projectid + "' and isdelete='NO'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //code to get wing and flat details code begin here
    @RequestMapping(value = "getwingsqrfeets", method = RequestMethod.POST)
    public void getwingsqrfeets(@RequestParam(value = "projectid") String projectid, @RequestParam(value = "requirement") String requirement, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("FROM projectrequirement where projectid='" + projectid + "' and requirement='" + requirement + "' and isdelete='NO'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //code to get wing and flat details code begin here
    @RequestMapping(value = "getwingdetails", method = RequestMethod.POST)
    public void getwingdetails(@RequestParam(value = "projectid") String projectid, @RequestParam(value = "requirement") String requirement, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("FROM flatsdetails where ofbuilding='" + projectid + "' and bhk='" + requirement + "' and isdelete='NO' group by wingnum");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //code to get wing and flat details code begin here
    @RequestMapping(value = "getBuildingwingdetails", method = RequestMethod.POST)
    public void getBuildingwingdetails(@RequestParam(value = "projectid") String projectid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("FROM projectmaster where projectid='" + projectid + "' and isdelete='NO'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //code to get wing and flat details code begin here
    @RequestMapping(value = "getBuildingviewdetails", method = RequestMethod.POST)
    public void getBuildingviewdetails(@RequestParam(value = "projectid") String projectid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<ProjectMaster> projectlist = viewService.getanyhqldatalist("from projectmaster where projectid='" + projectid + "' and isdelete='NO'");
        int wings = Integer.parseInt(projectlist.get(0).getWings());
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
//                    int flatid = i+1;
                    String customid = projectid + i + "F" + j + "R" + k;
//                    List<Map<String, Object>> customidListd = viewService.getanyjdbcdatalist("SELECT s.date as Sdate,s.name as Sname,s.signupid as signupid,s.sqrfeet as Ssquarfeet,s.total as Stotal,fd.Status as status,fd.flatname as flatname \n"
//                            + "FROM flatsdetails fd \n"
//                            + "left join signupmaster s on s.flatnum=fd.flatname and s.projectname=fd.OfBuilding\n"
//                            + "where fd.FlatId='" + customid + "' and fd.wingnum='" + flatid + "' and (s.isdelete='NO' or s.isdelete is null)");

                    List<Map<String, Object>> customidList = viewService.getanyjdbcdatalist("SELECT s.date as Sdate,s.name as Sname,s.signupid as signupid,s.sqrfeet as Ssquarfeet,s.total as Stotal,fd.Status as status,fd.bhk as srequirement,fd.flatname as flatname \n"
                            + "FROM flatsdetails fd \n"
                            + "left join signupmaster s on s.flatnum=fd.flatname and s.projectname=fd.OfBuilding\n"
                            + "where fd.FlatId='" + customid + "' and (s.isdelete='NO' or s.isdelete is null)");
//                    List<Map<String, Object>> customidList = viewService.getanyjdbcdatalist("SELECT s.date as Sdate,s.name as Sname,s.signupid as signupid,s.sqrfeet as Ssquarfeet,s.total as Stotal,fd.Status as status,fd.flatname as flatname \n"
//                            + "FROM flatsdetails fd \n"
//                            + "left join signupmaster s on s.flatnum=fd.flatname and s.projectname=fd.OfBuilding\n"
//                            + "where fd.FlatId='" + customid + "' and fd.wingnum='" + flatid + "' and (s.isdelete='NO' or s.isdelete is null)");
                    Map<String, Object> setflat = new HashMap<String, Object>();

                    if (customidList.isEmpty() || customidList.get(0).get("flatname") == null) {
                        setflat.put("status", "UNSOLD");
                        setflat.put("flatname", "NONE");
                        setflat.put("customid", customid);
                    } else {
                        setflat.put("sdate", customidList.get(0).get("Sdate"));
                        setflat.put("sname", customidList.get(0).get("Sname"));
                        setflat.put("ssquarfeet", customidList.get(0).get("Ssquarfeet"));
                        setflat.put("srequirement", customidList.get(0).get("srequirement"));
                        setflat.put("stotal", customidList.get(0).get("Stotal"));
                        setflat.put("signupid", customidList.get(0).get("signupid"));
                        setflat.put("status", customidList.get(0).get("status"));
                        setflat.put("flatname", customidList.get(0).get("flatname"));
                        setflat.put("customid", customid);

                        //code to get area square fet details begin here
                        List<ProjectRequirement> projectarealist = viewService.getanyhqldatalist("from projectrequirement where requirement='" + customidList.get(0).get("srequirement") + "' and projectid='" + projectid + "'");
                        setflat.put("saleablearea", projectarealist.get(0).getSqrfeets());
                        setflat.put("carpetarea", projectarealist.get(0).getCarpet());
                        //code to get area square fet details ends! here
                    }
                    flatList.add(setflat);
                    setmapfloor.put("flatdt", flatList);

                }
                floorList.add(setmapfloor);
                setmap.put("floorsdt", floorList);
            }

            buildingList.add(setmap);
        }
        jsondata = new Gson().toJson(buildingList);
        System.out.println("the list is :" + jsondata);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //code to get wing and flat details code begin here
    @RequestMapping(value = "getsignupavailableflats", method = RequestMethod.POST)
    public void getsignupavailableflats(@RequestParam(value = "projectid") String projectid, @RequestParam(value = "requirement") String requirement, @RequestParam(value = "wing") String wing, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyjdbcdatalist("select flatname from flatsdetails where OfBuilding='" + projectid + "' and BHK='" + requirement + "' and wingnum='" + wing + "' \n"
                + "and flatname not in(select flatnum from signupmaster where projectname='" + projectid + "' and isdelete='NO')");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //code to get wing and flat details code begin here
    @RequestMapping(value = "getslabprojectrequirement", method = RequestMethod.POST)
    public void getslabprojectrequirement(@RequestParam(value = "projectid") String projectid, @RequestParam(value = "slab_master_id") String slab_master_id, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from slab_master_details where slab_master_id=" + slab_master_id + " and isdelete='NO'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //code to insert begins here
    @RequestMapping(value = "insertsignup")
    public String insertsignup(@ModelAttribute SignupMaster signupMaster,
            @RequestParam(value = "txtProjectSlabADD") String[] slabname,
            @RequestParam(value = "txtProjectSlabpercentADD") String[] slabpercent,
            @RequestParam(value = "txtProjectSlabrateADD") String[] slabrate) {
        String pre = env.getProperty("signupmaster");
        String id = pre + insertService.getmaxcount("signupmaster", "signupid", 3);
        signupMaster.setSignupid(id);
        insertService.insert(signupMaster);
        //update flatdetails 
        updateService.updateanyhqlquery("update flatsdetails set status='SOLD' where ofbuilding='" + signupMaster.getProjectname() + "' and bhk='" + signupMaster.getRequirement() + "' and flatname='" + signupMaster.getFlatnum() + "' and wingnum='" + signupMaster.getWingnum() + "'");
        //code to insert signup slab details here
        if (slabname != null && slabpercent != null && slabrate != null) {
            for (int i = 1; i < slabname.length; i++) {
                SignupSlabs slabs = new SignupSlabs();
                String pre2 = env.getProperty("signupslabs");
                String id2 = pre2 + insertService.getmaxcount("signupslabs", "id", 5);
                slabs.setId(id2);
                slabs.setSlabname(slabname[i]);
                slabs.setSlabpercent(slabpercent[i]);
                slabs.setRate(slabrate[i]);
                slabs.setSignupid(id);
                insertService.insert(slabs);
            }
        }
        return "redirect:addsignupLink";
    }

    //redirect to add new broker signup
    @RequestMapping(value = "addSignUpBroker")
    public String addBroker() {
        return "AddBrokerSignup";
    }

//    inserts new broker in userdetails page
    @RequestMapping(value = "insertSignUpBroker")
    public String insertBroker(@ModelAttribute UserDetails userDetails) {
        String pre = env.getProperty("userid");
        String id = pre + insertService.getmaxcount("userdetails", "id", 4);
        userDetails.setId(id);
        insertService.insert(userDetails);
        return "redirect:addsignupLink";
    }

    //code gets data in dialog to update called from ajax
    @RequestMapping(value = "getbrokerage", method = RequestMethod.POST)
    public void getbrokerage(@RequestParam(value = "brokerid") String brokerid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("FROM userdetails where id='" + brokerid + "' and isdelete='NO'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //code for editing signup slabs begin here
    @RequestMapping(value = "editsignupslabs")
    public ModelAndView editsignupslabs(@RequestParam(value = "signupid") String signupid, @RequestParam(value = "total") String total) {
        ModelAndView modelAndView = new ModelAndView("EditSignupSlabs");
        List<Map<String, Object>> signupslabList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> theList = viewService.getanyjdbcdatalist("SELECT s.*,ifnull(sum(sp.paidamount),0) as totalslabpaid FROM signupslabs s \n"
                + "left join signup_paymentdetails sp on sp.slab=s.id\n"
                + "where s.signupid='" + signupid + "' and s.isdelete='NO' \n"
                + "group by s.id");

        double totalrate = 0, totalbalance = 0, totalpaid = 0;

        for (int i = 0; i < theList.size(); i++) {
            Map<String, Object> setMap = new HashMap<String, Object>();
            double hold = 0, paid = 0, rate = 0, bal = 0;
            setMap.put("slabname", theList.get(i).get("slabname"));
            setMap.put("slabpercent", theList.get(i).get("slabpercent"));
            setMap.put("slabrate", theList.get(i).get("rate"));
            setMap.put("slabid", theList.get(i).get("id"));
            setMap.put("slabtotal", theList.get(i).get("totalslabpaid"));
            if (setMap.get("slabname") != null && !setMap.get("slabname").equals("null")) {
                rate = Double.parseDouble(setMap.get("slabrate").toString());
                totalrate += rate;
                totalpaid += Double.parseDouble(setMap.get("slabtotal").toString());
                paid = Double.parseDouble(setMap.get("slabtotal").toString()) - hold;
                if (rate < paid) {
                    hold = rate - paid;
                    bal = 0;
                } else {
                    bal = rate - paid;
                    hold = 0;
                }
                totalbalance += bal;
            }
            setMap.put("slabbalance", bal);
            signupslabList.add(setMap);
        }
        modelAndView.addObject("signupslabsdt", signupslabList);
        modelAndView.addObject("totalrate", totalrate);
        modelAndView.addObject("totalbalance", totalbalance);
        modelAndView.addObject("totalpaid", totalpaid);
        modelAndView.addObject("requesttotal", total);
        return modelAndView;
    }

    //CODE TO update signup slabs begin here
    @RequestMapping(value = "updateSignupslabs")
    public String updateSignupslabs(@RequestParam(value = "txtslabid") String[] slabid,
            @RequestParam(value = "txtslabname") String[] slabname,
            @RequestParam(value = "txtslabrate") String[] slabrate,
            @RequestParam(value = "txtslabpercent") String[] slabpercent) {

        if (slabid != null && slabname != null && slabpercent != null && slabpercent != null) {
            for (int i = 0; i < slabid.length; i++) {
                updateService.updateanyhqlquery("update signupslabs set slabpercent='" + slabpercent[i] + "', rate='" + slabrate[i] + "',modifydate=now() where id='" + slabid[i] + "'");
            }
        }

        return "redirect:viewsignupGridLink";
    }

    //code for adding payment in signup master begins here
    @RequestMapping(value = "addSignupPayment")
    public ModelAndView addSignupPayment(@RequestParam(value = "Callerid") String signupid, @RequestParam(value = "signup") String signup) {
        ModelAndView modelAndView = new ModelAndView("AddSignupPayment");

        String totalno, incentives, paid, status = "UNPAID", name = null;
        double totalamount, totaincentives, totalpaid, total = 0, balance = 0;
        //code to get some general values>> obtained for calculation
        List<Map<String, Object>> theList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> calculationList = viewService.getanyjdbcdatalist("select s.total as totalamount,sum(ifnull(sp.paidamount,0)) as totalpaid,s.date,s.name,s.signupid \n"
                + "from signupmaster s \n"
                + "left join signup_paymentdetails sp on sp.UserId=s.signupid where s.signupid='" + signupid + "'\n"
                + "group by s.signupid");

        Map<String, Object> setMap = new HashMap<String, Object>();
        setMap.put("name", calculationList.get(0).get("name"));
        setMap.put("total", calculationList.get(0).get("totalamount"));

        paid = calculationList.get(0).get("totalpaid").toString();
        if (paid == null || paid.equals("null")) {
            paid = "0";
        }
        totalpaid = Double.parseDouble(paid);
        totalamount = Double.parseDouble(setMap.get("total").toString());
        balance = totalamount - totalpaid;

        setMap.put("balance", balance);
        theList.add(setMap);
        modelAndView.addObject("paymentdt", theList.get(0));

        //code for option tag values
        modelAndView.addObject("selectslabdt", viewService.getanyjdbcdatalist("SELECT s.*,ifnull(sum(sp.paidamount),0) as totalslabpaid FROM signupslabs s \n"
                + "left join signup_paymentdetails sp on sp.slab=s.id\n"
                + "where s.signupid='" + signupid + "' and s.isdelete='NO' \n"
                + "group by s.id"));
        //code required for payment insert ends here!!!!

        //now code for payment details datatable begins here
        modelAndView.addObject("signuppaymetdt", viewService.getanyhqldatalist("from signup_paymentdetails where userid='" + signupid + "' and isdelete='NO'"));

        return modelAndView;
    }

    //code to insert in SIGNUP PAYMENT DETAILS BEGINS HERE
    @RequestMapping(value = "insertSignupPayment")
    public String insertSignupPayment(@ModelAttribute SignupPaymentDetails paymentDetails,
            @RequestParam(value = "paychequeno") String paychequeno,
            @RequestParam(value = "paybankname") String paybankname,
            @RequestParam(value = "onlinepay") String onlinepay,
            @RequestParam(value = "page") String page,
            @RequestParam(value = "slabname") String slabnameandamount) {

        String showslab = "", slabid = "";
        String slabname1[] = slabnameandamount.split(",");
        String slabname = slabname1[0];
        String slabOGamt = slabname1[1];
        slabid = slabname1[2];
        if (Integer.parseInt(paymentDetails.getPaidamount().toString()) > Integer.parseInt(slabOGamt)) {
            showslab = slabname + " and other";
        } else {
            showslab = slabname;
        }
        if (paymentDetails.getPaymentmode().equals("Cash")) {
            paymentDetails.setChequeno("not a cheque");
            paymentDetails.setBankname("not a cheque");
            paymentDetails.setOnlinepay("NO");
            paymentDetails.setReceived("Yes");
            paymentDetails.setCleared("Yes");
            paymentDetails.setDeposit("Yes");
        } else if (paymentDetails.getPaymentmode().equals("Cheque")) {
            paymentDetails.setChequeno(paychequeno);
            paymentDetails.setBankname(paybankname);
            paymentDetails.setOnlinepay("NO");
            paymentDetails.setReceived("Yes");
            paymentDetails.setCleared("Yes");
            paymentDetails.setDeposit("No");
        } else if (paymentDetails.getPaymentmode().equals("Online Payment")) {
            paymentDetails.setChequeno("not a cheque");
            paymentDetails.setBankname("not a cheque");
            paymentDetails.setOnlinepay(onlinepay);
            paymentDetails.setReceived("Yes");
            paymentDetails.setCleared("Yes");
            paymentDetails.setDeposit("Yes");
        }
        String pre = env.getProperty("signup_paymentdetails");
        String id = pre + insertService.getmaxcount("signup_paymentdetails", "paymentdetailsid", 3);
        paymentDetails.setPaymentdetailsid(id);
        paymentDetails.setSlab(slabid);
        paymentDetails.setShowslab(showslab);
        insertService.insert(paymentDetails);
        if (page.equals("no")) {
            return "redirect:viewsignupGridLink";
        } else {
            return "redirect:addSignupPayment?Callerid=" + paymentDetails.getUserid() + "&signup=yes";
        }
    }

    //code for update on add payment page to add received and cleared details to the signup_payment details table
    @RequestMapping(value = "updaterecievedandcleared")
    public String updaterecievedandcleared(@RequestParam(value = "callerid") String paymentdetailsid,
            @RequestParam(value = "passwd") String passwd,
            @RequestParam(value = "btnColor") String btnColor,
            @RequestParam(value = "usrid") String Callerid,
            @RequestParam(value = "btnName") String btnName, HttpSession session) {

        if (session.getAttribute("PASSWD").toString().equals(passwd)) {
            String query = "";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HHmmss");
            Date date = Calendar.getInstance().getTime();
            if (btnName.equals("Received")) {
                query = "UPDATE signup_paymentdetails SET received ='" + btnColor + "' , receivedDate = '" + sdf.format(date) + "'\n"
                        + "WHERE paymentdetailsid = '" + paymentdetailsid + "'";
            } else if (btnName.equals("Cleared")) {
                query = "UPDATE  signup_paymentdetails SET cleared= '" + btnColor + "', clearedDate = '" + sdf.format(date) + "'\n"
                        + "WHERE paymentdetailsid = '" + paymentdetailsid + "'";
            } else if (btnName.equals("Deposit")) {
                query = "UPDATE  signup_paymentdetails SET deposit= '" + btnColor + "', clearedDate = '" + sdf.format(date) + "'\n"
                        + "WHERE paymentdetailsid = '" + paymentdetailsid + "'";
            }
            updateService.updateanyhqlquery(query);
            return "redirect:addSignupPayment?Callerid=" + Callerid + "&signup=yes";
        } else {
            session.setAttribute("passnot", "passnot");
            return "redirect:viewsignupGridLink";
        }
    }

    @RequestMapping(value = "printSignupPayment")
    public ModelAndView printSignupPayment(@RequestParam(value = "signupid") String signupid,
            @RequestParam(value = "printdate") String[] printdate,
            @RequestParam(value = "printcheque") String[] printcheque,
            @RequestParam(value = "printbank") String[] printbank,
            @RequestParam(value = "printamt") String[] printamt,
            @RequestParam(value = "print") String[] print) {
        ModelAndView modelAndView = new ModelAndView("PrintSignupPayment");

        modelAndView.addObject("signupmasterdt", viewService.getanyjdbcdatalist("SELECT s.name,s.wingnum,s.flatnum,sqrfeet,p.Name as projectname FROM signupmaster s \n"
                + "left join projectmaster p on p.ProjectId=s.projectname \n"
                + "where s.signupid='" + signupid + "' and s.IsDelete='NO' and p.IsDelete='NO'").get(0));
        List<Map<String, Object>> printlist = new ArrayList<Map<String, Object>>();
        int amt = 0, totalamt = 0;
        if (print != null) {
            for (int i = 0; i < print.length; i++) {
                Map<String, Object> setMap = new HashMap<String, Object>();
                String bankname = "";
                if (print[i].equals("true")) {
                    amt = Integer.parseInt(printamt[i]);
                    totalamt += amt;
                    if (printbank[i].equals("not a cheque")) {
                        bankname = "cash";
                    } else {
                        bankname = printbank[i];
                    }
                    setMap.put("bankname", bankname);
                    setMap.put("printcheque", printcheque[i]);
                    setMap.put("printdate", printdate[i]);
                    setMap.put("printamt", printamt[i]);
                    printlist.add(setMap);
                }
            }
        }
        modelAndView.addObject("printdt", printlist);
        modelAndView.addObject("totalamt", totalamt);
        return modelAndView;
    }

    @RequestMapping(value = "editSignuplink")
    public ModelAndView editSignuplink(@RequestParam(value = "signupid") String signupid) {
        ModelAndView modelAndView = new ModelAndView("EditSignup");
        modelAndView.addObject("salesexcdt", viewService.getanyhqldatalist("FROM userdetails where type='Sales Executive' and isdelete='NO'"));
        modelAndView.addObject("brokerdt", viewService.getanyhqldatalist("FROM userdetails where type='Broker' and isdelete='NO'"));
        modelAndView.addObject("projectdt", viewService.getanyhqldatalist("FROM projectmaster where isdelete='NO'"));
        //code to get requirement according to project begin here
        List<Map<String, Object>> signuplist = viewService.getanyjdbcdatalist("select s.*, u.name as brokernameJ,p.Name as projectnameJ,us.Name as leadownernameJ from signupmaster s left join userdetails u on s.broker=u.id left join projectmaster p on s.projectname=p.ProjectId left join userdetails us on s.leadowner=us.id where s.signupid='" + signupid + "' and s.isdelete='NO'");
        modelAndView.addObject("requirementdt", viewService.getanyhqldatalist("FROM projectrequirement where projectid='" + signuplist.get(0).get("projectname") + "' and isdelete='NO'"));
        modelAndView.addObject("leadownerlist", viewService.getanyhqldatalist("FROM userdetails where type='Calling Executive' and isdelete='NO'"));

        modelAndView.addObject("signupdt", signuplist.get(0));
        return modelAndView;
    }

    //code to update signup here
    @RequestMapping(value = "updatesignup")
    public String updatesignup(@ModelAttribute SignupMaster signupMaster) {
        updateService.update(signupMaster);
        return "redirect:viewsignupGridLink";
    }

    //new signup projectwise grid code begin here Linking later will be changes -sir
    @RequestMapping(value = "viewnewsignupGridLink")
    public ModelAndView viewnewsignupGridLink() {
        ModelAndView modelAndView = new ModelAndView("ViewNewSignupProjectGrid");
        List<ProjectMaster> projectList = viewService.getanyhqldatalist("from projectmaster where isdelete='No' order by length(projectid) desc,projectid desc");
        List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < projectList.size(); i++) {
            List<Map<String, Object>> bookinglist = viewService.getanyjdbcdatalist("SELECT count(projectname) totalbooking FROM signupmaster where projectname='"+projectList.get(i).getProjectid()+"'");
            List<Map<String, Object>> sumlist = viewService.getanyjdbcdatalist("SELECT SUM(total) as totalamount FROM signupmaster where projectname='" + projectList.get(i).getProjectid() + "'");
            List<Map<String, Object>> receiptlist = viewService.getanyjdbcdatalist("SELECT SUM(sgp.paidamount) as totalreceipt\n"
                    + "FROM signup_paymentdetails sgp\n"
                    + "inner join signupslabs sus on sus.id=sgp.slab\n"
                    + "inner join signupmaster sm on sm.signupid=sus.signupid\n"
                    + "where sm.projectname='" + projectList.get(i).getProjectid() + "' and sgp.isdelete='NO' and sus.isdelete='NO' and sm.isdelete='NO'");
            
            Map<String, Object> setMap = new HashMap<String, Object>();
            setMap.put("totalamount", sumlist.get(0).get("totalamount"));
            setMap.put("totalreceipt", receiptlist.get(0).get("totalreceipt"));
            setMap.put("totalbooking", bookinglist.get(0).get("totalbooking"));
            setMap.put("projectid", projectList.get(i).getProjectid());
            setMap.put("projectname", projectList.get(i).getName());
            dataList.add(setMap);
        }
        modelAndView.addObject("projectdt", dataList);
        return modelAndView;
    }
    
    //code for execuive wise singup grid here
    @RequestMapping(value = "viewnewsignupExecutiveGridLink")
    public ModelAndView viewnewsignupExecutiveGridLink(){
        ModelAndView modelAndView = new ModelAndView("ViewNewSignupExecutiveGrid");
        List<UserDetails> executiveList = viewService.getanyhqldatalist("FROM userdetails where type='Sales Executive' and isdelete='NO'");
        List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < executiveList.size(); i++) {
            List<Map<String, Object>> bookinglist = viewService.getanyjdbcdatalist("SELECT count(salesperson) totalbooking FROM signupmaster where salesperson='"+executiveList.get(i).getId()+"'");
            List<Map<String, Object>> sumlist = viewService.getanyjdbcdatalist("SELECT SUM(total) as totalamount FROM signupmaster where salesperson='" + executiveList.get(i).getId() + "'");
            List<Map<String, Object>> receiptlist = viewService.getanyjdbcdatalist("SELECT SUM(sgp.paidamount) as totalreceipt\n"
                    + "FROM signup_paymentdetails sgp\n"
                    + "inner join signupslabs sus on sus.id=sgp.slab\n"
                    + "inner join signupmaster sm on sm.signupid=sus.signupid\n"
                    + "where sm.salesperson='" + executiveList.get(i).getId() + "' and sgp.isdelete='NO' and sus.isdelete='NO' and sm.isdelete='NO'");
            
            Map<String, Object> setMap = new HashMap<String, Object>();
            setMap.put("totalamount", sumlist.get(0).get("totalamount"));
            setMap.put("totalreceipt", receiptlist.get(0).get("totalreceipt"));
            setMap.put("totalbooking", bookinglist.get(0).get("totalbooking"));
            setMap.put("projectid", executiveList.get(i).getId());
            setMap.put("projectname", executiveList.get(i).getName());
            dataList.add(setMap);
        }
        modelAndView.addObject("projectdt", dataList);
        return modelAndView;
    }
    
    //code to view signup details for the project begin here
    @RequestMapping(value = "viewprojectsignupdetails")
    public ModelAndView viewprojectsignupdetails(@RequestParam(value = "id")String projectid,HttpSession session){
        ModelAndView modelAndView=new ModelAndView("ViewSignupProjectDetailsGrid");
        String user = session.getAttribute("USERTYPE").toString();
        String userid = session.getAttribute("USERID").toString();
        List<Map<String, Object>> signupdataList = new ArrayList<Map<String, Object>>();
        if (user.equals("Admin") || user.equals("Calling Executive Manager")) {
            signupdataList = viewService.getanyjdbcdatalist("SELECT s.*,p.Name as projN,s.total - sum(ifnull(sp.paidamount,0)) as balance,ud.name as salespersonname FROM signupmaster s left join projectmaster p on s.projectname=p.ProjectId left join signup_paymentdetails sp on sp.UserId=s.signupid left join userdetails ud on ud.id=s.salesperson where s.projectname='"+projectid+"' and s.isdelete='NO' group by s.signupid order by cast(substring(s.signupid,3,char_length(s.signupid))as decimal(10,0)) desc");
        } else if (user.equals("Sign Up Manager")) {
            signupdataList = viewService.getanyjdbcdatalist("SELECT  s . *,p.Name as projN,s.total - sum(ifnull(sp.paidamount, 0)) as balance,ud.name as salespersonname\n"
                    + "FROM signupmaster \n"
                    + "left join projectmaster p ON s.projectname = p.ProjectId\n"
                    + "left join signup_paymentdetails sp ON sp.UserId = s.signupid\n"
                    + "left join detailsofprojectandarea dp on s.leadowner=dp.userid\n"
                    + "left join userdetails ud on ud.id=s.salesperson\n"
                    + "where s.projectname='"+projectid+"' and s.isdelete = 'NO' and s.leadowner='" + userid + "'\n"
                    + "group by s.signupid\n"
                    + "order by cast(substring(s.signupid,3,char_length(s.signupid)) as decimal (10 , 0 )) desc");
        } else {
            signupdataList = viewService.getanyjdbcdatalist("SELECT s.*,p.Name as projN,s.total - sum(ifnull(sp.paidamount,0)) as balance,ud.name as salespersonname \n"
                    + "FROM signupmaster s \n"
                    + "left join projectmaster p on s.projectname=p.ProjectId \n"
                    + "left join signup_paymentdetails sp on sp.UserId=s.signupid \n"
                    + "left join userdetails ud on ud.id=s.salesperson\n"
                    + "where s.projectname='"+projectid+"' s.leadowner='" + userid + "' and s.isdelete='NO' \n"
                    + "group by s.signupid \n"
                    + "order by cast(substring(s.signupid,3,char_length(s.signupid))as decimal(10,0)) desc");
        }

        modelAndView.addObject("signupdt", signupdataList);
        return modelAndView;
    }
    
    //code to view signup details for the project begin here
    @RequestMapping(value = "viewexecutivesignupdetails")
    public ModelAndView viewexecutivesignupdetails(@RequestParam(value = "id")String executiveid,HttpSession session){
        ModelAndView modelAndView=new ModelAndView("ViewSignupExecutiveDetailsGrid");
        String user = session.getAttribute("USERTYPE").toString();
        String userid = session.getAttribute("USERID").toString();
        List<Map<String, Object>> signupdataList = new ArrayList<Map<String, Object>>();
        if (user.equals("Admin") || user.equals("Calling Executive Manager")) {
            signupdataList = viewService.getanyjdbcdatalist("SELECT s.*,p.Name as projN,s.total - sum(ifnull(sp.paidamount,0)) as balance,ud.name as salespersonname FROM signupmaster s left join projectmaster p on s.projectname=p.ProjectId left join signup_paymentdetails sp on sp.UserId=s.signupid left join userdetails ud on ud.id=s.salesperson where s.salesperson='"+executiveid+"' and s.isdelete='NO' group by s.signupid order by cast(substring(s.signupid,3,char_length(s.signupid))as decimal(10,0)) desc");
        } else if (user.equals("Sign Up Manager")) {
            signupdataList = viewService.getanyjdbcdatalist("SELECT  s . *,p.Name as projN,s.total - sum(ifnull(sp.paidamount, 0)) as balance,ud.name as salespersonname\n"
                    + "FROM signupmaster \n"
                    + "left join projectmaster p ON s.projectname = p.ProjectId\n"
                    + "left join signup_paymentdetails sp ON sp.UserId = s.signupid\n"
                    + "left join detailsofprojectandarea dp on s.leadowner=dp.userid\n"
                    + "left join userdetails ud on ud.id=s.salesperson\n"
                    + "where s.salesperson='"+executiveid+"' and s.isdelete = 'NO' and s.leadowner='" + userid + "'\n"
                    + "group by s.signupid\n"
                    + "order by cast(substring(s.signupid,3,char_length(s.signupid)) as decimal (10 , 0 )) desc");
        } else {
            signupdataList = viewService.getanyjdbcdatalist("SELECT s.*,p.Name as projN,s.total - sum(ifnull(sp.paidamount,0)) as balance,ud.name as salespersonname \n"
                    + "FROM signupmaster s \n"
                    + "left join projectmaster p on s.projectname=p.ProjectId \n"
                    + "left join signup_paymentdetails sp on sp.UserId=s.signupid \n"
                    + "left join userdetails ud on ud.id=s.salesperson\n"
                    + "where s.salesperson='"+executiveid+"' s.leadowner='" + userid + "' and s.isdelete='NO' \n"
                    + "group by s.signupid \n"
                    + "order by cast(substring(s.signupid,3,char_length(s.signupid))as decimal(10,0)) desc");
        }

        modelAndView.addObject("signupdt", signupdataList);
        return modelAndView;
    }

}
