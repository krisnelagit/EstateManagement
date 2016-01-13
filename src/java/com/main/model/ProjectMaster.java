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
@Entity(name = "projectmaster")
@Table(name = "projectmaster")
public class ProjectMaster {
    @Id
    private String projectid;
    private String name,location,address,buildername,requirement,area,jepercent,wings,floors,flats,isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public ProjectMaster(String projectid, String name, String location, String address, String buildername, String requirement, String area, String jepercent, String wings, String floors, String flats) {
        this.projectid = projectid;
        this.name = name;
        this.location = location;
        this.address = address;
        this.buildername = buildername;
        this.requirement = requirement;
        this.area = area;
        this.jepercent = jepercent;
        this.wings = wings;
        this.floors = floors;
        this.flats = flats;
    }

    public ProjectMaster() {
    }
    
    

    public String getProjectid() {
        return projectid;
    }

    public void setProjectid(String projectid) {
        this.projectid = projectid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getBuildername() {
        return buildername;
    }

    public void setBuildername(String buildername) {
        this.buildername = buildername;
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

    public String getJepercent() {
        return jepercent;
    }

    public void setJepercent(String jepercent) {
        this.jepercent = jepercent;
    }

    public String getWings() {
        return wings;
    }

    public void setWings(String wings) {
        this.wings = wings;
    }

    public String getFloors() {
        return floors;
    }

    public void setFloors(String floors) {
        this.floors = floors;
    }

    public String getFlats() {
        return flats;
    }

    public void setFlats(String flats) {
        this.flats = flats;
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
