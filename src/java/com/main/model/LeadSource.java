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
@Entity(name = "leadsource")
@Table(name = "leadsource")
public class LeadSource {
    @Id
    private String leadsourceid;
    private String leadname,isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public LeadSource() {
    }

    public LeadSource(String leadsourceid, String leadname) {
        this.leadsourceid = leadsourceid;
        this.leadname = leadname;
    }

    public String getLeadsourceid() {
        return leadsourceid;
    }

    public void setLeadsourceid(String leadsourceid) {
        this.leadsourceid = leadsourceid;
    }

    public String getLeadname() {
        return leadname;
    }

    public void setLeadname(String leadname) {
        this.leadname = leadname;
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
