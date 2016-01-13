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
@Entity(name = "detailsofprojectandarea")
@Table(name = "detailsofprojectandarea")
public class Detailsofprojectandarea {
    @Id
    private String detailid;
    private String userid,userprojectname,userareaname,isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public Detailsofprojectandarea(String detailid, String userid, String userprojectname, String userareaname) {
        this.detailid = detailid;
        this.userid = userid;
        this.userprojectname = userprojectname;
        this.userareaname = userareaname;
    }

    public Detailsofprojectandarea() {
    }

    public String getDetailid() {
        return detailid;
    }

    public void setDetailid(String detailid) {
        this.detailid = detailid;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUserprojectname() {
        return userprojectname;
    }

    public void setUserprojectname(String userprojectname) {
        this.userprojectname = userprojectname;
    }

    public String getUserareaname() {
        return userareaname;
    }

    public void setUserareaname(String userareaname) {
        this.userareaname = userareaname;
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
