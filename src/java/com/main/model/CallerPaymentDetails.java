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
@Entity(name = "callerpaymentdetails")
@Table(name = "callerpaymentdetails")
public class CallerPaymentDetails {
    @Id
    private String paymentdetailsid;
    private String userid,paidamount,paymentmode,chequeno,bankname,paymentdate,onlinepay,
            isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public CallerPaymentDetails() {
    }

    public CallerPaymentDetails(String paymentdetailsid, String userid, String paidamount, String paymentmode, String chequeno, String bankname, String paymentdate, String onlinepay) {
        this.paymentdetailsid = paymentdetailsid;
        this.userid = userid;
        this.paidamount = paidamount;
        this.paymentmode = paymentmode;
        this.chequeno = chequeno;
        this.bankname = bankname;
        this.paymentdate = paymentdate;
        this.onlinepay = onlinepay;
    }

    public String getPaymentdetailsid() {
        return paymentdetailsid;
    }

    public void setPaymentdetailsid(String paymentdetailsid) {
        this.paymentdetailsid = paymentdetailsid;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getPaidamount() {
        return paidamount;
    }

    public void setPaidamount(String paidamount) {
        this.paidamount = paidamount;
    }

    public String getPaymentmode() {
        return paymentmode;
    }

    public void setPaymentmode(String paymentmode) {
        this.paymentmode = paymentmode;
    }

    public String getChequeno() {
        return chequeno;
    }

    public void setChequeno(String chequeno) {
        this.chequeno = chequeno;
    }

    public String getBankname() {
        return bankname;
    }

    public void setBankname(String bankname) {
        this.bankname = bankname;
    }

    public String getPaymentdate() {
        return paymentdate;
    }

    public void setPaymentdate(String paymentdate) {
        this.paymentdate = paymentdate;
    }

    public String getOnlinepay() {
        return onlinepay;
    }

    public void setOnlinepay(String onlinepay) {
        this.onlinepay = onlinepay;
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
