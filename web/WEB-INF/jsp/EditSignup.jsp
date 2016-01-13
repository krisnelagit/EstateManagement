<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditSignup
    Created on : 29 Dec, 2015, 5:20:18 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Signup</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <link rel="stylesheet" href="css/estatemodal.css" />
        <link rel="stylesheet" href="css/owl.carousel.css" />
        <link rel="stylesheet" href="css/owl.theme.css" />        
        <link href="css/bulddesign_popup.css" rel="stylesheet" type="text/css" />
        <script src="js/owl.carousel.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <style>
            .input001{width: 200px; height: 30px;}
            input{width: 90px;}
            .input002{width: 50px; height: 30px}
        </style>
        <style>
            #owl-demo .item{
                margin: 3px;
            }
            #owl-demo .item img{
                display: block;
                width: 100%;
                height: auto;
            }
        </style>
        <script src="js/BaseJava.js"></script>
        <script>
            $(document).ready(function () {
                console.log("i m ready");
                $("#datepicker").datepicker({dateFormat: 'yy-mm-dd'});
                getbuilding();
                console.log("i m treggg");
//                $("#owl-demo").owlCarousel({
//                    items: 1,
//                    lazyLoad: true,
//                    navigation: true
//                });

                //code for brokerage percent begins here
                $('#broker').change(function () {
                    var name = $('option:selected', $(this)).val();
                    $.ajax({
                        type: "post",
                        url: "getbrokerage",
                        dataType: "json",
                        data: {
                            brokerid: name
                        },
                        success: function (data) {
                            if (data) {
                                for (var i = 0; i < data.length; i++) {
                                    $('#brokerage').val(data[i].brokerage);
                                }
                            }
                        },
                        error: function () {
                            alert('Error');
                        }
                    });
                });
                //code for brokerage percent ends! here
                //code to get project requirement begin here
                $('#project').change(function () {
                    console.log("i m called");
                    var projectid = $("#project").val();
                    getbuilding();
                    
//                    $('#requirement').find('option').remove(); nitu
//                    $('#slab').find('option').remove();
//
//                    //code to directly append all the building code begins! here
//                    $.ajax({
//                        type: "post",
//                        url: "getBuildingviewdetails",
//                        dataType: "json",
//                        data: {
//                            projectid: projectid
//                        },
//                        success: function (data) {
//                            if (data) {
//                                $('#owl-demo').find('div').remove();
////                                $('[class^="building"]').remove();
////                                $("div.Test").remove();
////                                $("#owl-demo").empty();
//                                //jitu
//                                $('#buildingprojectid').val(projectid);
//                                //code to create dynamic class for caousel to append code begins here
//                                var totaldiv = "";
//                                for (var i = 0; i < data.length; i++) {
//                                    totaldiv += '<div class="building' + i + '"></div>';
//                                }
//                                $("#owl-demo").append(totaldiv);
//                                //code to create dynamic class for caousel to append code ends! here
//                                //for 3 building ie; wings
//                                for (var i = 0; i < data.length; i++) {
////                                    if (i < 1) {
//
//                                    var count = data[0].floorsdt[0].floorsdt;
//                                    var buildingno = i + 1;
//
//
//                                    var top = '<div class="container123" style="top: 50%; left: 20%"><center><div class="bld-wall"><strong>Building No :- ' + buildingno + '</strong></div><div class="bld-part"></div><div class="bld-wall2">';
//
//                                    //for floors count
//                                    var floor = "";
//                                    for (var j = 0; j < data[0].floorsdt.length; j++) {
//                                        var floorno = j + 1;
//                                        var flatcount = data[0].floorsdt[j].flatdt.length;
//                                        //for flats count
//                                        //.bld-floor padding 5px
//                                        //window 
//
//
//                                        floor += '<div class="bld-floor"> <strong>Floor No :-  ' + floorno + '<br></strong><br>';
//                                        var flat = "";
//                                        for (var k = 0; k < flatcount; k++) {
//                                            var dtrequirement = data[i].floorsdt[j].flatdt[k].srequirement;
//                                            var dtflat = data[i].floorsdt[j].flatdt[k].flatname;
//                                            var dtsaleable = data[i].floorsdt[j].flatdt[k].saleablearea;
//                                            var dtcarpet = data[i].floorsdt[j].flatdt[k].carpetarea;
//                                            var dtstatus = data[i].floorsdt[j].flatdt[k].status;
//                                            if (dtstatus === "SOLD") {
//                                                floor += '<a href="#" class="showflatinfo" style="text-decoration:none;"><div class="window2"><input type="hidden" name="requirement" value="' + dtrequirement + '" /><input type="hidden" name="wingnumber" value="' + buildingno + '" /><input type="hidden" name="flatnumber" value="' + dtflat + '" /><input type="hidden" name="saleablearea" value="' + dtsaleable + '" /><input type="hidden" name="carpetarea" value="' + dtcarpet + '" /><div class="detail">' + dtflat + '-' + dtrequirement + '</div></div></a>';
//                                            } else {
//                                                if (dtflat !== "NONE") {
//                                                    floor += '<a onclick="setflatdetails(\'' + dtrequirement + '\',\'' + buildingno + '\',\'' + dtflat + '\',\'' + dtsaleable + '\',\'' + dtcarpet + '\')" href="#" class="showflatinfo" style="text-decoration:none;"><div class="window"><input type="hidden" name="requirement" value="' + dtrequirement + '" /><input type="hidden" name="wingnumber" value="' + buildingno + '" /><input type="hidden" name="flatnumber" value="' + dtflat + '" /><input type="hidden" name="saleablearea" value="' + dtsaleable + '" /><input type="hidden" name="carpetarea" value="' + dtcarpet + '" /><div class="detail">' + dtflat + '-' + dtrequirement + '</div></div></a>';
//                                                } else {
//                                                    floor += '<a href="#" class="showflatinfo" style="text-decoration:none;"><div class="window"><input type="hidden" name="requirement" value="' + dtrequirement + '" /><input type="hidden" name="wingnumber" value="' + buildingno + '" /><input type="hidden" name="flatnumber" value="' + dtflat + '" /><input type="hidden" name="saleablearea" value="' + dtsaleable + '" /><input type="hidden" name="carpetarea" value="' + dtcarpet + '" /><div class="detail">' + dtflat + '- N/A</div></div></a>';
//                                                }
//
//                                            }
//
////                                            floor += '<a onclick="setflatdetails(\''+dtrequirement +'\,\''+buildingno +'\,\''+dtflat +'\,\''+dtsaleable +'\,\''+dtcarpet +'\')" href="#" class="showflatinfo" style="text-decoration:none;"><div class="window"><input type="hidden" name="requirement" value="' + dtrequirement + '" /><input type="hidden" name="wingnumber" value="' + buildingno + '" /><input type="hidden" name="flatnumber" value="' +dtflat+ '" /><input type="hidden" name="saleablearea" value="' + dtsaleable + '" /><input type="hidden" name="carpetarea" value="' + dtcarpet + '" /><div class="detail">' + dtflat + '</div></div></a>';
////                                            floor += '<a onclick="setflatdetails(\''+dtrequirement +','+buildingno +','+dtflat +','+dtsaleable +','+dtcarpet +'\')" href="#" class="showflatinfo" style="text-decoration:none;"><div class="window"><input type="hidden" name="requirement" value="' + dtrequirement + '" /><input type="hidden" name="wingnumber" value="' + buildingno + '" /><input type="hidden" name="flatnumber" value="' +dtflat+ '" /><input type="hidden" name="saleablearea" value="' + dtsaleable + '" /><input type="hidden" name="carpetarea" value="' + dtcarpet + '" /><div class="detail">' + dtflat + '</div></div></a>';
//
//                                        }
//                                        floor += "</div>";
//
//                                    }
//                                    var ground = '<div class="ground-flr"><img src="images/door.png" width="40" height="84" class="door"><img src="images/tree.png" width="84" height="105" style="position: absolute; left: 233px; top: -10px;"><img src="images/tree.png" width="84" height="105" style="position: absolute; left: -21px; top: -10px;"></div></div><div class="bld-floor2"></div></center></div>';
//                                    var building = top + floor + ground;
//                                    $(".building" + i).append(building);
////                                    }
//                                    //code for carousel to get the building jquery plugin here
//                                    $("#owl-demo").owlCarousel({
//                                        items: 1,
//                                        lazyLoad: true,
//                                        navigation: true
//                                    });
//                                    //code for carousel to get the building jquery plugin ends! here
//                                    console.log(data[0].floorsdt[0].floorsdt + " wingsdtzero");
//                                    console.log(data.length + " legnthth building");
//
//                                }
//                            }
//                        },
//                        error: function () {
//                            alert('Error in css popup');
//                        }
//                    });
                    //code to directly append all the building code ends! here
//                    $.ajax({
//                        type: "post",
//                        url: "getBuildingwingdetails",
//                        dataType: "json",
//                        data: {
//                            projectid: projectid
//                        },
//                        success: function (data) {
//                            if (data) {
//                                $('#buildingprojectid').val(projectid);
//                                $('#owl-demo').append("<option value='' selected=''>--select wing--</option>");
//                                console.log(data[0].wings + " zero");
//                                for (var i = 1; i <= data[0].wings; i++) {
//                                    $('#windata').append('<option>' + i + '</option>');
//                                }
//                            }
//                        },
//                        error: function () {
//                            alert('Error in css popup');
//                        }
//                    });


//                    $.ajax({
//                        type: "post",
//                        url: "getsignuprequirements",
//                        dataType: "json",
//                        data: {
//                            projectid: projectid
//                        },
//                        success: function (data) {
//                            if (data) {
//                                $('#requirement').append('<option value="" selected="">--select requirement--</option>');
////                                alert('i am in');
//                                for (var i = 0; i < data.length - 1; i++) {
//                                    if (data[i].requirement !== "undefined")
//                                    {
//                                        $('#requirement').append('<option >' + data[i].requirement + '</option>');
//                                    }
//                                }
//                                //set value for hidden field for building view operations
//                                $("#buildingprojectid").val(projectid);
//                            }
//                        },
//                        error: function () {
//                            alert('Error');
//                        }
//                    });

                    //code to get signup je percent code begins! here
                    $.ajax({
                        type: "post",
                        url: "getsignupjepercent",
                        dataType: "json",
                        data: {
                            projectid: projectid
                        },
                        success: function (data) {
                            if (data) {
                                for (var i = 0; i < data.length; i++) {
                                    $('#jepercent').val(data[i].jepercent);
                                }
                            }
                        },
                        error: function () {
                            alert('Error');
                        }
                    });
                    //code to get signup je percent code ends! here

                    //code to get slab details begin here
                    $.ajax({
                        type: "post",
                        url: "getslabdetails",
                        dataType: "json",
                        data: {
                            projectid: projectid
                        },
                        success: function (data) {
                            if (data) {
                                for (var i = 0; i < data.length; i++) {
                                    $('#slab').append('<option value="' + data[i].slab_master_id + '">' + data[i].slab_master_name + '</option>');
                                }
                            }
                        },
                        error: function () {
                            alert('Error');
                        }
                    });
                    //code to get slab details ends! here
                });
                //code to get project requirement ends! here
            });
        </script>      
        <!--jquery dom ready ends! here-->
        <!--javascript code for calculating on form 1 broker rate amount and stuff begins! here-->
        <script type="text/javascript">
            function getbuilding() {
                console.log("i m called");
                var projectid = $("#project").val();
                $('#requirement').find('option').remove();
                $('#slab').find('option').remove();

                //code to directly append all the building code begins! here
                $.ajax({
                    type: "post",
                    url: "getBuildingviewdetails",
                    dataType: "json",
                    data: {
                        projectid: projectid
                    },
                    success: function (data) {
                        if (data) {
//                            var owl = $("#owl-demo").data('owlCarousel');
//                            owl.destroy();
//                            $('#owl-demo').find('div').remove();
//                                $('[class^="building"]').remove();
//                                $("div.Test").remove();
//                                $("#owl-demo").empty();
                            //jitu
                            $('#buildingprojectid').val(projectid);
                            //code to create dynamic class for caousel to append code begins here
                            var totaldiv = "";
                            for (var i = 0; i < data.length; i++) {
                                totaldiv += '<div class="building' + i + '"></div>';
                            }
                            $("#owl-demo").append(totaldiv);
                            //code to create dynamic class for caousel to append code ends! here
                            //for 3 building ie; wings
                            for (var i = 0; i < data.length; i++) {
//                                    if (i < 1) {

                                var count = data[0].floorsdt[0].floorsdt;
                                var buildingno = i + 1;


                                var top = '<div class="container123" style="top: 50%; left: 20%"><center><div class="bld-wall"><strong>Building No :- ' + buildingno + '</strong></div><div class="bld-part"></div><div class="bld-wall2">';

                                //for floors count
                                var floor = "";
                                for (var j = 0; j < data[0].floorsdt.length; j++) {
                                    var floorno = j + 1;
                                    var flatcount = data[0].floorsdt[j].flatdt.length;
                                    //for flats count
                                    //.bld-floor padding 5px
                                    //window 


                                    floor += '<div class="bld-floor"> <strong>Floor No :-  ' + floorno + '<br></strong><br>';
                                    var flat = "";
                                    for (var k = 0; k < flatcount; k++) {
                                        var dtrequirement = data[i].floorsdt[j].flatdt[k].srequirement;
                                        var dtflat = data[i].floorsdt[j].flatdt[k].flatname;
                                        var dtsaleable = data[i].floorsdt[j].flatdt[k].saleablearea;
                                        var dtcarpet = data[i].floorsdt[j].flatdt[k].carpetarea;
                                        var dtstatus = data[i].floorsdt[j].flatdt[k].status;
                                        if (dtstatus === "SOLD") {
                                            floor += '<a href="#" class="showflatinfo" style="text-decoration:none;"><div class="window2"><input type="hidden" name="requirement" value="' + dtrequirement + '" /><input type="hidden" name="wingnumber" value="' + buildingno + '" /><input type="hidden" name="flatnumber" value="' + dtflat + '" /><input type="hidden" name="saleablearea" value="' + dtsaleable + '" /><input type="hidden" name="carpetarea" value="' + dtcarpet + '" /><div class="detail">' + dtflat + '-' + dtrequirement + '</div></div></a>';
                                        } else {
                                            if (dtflat !== "NONE") {
                                                floor += '<a onclick="setflatdetails(\'' + dtrequirement + '\',\'' + buildingno + '\',\'' + dtflat + '\',\'' + dtsaleable + '\',\'' + dtcarpet + '\')" href="#" class="showflatinfo" style="text-decoration:none;"><div class="window"><input type="hidden" name="requirement" value="' + dtrequirement + '" /><input type="hidden" name="wingnumber" value="' + buildingno + '" /><input type="hidden" name="flatnumber" value="' + dtflat + '" /><input type="hidden" name="saleablearea" value="' + dtsaleable + '" /><input type="hidden" name="carpetarea" value="' + dtcarpet + '" /><div class="detail">' + dtflat + '-' + dtrequirement + '</div></div></a>';
                                            } else {
                                                floor += '<a href="#" class="showflatinfo" style="text-decoration:none;"><div class="window"><input type="hidden" name="requirement" value="' + dtrequirement + '" /><input type="hidden" name="wingnumber" value="' + buildingno + '" /><input type="hidden" name="flatnumber" value="' + dtflat + '" /><input type="hidden" name="saleablearea" value="' + dtsaleable + '" /><input type="hidden" name="carpetarea" value="' + dtcarpet + '" /><div class="detail">' + dtflat + '- N/A</div></div></a>';
                                            }

                                        }

//                                            floor += '<a onclick="setflatdetails(\''+dtrequirement +'\,\''+buildingno +'\,\''+dtflat +'\,\''+dtsaleable +'\,\''+dtcarpet +'\')" href="#" class="showflatinfo" style="text-decoration:none;"><div class="window"><input type="hidden" name="requirement" value="' + dtrequirement + '" /><input type="hidden" name="wingnumber" value="' + buildingno + '" /><input type="hidden" name="flatnumber" value="' +dtflat+ '" /><input type="hidden" name="saleablearea" value="' + dtsaleable + '" /><input type="hidden" name="carpetarea" value="' + dtcarpet + '" /><div class="detail">' + dtflat + '</div></div></a>';
//                                            floor += '<a onclick="setflatdetails(\''+dtrequirement +','+buildingno +','+dtflat +','+dtsaleable +','+dtcarpet +'\')" href="#" class="showflatinfo" style="text-decoration:none;"><div class="window"><input type="hidden" name="requirement" value="' + dtrequirement + '" /><input type="hidden" name="wingnumber" value="' + buildingno + '" /><input type="hidden" name="flatnumber" value="' +dtflat+ '" /><input type="hidden" name="saleablearea" value="' + dtsaleable + '" /><input type="hidden" name="carpetarea" value="' + dtcarpet + '" /><div class="detail">' + dtflat + '</div></div></a>';

                                    }
                                    floor += "</div>";

                                }
                                var ground = '<div class="ground-flr"><img src="images/door.png" width="40" height="84" class="door"><img src="images/tree.png" width="84" height="105" style="position: absolute; left: 233px; top: -10px;"><img src="images/tree.png" width="84" height="105" style="position: absolute; left: -21px; top: -10px;"></div></div><div class="bld-floor2"></div></center></div>';
                                var building = top + floor + ground;
                                $(".building" + i).append(building);
//                                    }
                                //code for carousel to get the building jquery plugin here
                                $("#owl-demo").owlCarousel({
                                    items: 1,
                                    lazyLoad: true,
                                    navigation: true
//                                    content: building
                                });
                                //code for carousel to get the building jquery plugin ends! here
                                console.log(data[0].floorsdt[0].floorsdt + " wingsdtzero");
                                console.log(data.length + " legnthth building");

                            }
                        }
                    },
                    error: function () {
                        alert('Error in css popup');
                    }
                });
            }
            //code to get flat details from building view begins! here
            function setflatdetails(required, wingnumber, flatnumber, saleablearea, carpetarea) {
                $("#requirement").val(required);
                $("#Sqrft").val(saleablearea);
                $("#wings").val(wingnumber);
                $("#flats").val(flatnumber);
                $("#CarpetSqrft").val(carpetarea);
                $(".modal__close").click();
            }
            //code to get flat details from building view ends! here
            //code to delete textbox begins here
            function deletename(ob) {
                console.log(ob + " the delete");
                $('#' + ob + '').remove();
            }
            //code to delete textbox ends! here

            function calculate() {
                var sum = 0, brokerper = 0, jeper = 0, sum1 = 0;
                var total = document.getElementById('total');
                var rate = document.getElementById('rate');
                var Sqrft = document.getElementById('Sqrft');
                var jeperamount = document.getElementById('jeper');
                var jepercent = document.getElementById('jepercent');
                var brokperamount = document.getElementById('brokper');
                var brokeragepercent = document.getElementById('brokerage');


                sum = Number(Sqrft.value) * Number(rate.value);
                total.value = sum;

                jeper = Number(total.value) * Number(jepercent.value) / 100;
                jeperamount.value = jeper;

                brokerper = Number(total.value) * Number(brokeragepercent.value) / 100;
                brokperamount.value = brokerper;
            }
            function calculateratebytotal() {
                var sum = 0, brokerper = 0, jeper = 0;
                var total = document.getElementById('total');
                var rate = document.getElementById('rate');
                var Sqrft = document.getElementById('Sqrft');
                var jeperamount = document.getElementById('jeper');
                var jepercent = document.getElementById('jepercent');
                var brokperamount = document.getElementById('brokper');
                var brokeragepercent = document.getElementById('brokerage');
                if (total === "")
                {
                    total = 0;
                }
                sum = Number(total.value) / Number(Sqrft.value);
                rate.value = sum;

                jeper = Number(total.value) * Number(jepercent.value) / 100;
                jeperamount.value = jeper;

                brokerper = Number(total.value) * Number(brokeragepercent.value) / 100;
                brokperamount.value = brokerper;
            }

            //code to add slab row in dialog begins here  
            function addRow(tableID) {
                var table = document.getElementById(tableID);
                var rowCount = table.rows.length;
                var row = table.insertRow(rowCount);
                var colCount = table.rows[0].cells.length;
                for (var i = 0; i < colCount; i++) {
                    var newcell = row.insertCell(i);
                    newcell.innerHTML = table.rows[1].cells[i].innerHTML;
                }
            }
            //code to add slab row in dialog ends! here 

        </script>
        <!--javascript code for calculating on form 1 broker rate amount and stuff ends! here-->

        <!--javascript code for dialog calculation of slabs begins here-->
        <script>

        </script>
    </head>
    <body>
        <form action="updatesignup" method="POST" id="myform">
            <div id="show" class="bodycontainer">
                <div id="rwb" class="rwb">
                    <div class="bodyText mandatory"> </div>
                    <p>
                        <img src="image/lead2.png" width="41" height="43" align="absmiddle" /> &nbsp;&nbsp;<strong class="text001">EDIT SIGNUP</strong><br />
                    </p>
                    <div id="preHTMLContainer">
                        <div id="secDivLead Information">
                            <table id="secHeadLead Information" cellpadding="0" cellspacing="0" width="95%">
                                <tbody width="100%">
                                    <tr>
                                        <td class="secHead"> Lead Information </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table id="secContentLead Information" class="secContent" border="0" cellpadding="0" cellspacing="1" width="95%">
                                <tbody width="100%">
                                    <tr id="row0_Lead Information">
                                        <td class="label" width="25%"> * Date: <input type="hidden" name="signupid" value="${signupdt.signupid}" /></td>
                                        <td class="element" width="25%"><input name="date" type="text" value="${signupdt.date}" class="input" id="datepicker" required="" title="enter your date" placeholder="Enter Your Date"/></td>
                                        <td class="label" width="25%"> * Name: </td>
                                        <td class="element" width="25%"><input name="name" type="text" value="${signupdt.name}" class="input" id="name" required="" onkeypress="javascript:return isTextKey(event);" title="enter your name" placeholder="Enter Your Name"/></td>
                                    </tr>
                                    <tr id="row1_Lead Information">
                                        <td class="label" width="25%"> * Mobile: </td>
                                        <td class="element" width="25%">

                                            <input name="mobile" type="text" value="${signupdt.mobile}" class="input" id="mobile" required="" onkeypress="javascript:return isNumberKey(event);" title="enter your mobile number" placeholder="Enter Your Mobile Number" maxlength="10"/>

                                        </td>
                                        <td class="label" width="25%"> Phone: </td>
                                        <td class="element" width="25%">
                                            <input name="phone" type="text" value="${signupdt.phone}" class="input" id="phone"  onkeypress="javascript:return isNumberKey(event);" title="enter your phone number" placeholder="Enter Your Phone Number" maxlength="12" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label">Email</td>
                                        <td class="element"><input name="email" type="email" value="${signupdt.email}" class="input pagevalues" id="email" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" required=""  title="enter your email" placeholder="Enter Your Email"/></td>
                                        <td class="label">Sales Executive</td>
                                        <td class="element">
                                            <select name="salesperson" class="select pagevalues" id="salesperson" required="">
                                                <c:forEach var="ob" items="${salesexcdt}">
                                                    <c:choose>
                                                        <c:when test="${ob.id==signupdt.salesperson}">
                                                            <option selected="" value="${ob.id}">${ob.name}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${ob.id}">${ob.name}</option>
                                                        </c:otherwise>
                                                    </c:choose>                                                    
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr id="row2_Lead Information">
                                        <td class="label">Broker</td>
                                        <td class="element">
                                            <select name="broker" class="select pagevalues" id="broker" required="">
                                                <c:forEach var="ob" items="${brokerdt}">
                                                    <c:choose>
                                                        <c:when test="${ob.id==signupdt.broker}">
                                                            <option selected="" value="${ob.id}">${ob.name}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${ob.id}">${ob.name}</option>
                                                        </c:otherwise>
                                                    </c:choose>                                                    
                                                </c:forEach>                                                        
                                            </select>
                                            <!--<a href="addSignUpBroker">Add Broker</a>-->
                                        </td>
                                        <td class="label" width="25%"> Brokerage(%)</td>
                                        <td class="element" width="25%">
                                            <input type="text" name="brokerage" value="${signupdt.brokerage}" class="input pagevalues" id="brokerage" placeholder="Select Broker" readonly/>
                                        </td>
                                    </tr>
                                    <tr id="row3_Lead Information">
                                        <td class="label" width="25%">Project Name</td>
                                        <td class="element" width="25%">
                                            <select name="projectname" class="select pagevalues" id="project" required="">
                                                <c:forEach var="ob" items="${projectdt}">
                                                    <c:choose>
                                                        <c:when test="${ob.projectid==signupdt.projectname}">
                                                            <option selected="" value="${ob.projectid}">${ob.name}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${ob.projectid}">${ob.name}</option>
                                                        </c:otherwise>
                                                    </c:choose>                                                                                                    
                                                </c:forEach>
                                            </select>
                                            <input type="hidden" name="buildingprojectid" id="buildingprojectid" value="${signupdt.projectname}" />
                                            <label for="modal-2"><img src="images/city33.png"/> </label>
                                        </td>
                                        <td class="label" width="25%">Requirement</td>
                                        <td class="element" width="25%">
                                            <input type="text" readonly="" name="requirement" id="requirement" class="input pagevalues" value="${signupdt.requirement}" />                                            
                                        </td>
                                    </tr>
                                    <tr id="row3_Lead Information">
                                        <td class="label" width="25%">Saleable Sqft</td>
                                        <td class="element" width="25%">
                                            <input type="text" name="sqrfeet" value="${signupdt.sqrfeet}" id="Sqrft" readonly class="input pagevalues"/>
                                        </td>
                                        <td class="label" width="25%">Wing No.</td>
                                        <td class="element" width="25%">
                                            <input type="text" name="wingnum" value="${signupdt.wingnum}" id="wings" readonly class="input pagevalues" required="" />
                                        </td>
                                        <td class="label" width="25%">Flats</td>
                                        <td class="element" width="25%">
                                            <input type="text" name="flatnum" value="${signupdt.flatnum}" id="flats" readonly class="input pagevalues" required="" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label" width="25%">Carpet Sqft</td>
                                        <td class="element" width="25%">
                                            <input type="text" name="carpet_area"  value="${signupdt.carpet_area}" id="CarpetSqrft" readonly class="input pagevalues"/>
                                        </td>
                                        <td class="label">Lead Owner:</td>
                                        <td class="element">
                                            <input type="hidden" value="${signupdt.leadowner}" name="oldLowner" id="oldowner"  class="input pagevalues"/>
                                            <select name="leadowner" required="" class="select" id="Lowner">
                                                <option value="${signupdt.leadowner}" selected="">${signupdt.leadownernameJ}</option>
                                                <c:forEach var="lo" items="${leadownerlist}">
                                                    <c:choose>
                                                        <c:when test="${lo.id==signupdt.leadowner}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${lo.id}">${lo.name}</option>
                                                        </c:otherwise>
                                                    </c:choose>                                                
                                                </c:forEach>
                                            </select>
                                            <!--code to hide je% begin here-->
                                            <input type="hidden" name="jepercent" value="${signupdt.jepercent}" id="jepercent" readonly class="input pagevalues"/>
                                        </td>
                                    </tr>
                                    <tr id="row4_Lead Information">
                                        <td class="label" width="25%"> Rate </td>
                                        <td class="element" width="25%">
                                            <input type="text" name="rate" value="${signupdt.rate}" id="rate" class="input pagevalues" onkeyup="calculate()" onclick="calculate()" onkeypress="return isNumberKey(event)"/>
                                        </td>
                                        <td class="label" width="25%">Total</td>
                                        <td class="element" width="25%">
                                            <input type="text" name="total" value="${signupdt.total}" onkeyup="calculateratebytotal()" onclick="calculateratebytotal()" onkeypress="return isNumberKey(event)" id="total" class="input pagevalues"/>
                                            <input type="hidden" name="jeamt" value="${signupdt.jeamt}" id="jeper" class="input pagevalues" readonly/>

                                            <!--brokerage percent code here-->
                                            <input type="hidden" name="brokerageamt" value="${signupdt.brokerageamt}" id="brokper" class="input pagevalues" readonly/>
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                            <p> </p>

                            <div id="secDivAddress Information">
                                <table id="secHeadAddress Information" cellpadding="0" cellspacing="0" width="95%">
                                    <tbody width="100%">
                                        <tr>
                                            <td class="secHead"> Address Information </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table id="secContentAddress Information" class="secContent" border="0" cellpadding="0"
                                       cellspacing="1" width="95%">
                                    <tbody width="100%">
                                        <tr id="row0_Address Information">
                                            <td class="label" width="25%"> Address: </td>
                                            <td class="element" width="0%">
                                                <!--<input type="text" name="Laddress" value="" style="width: 100%;height: 30px"/>-->
                                                <input name="address1" type="text" value="${signupdt.address1}" class="input pagevalues" id="address1" title="address 1" placeholder="address 1"><br/>
                                                <input name="address2" type="text" value="${signupdt.address2}" class="input pagevalues" id="address2" title="address 2" placeholder="address 2"><br/>
                                                <input name="address3" type="text" value="${signupdt.address3}" class="input pagevalues" id="address3" title="address 3" placeholder="address 3"><br/>
                                                <input name="city" type="text"  class="input pagevalues" id="address4" value="${signupdt.city}" title="city" placeholder="city"><br/>
                                                <input name="pin_code" type="text" value="${signupdt.pin_code}" class="input pagevalues" id="address5" title="pin code" placeholder="pin code"><br/>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <br/>
                            <input type="submit" value="Update" class="newbtn"/>
                            <!--<a href="#" class="newbtn slab_link" id="check">Update</a>-->
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <!--code for some css modal popup begins! here-->
        <input class="modal-state" id="modal-2" type="checkbox" />
        <div class="modal">
            <label class="modal__bg" for="modal-2"></label>
            <div class="modal__inner">
                <label class="modal__close" for="modal-2"></label>
                <h2>Choose Flat</h2>
                <div id="owl-demo" class="owl-carousel">
                    <!--                    <span class="topflat"></span>
                                        <span class="bodyflat"></span>
                                        <span class="groundflat"></span>-->
                </div>
            </div>
        </div>
        <!--code for some css modal popup ends! here-->
    </body>
</html>
