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
@Entity(name = "projectrequirement")
@Table(name = "projectrequirement")
public class ProjectRequirement {
    @Id
    private String id;
    private String projectid,requirement,area,sqrfeets,carpet,slabname,slabpercent,slab_master_id,isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public ProjectRequirement() {
    }

    public ProjectRequirement(String id, String projectid, String requirement, String area, String sqrfeets, String carpet, String slabname, String slabpercent, String slab_master_id) {
        this.id = id;
        this.projectid = projectid;
        this.requirement = requirement;
        this.area = area;
        this.sqrfeets = sqrfeets;
        this.carpet = carpet;
        this.slabname = slabname;
        this.slabpercent = slabpercent;
        this.slab_master_id = slab_master_id;
    }    

    public String getCarpet() {
        return carpet;
    }

    public void setCarpet(String carpet) {
        this.carpet = carpet;
    }
    
    public String getSlab_master_id() {
        return slab_master_id;
    }

    public void setSlab_master_id(String slab_master_id) {
        this.slab_master_id = slab_master_id;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProjectid() {
        return projectid;
    }

    public void setProjectid(String projectid) {
        this.projectid = projectid;
    }

    public String getRequirement() {
        return requirement;
    }

    public void setRequirement(String requirement) {
        this.requirement = requirement;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getSqrfeets() {
        return sqrfeets;
    }

    public void setSqrfeets(String sqrfeets) {
        this.sqrfeets = sqrfeets;
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
