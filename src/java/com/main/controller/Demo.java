/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

/**
 *
 * @author pc2
 */
public class Demo {

    public static void main(String[] args) throws ParseException {

//      2016-01-07T03:21:13.888Z
//      2016-01-07T04:09:47.043Z
//      2016-01-07T04:10:52.075Z
//        final Date date = new Date();
//        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'");
//        final TimeZone utc = TimeZone.getTimeZone("UTC");
//        sdf.setTimeZone(utc);
//        System.out.println(sdf.format(date));
//        SimpleDateFormat dateFormatGmt = new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");
//        dateFormatGmt.setTimeZone(TimeZone.getTimeZone("GMT"));
        //  2016-01-07T07:37:12.815Z
//        5:30
        //  2016-01-07T07:37:12.815Z
        //  2016-01-07T00:01:00.000Z
//
////Local time zone   
//        SimpleDateFormat dateFormatLocal = new SimpleDateFormat("yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'");
//
////Time in GMT
//        System.out.println(dateFormatLocal.parse(dateFormatGmt.format(new Date())));
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);
        System.out.println("Date = " + cal.getTime());

    }

}
