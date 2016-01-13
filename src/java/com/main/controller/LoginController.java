/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.main.model.UserDetails;
import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author pc2
 */
@Controller
public class LoginController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

    @RequestMapping(value = {"/", "Login"})
    public String redirectdemo() {
        return "Login";
    }

    //verify admin login
    @RequestMapping(value = "verifylogin", method = RequestMethod.POST)
    public ModelAndView verifylogind(@RequestParam(value = "username") String username, @RequestParam(value = "password") String password, HttpSession session) {
        ModelAndView modelAndView = null;
        try {
            List<UserDetails> userlist = viewService.getanyhqldatalist("from userdetails where login_id='" + username + "' and password='" + password + "' and isdelete<>'Yes'");
            if (userlist != null && userlist.size() > 0 && userlist.get(0).getLogin_id().equals(username) && userlist.get(0).getPassword().equals(password)) {
                //setting values in seession
                session.setAttribute("USERID", userlist.get(0).getId());
                session.setAttribute("USERNAME", userlist.get(0).getName());
                session.setAttribute("USERTYPE", userlist.get(0).getType());
                session.setAttribute("USERPROJECT", userlist.get(0).getProject());
                session.setAttribute("PASSWD", userlist.get(0).getPassword());

                //chechking for user types
                if (userlist.get(0).getType().equals("Broker")) {
                    session.setAttribute("BROKERAGE", userlist.get(0).getBrokerage());
                    modelAndView = new ModelAndView("redirect:brokerDashboard");
                } else if (userlist.get(0).getType().equals("Admin") || userlist.get(0).getType().equals("Calling Executive Manager")) {
                    modelAndView = new ModelAndView("redirect:adminDashboard");
                } else if (userlist.get(0).getType().equals("Builder")) {
                    modelAndView = new ModelAndView("redirect:builderDashboard");
                } else if (userlist.get(0).getType().equals("Calling Executive") || userlist.get(0).getType().equals("Broker Manager")) {
                    session.setAttribute("USERINCENTIVES", userlist.get(0).getIncentives());
                    modelAndView = new ModelAndView("redirect:callingExecutiveDashboard");
                } else if (userlist.get(0).getType().equals("Sales Executive")) {
                    modelAndView = new ModelAndView("redirect:salesExecutiveDashboard");
                } else if (userlist.get(0).getType().equals("Project Manager")) {
                    modelAndView = new ModelAndView("redirect:projectManagerDashboard");
                } else if (userlist.get(0).getType().equals("Area Manager")) {
                    modelAndView = new ModelAndView("redirect:areaManagerDashboard");
                } else if (userlist.get(0).getType().equals("creator")) {
                    modelAndView = new ModelAndView("redirect:creator");
                } else if (userlist.get(0).getType().equals("Sign Up Manager")) {
                    modelAndView = new ModelAndView("redirect:showsignup");
                } else if (userlist.get(0).getType().equals("Project Accounts Manager")) {
                    modelAndView = new ModelAndView("redirect:setting");
                } else {
                    modelAndView = new ModelAndView("redirect:homepage");
                }
            } else {
                modelAndView = new ModelAndView("Login", "errmsg", "Authentication error please check your username/password");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return modelAndView;
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        if (request.getSession().getAttribute("USERNAME") != null) {
            request.getSession().invalidate();

            return "redirect:/Login";
        }
        return "redirect:" + request.getContextPath() + "/Login";
    }

    //view change password code here
    @RequestMapping(value = "changepasswordlink")
    public ModelAndView changepasswordlink(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("ChangePassword");
        modelAndView.addObject("userdt", viewService.getspecifichqldata(UserDetails.class, session.getAttribute("USERID")));
        return modelAndView;
    }

    //code to update password begin here
    @RequestMapping(value = "updatePassword")
    public String updatePassword(@RequestParam(value = "txtuserid") String id,
            @RequestParam(value = "txtConfirmNewPassword") String confirmpassword,
            @RequestParam(value = "txtNewPassword") String password,
            HttpSession session) {
        updateService.updateanyjdbcdatalist("update userdetails set password='" + password + "',confirm_password='" + confirmpassword + "',modifydate=now() where id='" + id + "'");
        session.setAttribute("MSG", "Password SucessFully Changed..");
        return "redirect:changepasswordlink";
    }

}
