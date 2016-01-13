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
@Entity(name = "leadownerverification")
@Table(name = "leadownerverification")
public class LeadOwnerVerification {
    @Id
    private int id;
    private String leadid,leadname,oldleadowner,oldleadownername,newleadowner,reason,isverified,isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public LeadOwnerVerification() {
    }

    public LeadOwnerVerification(int id, String leadid, String leadname, String oldleadowner, String oldleadownername, String newleadowner, String reason, String isverified) {
        this.id = id;
        this.leadid = leadid;
        this.leadname = leadname;
        this.oldleadowner = oldleadowner;
        this.oldleadownername = oldleadownername;
        this.newleadowner = newleadowner;
        this.reason = reason;
        this.isverified = isverified;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLeadid() {
        return leadid;
    }

    public void setLeadid(String leadid) {
        this.leadid = leadid;
    }

    public String getLeadname() {
        return leadname;
    }

    public void setLeadname(String leadname) {
        this.leadname = leadname;
    }

    public String getOldleadowner() {
        return oldleadowner;
    }

    public void setOldleadowner(String oldleadowner) {
        this.oldleadowner = oldleadowner;
    }

    public String getOldleadownername() {
        return oldleadownername;
    }

    public void setOldleadownername(String oldleadownername) {
        this.oldleadownername = oldleadownername;
    }

    public String getNewleadowner() {
        return newleadowner;
    }

    public void setNewleadowner(String newleadowner) {
        this.newleadowner = newleadowner;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getIsverified() {
        return isverified;
    }

    public void setIsverified(String isverified) {
        this.isverified = isverified;
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
