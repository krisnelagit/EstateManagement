/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.model;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author pc2
 */
@Entity(name = "signupmaster")
@Table(name = "signupmaster")
public class SignupMaster {
    @Id
    private String signupid;
    private String date,name,name2,name3,mobile,phone,email,broker,brokerage,brokerageamt,projectname,requirement,sqrfeet,leadowner,jepercent,rate,total,jeamt,wingnum,flatnum,salesperson,carpet_area,address1,address2,address3,city,pin_code,isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public SignupMaster(String signupid, String date, String name, String name2, String name3, String mobile, String phone, String email, String broker, String brokerage, String brokerageamt, String projectname, String requirement, String sqrfeet, String leadowner, String jepercent, String rate, String total, String jeamt, String wingnum, String flatnum, String salesperson, String carpet_area, String address1, String address2, String address3, String city, String pin_code) {
        this.signupid = signupid;
        this.date = date;
        this.name = name;
        this.name2 = name2;
        this.name3 = name3;
        this.mobile = mobile;
        this.phone = phone;
        this.email = email;
        this.broker = broker;
        this.brokerage = brokerage;
        this.brokerageamt = brokerageamt;
        this.projectname = projectname;
        this.requirement = requirement;
        this.sqrfeet = sqrfeet;
        this.leadowner = leadowner;
        this.jepercent = jepercent;
        this.rate = rate;
        this.total = total;
        this.jeamt = jeamt;
        this.wingnum = wingnum;
        this.flatnum = flatnum;
        this.salesperson = salesperson;
        this.carpet_area = carpet_area;
        this.address1 = address1;
        this.address2 = address2;
        this.address3 = address3;
        this.city = city;
        this.pin_code = pin_code;
    }

    
    

    public String getCarpet_area() {
        return carpet_area;
    }

    public void setCarpet_area(String carpet_area) {
        this.carpet_area = carpet_area;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getAddress3() {
        return address3;
    }

    public void setAddress3(String address3) {
        this.address3 = address3;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPin_code() {
        return pin_code;
    }

    public void setPin_code(String pin_code) {
        this.pin_code = pin_code;
    }
    
    public String getName2() {
        return name2;
    }

    public void setName2(String name2) {
        this.name2 = name2;
    }

    public String getName3() {
        return name3;
    }

    public void setName3(String name3) {
        this.name3 = name3;
    }
    
    public SignupMaster() {
    }

    public String getSignupid() {
        return signupid;
    }

    public void setSignupid(String signupid) {
        this.signupid = signupid;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getBroker() {
        return broker;
    }

    public void setBroker(String broker) {
        this.broker = broker;
    }

    public String getBrokerage() {
        return brokerage;
    }

    public void setBrokerage(String brokerage) {
        this.brokerage = brokerage;
    }

    public String getBrokerageamt() {
        return brokerageamt;
    }

    public void setBrokerageamt(String brokerageamt) {
        this.brokerageamt = brokerageamt;
    }

    public String getProjectname() {
        return projectname;
    }

    public void setProjectname(String projectname) {
        this.projectname = projectname;
    }

    public String getRequirement() {
        return requirement;
    }

    public void setRequirement(String requirement) {
        this.requirement = requirement;
    }

    public String getSqrfeet() {
        return sqrfeet;
    }

    public void setSqrfeet(String sqrfeet) {
        this.sqrfeet = sqrfeet;
    }

    public String getLeadowner() {
        return leadowner;
    }

    public void setLeadowner(String leadowner) {
        this.leadowner = leadowner;
    }

    public String getJepercent() {
        return jepercent;
    }

    public void setJepercent(String jepercent) {
        this.jepercent = jepercent;
    }

    public String getRate() {
        return rate;
    }

    public void setRate(String rate) {
        this.rate = rate;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getJeamt() {
        return jeamt;
    }

    public void setJeamt(String jeamt) {
        this.jeamt = jeamt;
    }

    public String getWingnum() {
        return wingnum;
    }

    public void setWingnum(String wingnum) {
        this.wingnum = wingnum;
    }

    public String getFlatnum() {
        return flatnum;
    }

    public void setFlatnum(String flatnum) {
        this.flatnum = flatnum;
    }

    public String getSalesperson() {
        return salesperson;
    }

    public void setSalesperson(String salesperson) {
        this.salesperson = salesperson;
    }

    public String getIsdelete() {
        return isdelete;
    }

    public void setIsdelete(String isdelete) {
        this.isdelete = isdelete;
    }

    public String getModifydate() {
        return modifydate;
    }

    public void setModifydate(String modifydate) {
        this.modifydate = modifydate;
    }
    
}
