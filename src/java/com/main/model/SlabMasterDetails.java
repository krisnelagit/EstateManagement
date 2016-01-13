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

@Entity(name = "slab_master_details")
@Table(name = "slab_master_details")
public class SlabMasterDetails {
    @Id
    @GeneratedValue
    private int id;
    private String slab_name,slab_percent,slab_master_id,isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public SlabMasterDetails() {
    }

    public SlabMasterDetails(int id, String slab_name, String slab_percent, String slab_master_id) {
        this.id = id;
        this.slab_name = slab_name;
        this.slab_percent = slab_percent;
        this.slab_master_id = slab_master_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSlab_name() {
        return slab_name;
    }

    public void setSlab_name(String slab_name) {
        this.slab_name = slab_name;
    }

    public String getSlab_percent() {
        return slab_percent;
    }

    public void setSlab_percent(String slab_percent) {
        this.slab_percent = slab_percent;
    }

    public String getSlab_master_id() {
        return slab_master_id;
    }

    public void setSlab_master_id(String slab_master_id) {
        this.slab_master_id = slab_master_id;
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
