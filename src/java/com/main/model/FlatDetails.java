/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.model;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author pc2
 */
@Entity(name = "flatsdetails")
@Table(name = "flatsdetails")
public class FlatDetails {
    @Id
    @GeneratedValue
    private int id;
    private String flatid,ofbuilding,bhk,price,status,flatname,wingnum,isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public FlatDetails() {
    }

    public FlatDetails(int id, String flatid, String ofbuilding, String bhk, String price, String status, String flatname, String wingnum) {
        this.id = id;
        this.flatid = flatid;
        this.ofbuilding = ofbuilding;
        this.bhk = bhk;
        this.price = price;
        this.status = status;
        this.flatname = flatname;
        this.wingnum = wingnum;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public String getFlatid() {
        return flatid;
    }

    public void setFlatid(String flatid) {
        this.flatid = flatid;
    }

    public String getOfbuilding() {
        return ofbuilding;
    }

    public void setOfbuilding(String ofbuilding) {
        this.ofbuilding = ofbuilding;
    }

    public String getBhk() {
        return bhk;
    }

    public void setBhk(String bhk) {
        this.bhk = bhk;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFlatname() {
        return flatname;
    }

    public void setFlatname(String flatname) {
        this.flatname = flatname;
    }

    public String getWingnum() {
        return wingnum;
    }

    public void setWingnum(String wingnum) {
        this.wingnum = wingnum;
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
