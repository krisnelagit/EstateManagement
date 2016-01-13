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
@Entity(name = "signupslabs")
@Table(name = "signupslabs")
public class SignupSlabs {
    @Id
    private String id;
    private String slabname,slabpercent,rate,signupid,isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public SignupSlabs(String id, String slabname, String slabpercent, String rate, String signupid) {
        this.id = id;
        this.slabname = slabname;
        this.slabpercent = slabpercent;
        this.rate = rate;
        this.signupid = signupid;
    }

    public SignupSlabs() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSlabname() {
        return slabname;
    }

    public void setSlabname(String slabname) {
        this.slabname = slabname;
    }

    public String getSlabpercent() {
        return slabpercent;
    }

    public void setSlabpercent(String slabpercent) {
        this.slabpercent = slabpercent;
    }

    public String getRate() {
        return rate;
    }

    public void setRate(String rate) {
        this.rate = rate;
    }

    public String getSignupid() {
        return signupid;
    }

    public void setSignupid(String signupid) {
        this.signupid = signupid;
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
