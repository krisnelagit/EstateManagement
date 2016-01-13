<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddSignup
    Created on : 21 Dec, 2015, 11:37:03 AM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add signup</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <style>
            .input001{width: 200px; height: 30px;}
            input{width: 90px;}
            .input002{width: 50px; height: 30px}
        </style>
        <script src="js/BaseJava.js"></script>
        <!--jquery dom ready begins here-->
        <script>
            $(document).ready(function () {
                $("#dialog_slab").hide();

                $("#datepicker").datepicker({dateFormat: 'yy-mm-dd'});

                console.log("ready!");
                var scntDiv = $("#plusname");
//                var i = $('#plusname').size() + 1;
                //alternate append code begins! here
                $('#addScnt').on('click', function () {
                    var numItems = $('.addedcount').length;
                    var i = numItems + 1;
                    if (i < 4) {
                        $('<tr id="plusname' + i + '" class="addedcount"><td class="label" width="25%">&nbsp; </td><td class="element" width="25%">&nbsp; </td><td class="label" width="25%"> &nbsp;  </td><td class="element" width="25%"><input name="name" type="text" class="input" id="name' + i + '" required="" onkeypress="javascript:return isTextKey(event);" title="enter name" placeholder="Enter Name"/><a onclick="deletename(\'plusname' + i + '\');" href="#" class="removeScnt"><img src="images/cancel19.png" width="18"/></a></td></tr>').appendTo(scntDiv);
                        i++;
                        return false;
                    }
                });
                //alternate append code here to add two more names ends! here.

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
                    var projectid = $('option:selected', $(this)).val();
                    $('#requirement').find('option').remove();
                    $('#slab').find('option').remove();
                    $.ajax({
                        type: "post",
                        url: "getsignuprequirements",
                        dataType: "json",
                        data: {
                            projectid: projectid
                        },
                        success: function (data) {
                            if (data) {
                                $('#requirement').append('<option value="" selected="">--select requirement--</option>');
//                                alert('i am in');
                                for (var i = 0; i < data.length - 1; i++) {
                                    if (data[i].requirement !== "undefined")
                                    {
                                        $('#requirement').append('<option >' + data[i].requirement + '</option>');
                                    }
                                }
                            }
                        },
                        error: function () {
                            alert('Error');
                        }
                    });

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

                //code on requirement change begins! here
                $('#requirement').change(function () {
                    var requirement = $('option:selected', $(this)).val();
                    var projectid = $('#project').val();
                    $('#wings').find('option').remove();
                    $('#flats').find('option').remove();

                    //code to get wing square feet begins here
                    $.ajax({
                        type: "post",
                        url: "getwingsqrfeets",
                        dataType: "json",
                        data: {
                            requirement: requirement,
                            projectid: projectid
                        },
                        success: function (data) {
                            if (data) {
                                $('#Sqrft').val(data[0].sqrfeets);
                            }
                        },
                        error: function () {
                            alert('Error');
                        }
                    });
                    //code to get wing square feet ends! here

                    //code to get wing details begin here
                    $.ajax({
                        type: "post",
                        url: "getwingdetails",
                        dataType: "json",
                        data: {
                            requirement: requirement,
                            projectid: projectid
                        },
                        success: function (data) {
                            if (data) {
                                $('#wings').append("<option value='' selected=''>--select requirement--</option>");
                                for (var i = 0; i < data.length; i++) {
                                    if (data[i].wingnum != "undefined")
                                    {
                                        $('#wings').append('<option>' + data[i].wingnum + '</option>');
                                    }
                                }
                            }
                        },
                        error: function () {
                            alert('Error');
                        }
                    });
                    //code to get wing details ends! here

                });
                //code on requirement change ends!! here

                //code on wings change to get available flats begin here
                $('#wings').change(function () {
                    var wingno = $('option:selected', $(this)).val();
                    var projectid = $('#project').val();
                    var requirement = $('#requirement').val();
                    $('#flats').find('option').remove();
                    $.ajax({
                        type: "post",
                        url: "getsignupavailableflats",
                        dataType: "json",
                        data: {
                            projectid: projectid,
                            requirement: requirement,
                            wing: wingno
                        },
                        success: function (data) {
                            if (data) {
                                $('#flats').append("<option value='' selected=''>--select flats--</option>");
                                for (var j = 0; j < data.length; j++) {
                                    {
                                        $('#flats').append('<option>' + data[j].flatname + '</option>');
                                    }
                                }
                            }
                        },
                        error: function () {
                            alert('Error');
                        }
                    });
                });
                //code on wings change to get available flats ends! here

                //code for slab dialog begins here
                $("#check").click(function () {
                    //opens dialog
                    $("#dialog_slab").dialog({
                        modal: true,
                        effect: 'drop',
                        width: 745,
                        height: 360,
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });

                    var projectid = $('#project').val();
                    var date = $("#datepicker").val();
                    var name = $("#name").val();
                    var name2 = $("#name2").val();
                    var name3 = $("#name3").val();
                    var mobile = $("#mobile").val();
                    var phone = $("#phone").val();
                    var email = $("#email").val();
                    var salesperson = $("#salesperson").val();
                    var broker = $("#broker").val();
                    var brokerage = $("#brokerage").val();
                    var requirement = $("#requirement").val();
                    var slab = $("#slab").val();
                    var Sqrft = $("#Sqrft").val();
                    var wings = $("#wings").val();
                    var flats = $("#flats").val();
                    var owner = $("#owner").val();
                    var jepercent = $("#jepercent").val();
                    var rate = $("#rate").val();
                    var total = $("#total").val();
                    var jeper = $("#jeper").val();
                    var brokper = $("#brokper").val();
                    console.log(brokper + " brokerageamoount");
                    var address1 = $("#address1").val();
                    var address2 = $("#address2").val();
                    var address3 = $("#address3").val();
                    var address4 = $("#address4").val();
                    var address5 = $("#address5").val();
                    var fulladdress=address1+"&nbsp;"+address2+"&nbsp;"+address3+"&nbsp;"+address4+"&nbsp;"+address5;
                    console.log(projectid + " id || slab " + slab);

                    $.ajax({
                        type: "post",
                        url: "getslabprojectrequirement",
                        dataType: "json",
                        data: {
                            projectid: projectid,
                            slab_master_id: slab
                        },
                        success: function (data) {
                            if (data) {
                                //code to set the hidden field s for modelattribute begins! here
                                $("#hidden_date").val(date);
                                $("#hidden_name").val(name);
                                $("#hidden_name2").val(name2);
                                $("#hidden_name3").val(name3);
                                $("#hidden_mobile").val(mobile);
                                $("#hidden_phone").val(phone);
                                $("#hidden_email").val(email);
                                $("#hidden_broker").val(broker);
                                $("#hidden_brokerage").val(brokerage);
                                $("#hidden_brokerageamount").val(brokper);
                                $("#hidden_projectname").val(projectid);
                                $("#hidden_requirement").val(requirement);
                                $("#hidden_sqrfeet").val(Sqrft);
                                $("#hidden_leadowner").val(owner);
                                $("#hidden_jepercent").val(jepercent);
                                $("#hidden_rate").val(rate);
                                $("#hidden_total").val(total);
                                $("#hidden_jeamount").val(jeper);
                                $("#hidden_address").val(fulladdress);
                                $("#hidden_wingnum").val(wings);
                                $("#hidden_flatnum").val(flats);
                                $("#hidden_salesperson").val(salesperson);
                                //code to set the hidden field s for modelattribute ends! here
                                $(".slabdata").remove();

                                //appends value
                                for (var j = 0; j < data.length; j++) {
                                    //code to set rate according to percentage begins here
                                    var slabrate = total * data[j].slab_percent / 100;
                                    //code to set rate according to percentage ends! here
                                    $('#dialogbody').append('<tr class="slabdata"><td align="left"><input type="text" value="' + data[j].slab_name + '" class="input001" name="txtProjectSlabADD" placeholder="Enter Slab"></td><td align="left"><input type="text" value="' + data[j].slab_percent + '" class="input001 slabper" name="txtProjectSlabpercentADD" placeholder="Enter Slab Percent" onkeyup="calculateslab()" onclick="calculateslab()" id="slabpercent" autofocus=""></td><td align="left"><input type="text" readonly="" value="' + slabrate + '" class="input001 slabrate" name="txtProjectSlabrateADD" placeholder="Enter Slab Rate" id="slabpercent" autofocus=""></td><td><span style="display: none" class="delete1" onclick="confirmdelete(this);"><img src="img/1396621437_Delete.png" alt="Delete" height="20" width="20"></span></td></tr>');
                                }
                                calculateslab();
                            }
                        },
                        error: function () {
                            alert('Error in slab');
                        }
                    });
                });
                //code for slab dialog ends! here

            });
        </script>        
        <!--jquery dom ready ends! here-->
        <!--javascript code for calculating on form 1 broker rate amount and stuff begins! here-->
        <script type="text/javascript">
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
                if (total == "")
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
        </script>
        <!--javascript code for calculating on form 1 broker rate amount and stuff ends! here-->

        <!--javascript code for dialog calculation of slabs begins here-->
        <script>

            function Insert(tableID) {
                try {
                    var table = document.getElementById(tableID);
                    var rowCount = table.rows.length;
                    var sum = 0;
                    var grand = 0;
                    var grandamt = 0;
                    for (var i = 1; i < rowCount; i++) {
                        var row = table.rows[i];
                        var percent = row.cells[1].childNodes[1];
                        var rate = row.cells[2].childNodes[1];
                        var finaltotal = document.getElementById('grandtotal');
                        var finaltotalamt = document.getElementById('grandtotalamt');
                        var total = document.getElementById("total");
                        sum = Number(total.value) * Number(percent.value) / 100;
                        rate.value = sum;

                        grand = Number(grand) + Number(percent.value);
                        finaltotal.value = grand;

//                        grandamt = Number(grandamt) + Number(rate.value);
//                        finaltotalamt.value = grandamt;

                    }
                } catch (e) {
                    alert(e);
                }
            }


            function InsertRated(tableID) {
                try {
                    var table = document.getElementById(tableID);
                    var rowCount = table.rows.length;
                    var sum = 0;
                    var grand = 0;
                    for (var i = 1; i < rowCount; i++) {
                        var row = table.rows[i];
                        var percent = row.cells[1].childNodes[1];
                        var rate = row.cells[2].childNodes[1];
                        var finaltotal = document.getElementById('grandtotal');
                        var total = document.getElementById("total");
                        sum = Number(rate.value) / Number(total.value) * 100;
                        percent.value = sum;

                        grand = Number(grand) + Number(percent.value);
                        finaltotal.value = grand;

                    }
                } catch (e) {
                    alert(e);
                }
            }


            //code for slab dialog function of slab begin here 

            //code to check if slab is 100% code begins here
            function check() {
                if (document.getElementById('grandtotal').value !== "100")
                {
                    alert("Please Make A Total Of 100%");
                    return false;
                }
                return true;
            }
            //code to check if slab is 100% code ends! here

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

            //delete slab row begin here
            function confirmdelete(ob) {
                var res = confirm('Are you sure to delete?');
                if (res === true) {
                    $(ob).closest('tr').find('td').fadeOut(600,
                            function () {
                                $(ob).parents('tr:first').remove();
                            });
                }
            }
            //delete slab row ends! here

            //adds slab percent and sets grand total of slab begins here
            function calculateslab() {
                var table = document.getElementById('dataTable1234');
                var rowCount = table.rows.length;
                var fin = "0";
                var thetotal = $("#hidden_total").val();

                $('.slabper').each(function () {
                    fin = Number(fin) + Number(this.value);
                    var setrate = thetotal * Number(this.value) / 100;
                    $(this).closest('tr').find('.slabrate').val(setrate);
                });
                $("#grandtotal").val(fin);

            }
            //adds slab percent and sets grand total of slab ends! here

            //code for slab dialog function of slab ends! here 
        </script>
        <!--javascript code for dialog calculation of slabs ends! here-->
    </head>
    <body>

        <div id="show" class="bodycontainer">
            <div id="rwb" class="rwb">
                <div class="bodyText mandatory"> </div>
                <p>
                    <img src="image/lead2.png" width="41" height="43" align="absmiddle" /> &nbsp;&nbsp;<strong class="text001">CREATE SIGN UP</strong><br />
                    <br />
                </p>
                <a href=""></a>
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
                                <tr id="plusname" class="addedcount">
                                    <td class="label" width="25%"> * Date: </td>
                                    <td class="element" width="25%"><input name="Ldate" type="text" class="input pagevalues" id="datepicker" required="" title="enter your date" placeholder="Enter Your Date"/></td>
                                    <td class="label" width="25%"> * Name: </td>
                                    <td class="element" width="25%">
                                        <input name="Lnames" type="text" class="input pagevalues" id="name" required="" onkeypress="javascript:return isTextKey(event);" title="enter name" placeholder="Enter Name"/>
                                        <a href="#" id="addScnt"><img src="images/add139.png" width="18"/></a>
                                    </td>
                                </tr>                                    
                                <tr id="row1_Lead Information">
                                    <td class="label" width="25%"> * Mobile: </td>
                                    <td class="element" width="25%">

                                        <input name="Lmobile" type="text" class="input pagevalues" id="mobile" required="" onkeypress="javascript:return isNumberKey(event);" title="enter your mobile number" placeholder="Enter Your Mobile Number" maxlength="10"/>

                                    </td>
                                    <td class="label" width="25%"> Phone: </td>
                                    <td class="element" width="25%">
                                        <input name="Lphone" type="text" class="input pagevalues" id="phone"  onkeypress="javascript:return isNumberKey(event);" title="enter your phone number" placeholder="Enter Your Phone Number" maxlength="12" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label">Email</td>
                                    <td class="element"><input name="Lemail" type="email" class="input pagevalues" id="email" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" required=""  title="enter your email" placeholder="Enter Your Email"/></td>
                                    <td class="label">Sales Executive</td>
                                    <td class="element">
                                        <select name="" class="select pagevalues" id="salesperson" required="">
                                            <option value="">--select--</option>
                                            <c:forEach var="ob" items="${salesexcdt}">
                                                <option value="${ob.id}">${ob.name}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr id="row2_Lead Information">
                                    <td class="label">Broker</td>
                                    <td class="element">
                                        <select name="Lbroker" class="select pagevalues" id="broker" required="">
                                            <option selected="" value="">select broker</option>
                                            <c:forEach var="ob" items="${brokerdt}">
                                                <option value="${ob.id}">${ob.name}</option>
                                            </c:forEach>                                                        
                                        </select>
                                        <a href="addSignUpBroker">Add Broker</a>

                                    </td>
                                    <td class="label" width="25%"> Brokerage(%)</td>
                                    <td class="element" width="25%">
                                        <input type="text" name="Lbrokerage" value="" class="input pagevalues" id="brokerage" placeholder="Select Broker" readonly/>
                                    </td>
                                </tr>
                                <tr id="row3_Lead Information">
                                    <td class="label" width="25%">Project Name</td>
                                    <td class="element" width="25%">
                                        <select name="Lproject" class="select pagevalues" id="project" required="">
                                            <option selected="" value="">-- Select Project --</option>
                                            <c:forEach var="ob" items="${projectdt}">
                                                <option value="${ob.projectid}">${ob.name}</option>                                                
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td class="label" width="25%">Requirement</td>
                                    <td class="element" width="25%">
                                        <select name="Lrequirement" class="select pagevalues" id="requirement" required="">

                                        </select>
                                    </td>
                                    <td class="label" width="25%">Select Slab</td>
                                    <td class="element" width="25%">
                                        <select name="Slab" class="select pagevalues" id="slab" required="">

                                        </select>
                                    </td>
                                </tr>
                                <tr id="row3_Lead Information">
                                    <td class="label" width="25%">Sqft</td>
                                    <td class="element" width="25%">
                                        <input type="text" name="LSqrft" value="" id="Sqrft" readonly class="input pagevalues"/>
                                    </td>
                                    <td class="label" width="25%">Wing No.</td>
                                    <td class="element" width="25%">
                                        <select name="Lwings" class="select pagevalues" id="wings" required="">

                                        </select>
                                    </td>
                                    <td class="label" width="25%">Flats</td>
                                    <td class="element" width="25%">
                                        <select name="Lflats" class="select pagevalues" id="flats" required="">

                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label">Lead Owner:</td>
                                    <td class="element">
                                        <input type="text" value="${sessionScope.USERNAME}"  readonly="" class="input pagevalues"/>
                                        <input type="hidden" value="${sessionScope.USERID}" name="Lowner" id="owner"  class="input pagevalues"/>
                                        <!--code to hide je% begin here-->
                                        <c:choose>
                                            <c:when test="${sessionScope.USERTYPE.equals('Admin')}">
                                                <input type="hidden" name="LSqrft" value="" id="jepercent" readonly class="input pagevalues"/>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="LSqrft" value="" id="jepercent" readonly class="input pagevalues"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!--                                    <td class="label" width="25%">JE(%)</td>
                                                                        <td class="element" width="25%">
                                    
                                                                        </td>
                                    
                                                                        <td class="label" width="25%" style="display: none">JE(%)</td>
                                                                        <td class="element" width="25%" style="display: none">
                                    
                                                                        </td>-->

                                </tr>
                                <tr id="row4_Lead Information">
                                    <td class="label" width="25%"> Rate </td>
                                    <td class="element" width="25%">
                                        <input type="text" name="Lrate" value="" id="rate" class="input pagevalues" onkeyup="calculate()" onclick="calculate()" onkeypress="return isNumberKey(event)"/>
                                    </td>
                                    <td class="label" width="25%">Total</td>
                                    <td class="element" width="25%">
                                        <input type="text" name="Ltotal" value="" onkeyup="calculateratebytotal()" onclick="calculateratebytotal()" onkeypress="return isNumberKey(event)" id="total" class="input pagevalues"/>
                                        <c:choose>
                                            <c:when test="${sessionScope.USERTYPE.equals('Admin')}">
                                                <input type="hidden" name="Lrate" value="" id="jeper" class="input pagevalues" readonly/>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="Lrate" value="" id="jeper" class="input pagevalues" readonly/>
                                            </c:otherwise>
                                        </c:choose>
                                        <!--brokerage percent code here-->
                                        <input type="hidden" name="Ltotal" value="" id="brokper" class="input pagevalues" readonly/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
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
                                        <input name="address1" type="text" class="input pagevalues" id="address1" title="address 1" placeholder="address 1"><br/>
                                        <input name="address2" type="text" class="input pagevalues" id="address2" title="address 2" placeholder="address 2"><br/>
                                        <input name="address3" type="text" class="input pagevalues" id="address3" title="address 3" placeholder="address 3"><br/>
                                        <input name="address4" type="text" class="input pagevalues" id="address4" value="Mumbai" title="city" placeholder="city"><br/>
                                        <input name="address5" type="text" class="input pagevalues" id="address5" title="pin code" placeholder="pin code"><br/>
                                        
