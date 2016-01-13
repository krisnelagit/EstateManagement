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
@Entity(name = "leadmaster")
@Table(name = "leadmaster")
public class LeadMaster {
    @Id
    private String leadid;
    private String date,name,mobile,phone,email,broker,leadsource,typeofenquiry,projectname,requirement,leadowner,leadstatus,loan,
            address,description,convertdate,converttime,convertcomments,convertstatus,confirmed,confirmedcomments,salesexecutive,
            isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public LeadMaster() {
    }

    public LeadMaster(String leadid, String date, String name, String mobile, String phone, String email, String broker, String leadsource, String typeofenquiry, String projectname, String requirement, String leadowner, String leadstatus, String loan, String address, String description, String convertdate, String converttime, String convertcomments, String convertstatus, String confirmed, String confirmedcomments, String salesexecutive) {
        this.leadid = leadid;
        this.date = date;
        this.name = name;
        this.mobile = mobile;
        this.phone = phone;
        this.email = email;
        this.broker = broker;
        this.leadsource = leadsource;
        this.typeofenquiry = typeofenquiry;
        this.projectname = projectname;
        this.requirement = requirement;
        this.leadowner = leadowner;
        this.leadstatus = leadstatus;
        this.loan = loan;
        this.address = address;
        this.description = description;
        this.convertdate = convertdate;
        this.converttime = converttime;
        this.convertcomments = convertcomments;
        this.convertstatus = convertstatus;
        this.confirmed = confirmed;
        this.confirmedcomments = confirmedcomments;
        this.salesexecutive = salesexecutive;
    }

    public String getSalesexecutive() {
        return salesexecutive;
    }

    public void setSalesexecutive(String salesexecutive) {
        this.salesexecutive = salesexecutive;
    }
    
    public String getLeadid() {
        return leadid;
    }

    public void setLeadid(String leadid) {
        this.leadid = leadid;
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

    public String getLeadsource() {
        return leadsource;
    }

    public void setLeadsource(String leadsource) {
        this.leadsource = leadsource;
    }

    public String getTypeofenquiry() {
        return typeofenquiry;
    }

    public void setTypeofenquiry(String typeofenquiry) {
        this.typeofenquiry = typeofenquiry;
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

    public String getLeadowner() {
        return leadowner;
    }

    public void setLeadowner(String leadowner) {
        this.leadowner = leadowner;
    }

    public String getLeadstatus() {
        return leadstatus;
    }

    public void setLeadstatus(String leadstatus) {
        this.leadstatus = leadstatus;
    }

    public String getLoan() {
        return loan;
    }

    public void setLoan(String loan) {
        this.loan = loan;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getConvertdate() {
        return convertdate;
    }

    public void setConvertdate(String convertdate) {
        this.convertdate = convertdate;
    }

    public String getConverttime() {
        return converttime;
    }

    public void setConverttime(String converttime) {
        this.converttime = converttime;
    }

    public String getConvertcomments() {
        return convertcomments;
    }

    public void setConvertcomments(String convertcomments) {
        this.convertcomments = convertcomments;
    }

    public String getConvertstatus() {
        return convertstatus;
    }

    public void setConvertstatus(String convertstatus) {
        this.convertstatus = convertstatus;
    }

    public String getConfirmed() {
        return confirmed;
    }

    public void setConfirmed(String confirmed) {
        this.confirmed = confirmed;
    }

    public String getConfirmedcomments() {
        return confirmedcomments;
    }

    public void setConfirmedcomments(String confirmedcomments) {
        this.confirmedcomments = confirmedcomments;
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
