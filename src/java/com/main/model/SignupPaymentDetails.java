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
@Entity(name = "signup_paymentdetails")
@Table(name = "signup_paymentdetails")
public class SignupPaymentDetails {
    @Id
    private String paymentdetailsid;
    private String userid,paidamount,paymentmode,chequeno,bankname,paymentdate,onlinepay,slab,showslab,received,cleared,deposit,receivedDate,clearedDate,isdelete="NO",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public SignupPaymentDetails() {
    }

    public SignupPaymentDetails(String paymentdetailsid, String userid, String paidamount, String paymentmode, String chequeno, String bankname, String paymentdate, String onlinepay, String slab, String showslab, String received, String cleared, String deposit, String receivedDate, String clearedDate) {
        this.paymentdetailsid = paymentdetailsid;
        this.userid = userid;
        this.paidamount = paidamount;
        this.paymentmode = paymentmode;
        this.chequeno = chequeno;
        this.bankname = bankname;
        this.paymentdate = paymentdate;
        this.onlinepay = onlinepay;
        this.slab = slab;
        this.showslab = showslab;
        this.received = received;
        this.cleared = cleared;
        this.deposit = deposit;
        this.receivedDate = receivedDate;
        this.clearedDate = clearedDate;
    }

    public String getDeposit() {
        return deposit;
    }

    public void setDeposit(String deposit) {
        this.deposit = deposit;
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

    public String getSlab() {
        return slab;
    }

    public void setSlab(String slab) {
        this.slab = slab;
    }

    public String getShowslab() {
        return showslab;
    }

    public void setShowslab(String showslab) {
        this.showslab = showslab;
    }

    public String getReceived() {
        return received;
    }

    public void setReceived(String received) {
        this.received = received;
    }

    public String getCleared() {
        return cleared;
    }

    public void setCleared(String cleared) {
        this.cleared = cleared;
    }

    public String getReceivedDate() {
        return receivedDate;
    }

    public void setReceivedDate(String receivedDate) {
        this.receivedDate = receivedDate;
    }

    public String getClearedDate() {
        return clearedDate;
    }

    public void setClearedDate(String clearedDate) {
        this.clearedDate = clearedDate;
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