<!--                                        <input type="text" name="address1" value="" id="address1" />
                                        <input type="text" name="address2" value="" id="address2" />
                                        <input type="text" name="address3" value="" id="address3" />
                                        <input type="text" name="address4" value="Mumbai" id="address4" />
                                        <input type="text" name="address5" value="" id="address5" />
                                        <textarea name="Laddress" cols="" rows="" class="textarea pagevalues" id="address"  title="enter address" placeholder="Enter Address"></textarea>  -->
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <br/>
                    <div class="btn2">
                        <a href="#" class="newbtn slab_link" id="check">Next</a>
                    </div>
                </div>
            </div>
        </div>

        <!--code for slab dialog begins here-->
        <div id="dialog_slab" title="Slab Details">
            <form action="insertsignup" method="POST">

                <!--the form data for signup insert begin here-->
                <input type="hidden" name="date" id="hidden_date" value="" />
                <input type="hidden" name="name" id="hidden_name" value="" />
                <input type="hidden" name="name2" id="hidden_name2" value="" />
                <input type="hidden" name="name3" id="hidden_name3" value="" />
                <input type="hidden" name="mobile" id="hidden_mobile" value="" />
                <input type="hidden" name="phone" id="hidden_phone" value="" />
                <input type="hidden" name="email" id="hidden_email" value="" />
                <input type="hidden" name="broker" id="hidden_broker" value="" />
                <input type="hidden" name="brokerage" id="hidden_brokerage" value="" />
                <input type="hidden" name="brokerageamt" id="hidden_brokerageamount" value="" />
                <input type="hidden" name="projectname" id="hidden_projectname" value="" />
                <input type="hidden" name="requirement" id="hidden_requirement" value="" />
                <input type="hidden" name="sqrfeet" id="hidden_sqrfeet" value="" />
                <input type="hidden" name="leadowner" id="hidden_leadowner" value="" />
                <input type="hidden" name="jepercent" id="hidden_jepercent" value="" />
                <input type="hidden" name="rate" id="hidden_rate" value="" />
                <input type="hidden" name="total" id="hidden_total" value="" />
                <input type="hidden" name="jeamt" id="hidden_jeamount" value="" />
                <input type="hidden" name="address" id="hidden_address" value="" />
                <input type="hidden" name="wingnum" id="hidden_wingnum" value="" />
                <input type="hidden" name="flatnum" id="hidden_flatnum" value="" />
                <input type="hidden" name="salesperson" id="hidden_salesperson" value="" />
                <!--the form data for signup insert ends! here-->

                <img src="img/1396621656_Plus.png" width="20" height="20" alt="1396621656_Plus" onclick="addRow('dataTable1234')" style="float: left; display: none"/><br/>
                <table border="0" id="dataTable1234">
                    <thead>
                        <tr>
                            <th>Slabs</th>
                            <th>Percents</th>
                            <th>Rate</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody id="dialogbody">
                        <tr id="slabhiddendata" style="display: none">
                            <td align="left">
                                <input type="text" value="" class="input001" name="txtProjectSlabADD" placeholder="Enter Slab">
                            </td>
                            <td align="left">
                                <input type="text" value="" class="input001 slabper" name="txtProjectSlabpercentADD" placeholder="Enter Slab Percent" onkeyup="calculateslab()" onclick="calculateslab()" id="slabpercent" autofocus="">
                            </td>
                            <td align="left">
                                <input type="text" value="" readonly="" class="input001 slabrate" name="txtProjectSlabrateADD" placeholder="Enter Slab Rate" id="slabperrcent" autofocus="">
                            </td>
                            <td>
                                <span style="display: none" class="delete1" onclick="confirmdelete(this);"><img src="img/1396621437_Delete.png" alt="Delete" height="20" width="20"></span>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div>Total: <input type="text" name="" value="" readonly="" id="grandtotal"/></div><br/>
                <input style="text-align: center;position: absolute;" type="submit" value="Submit" class="newbtn3" onclick="return check();"/>
            </form>
        </div>
        <!--code for slab dialog ends! here-->
    </body>
</html>
