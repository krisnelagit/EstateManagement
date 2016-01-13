/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author pc2
 */
@Entity(name = "slab_master")
@Table(name = "slab_master")
public class SlabMaster {
    @Id
    @GeneratedValue
    private int slab_master_id;
    private String slab_master_name,project_requirement_id,isdelete="NO";

    public SlabMaster() {
    }

    public SlabMaster(int slab_master_id, String slab_master_name, String project_requirement_id) {
        this.slab_master_id = slab_master_id;
        this.slab_master_name = slab_master_name;
        this.project_requirement_id = project_requirement_id;
    }

    public int getSlab_master_id() {
        return slab_master_id;
    }

    public void setSlab_master_id(int slab_master_id) {
        this.slab_master_id = slab_master_id;
    }
    
    public String getSlab_master_name() {
        return slab_master_name;
    }

    public void setSlab_master_name(String slab_master_name) {
        this.slab_master_name = slab_master_name;
    }

    public String getProject_requirement_id() {
        return project_requirement_id;
    }

    public void setProject_requirement_id(String project_requirement_id) {
        this.project_requirement_id = project_requirement_id;
    }

    public String getIsdelete() {
        return isdelete;
    }

    public void setIsdelete(String isdelete) {
        this.isdelete = isdelete;
    }
    
    
    
    
}
