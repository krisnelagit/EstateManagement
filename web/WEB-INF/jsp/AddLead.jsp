<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddLead
    Created on : 16 Dec, 2015, 1:11:20 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Lead</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <link href="css/crmcontemporarysecure.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <style>
            html {
                overflow-y: scroll; 
            }
        </style>
        <script>
            $(document).ready(function () {


                $('#project').change(function () {
                    var name = $('option:selected', $(this)).val();
//                    alert(name+" hey name");
                    $('#requirement').find('option').remove();
                    $.ajax({
                        url: "getrequirements",
                        dataType: "json",
                        type: "post",
                        data: {
                            projectid: name
                        },
                        cache: false,
                        success: function (data) {
//                            alert(" hey name m back");
                            if (data) {
                                for (var i = 0; i < data.length - 1; i++) {
                                    $('#requirement').append('<option selected="selected">' + data[i].requirement + '</option>');
                                }
                            }
                        },
                        error: function () {
                            alert('Error');
                        }

                    });

                });

            });
        </script>
        <script type="text/javascript">
            function MM_jumpMenu(targ, selObj, restore) { //v3.0
                eval(targ + ".location='" + selObj.options[selObj.selectedIndex].value + "'");
                if (restore)
                    selObj.selectedIndex = 0;
            }
            $(function () {
                $("#datepicker").datepicker({dateFormat: 'yy-mm-dd'});
            });
        </script>
    </head>
    <body>
        <div>

            <div id="show" class="bodycontainer">
                <div id="rwb" class="rwb">
                    <form action="insertLead" method="POST">
                        <div class="bodyText mandatory"> </div>
                        <p>
                            <img src="image/lead2.png" width="41" height="43" align="absmiddle" /> &nbsp;&nbsp;<strong class="text001">CREATE LEAD</strong>
                            <br />
                            <br />
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
                                            <td class="label" width="25%"> * Date: </td>
                                            <td class="element" width="25%"><input name="date" type="text" class="input" id="datepicker" required="" title="enter your date" placeholder="Enter Your Date"/></td>
                                            <td class="label" width="25%"> * Name: </td>
                                            <td class="element" width="25%"><input name="name" type="text" class="input" required="" onkeypress="javascript:return isTextKey(event);" title="enter your name" placeholder="Enter Your Name"/></td>
                                        </tr>
                                        <tr id="row1_Lead Information">
                                            <td class="label" width="25%"> * Mobile: </td>
                                            <td class="element" width="25%">
                                                <input name="mobile" type="text" class="input" required="" onkeypress="javascript:return isNumberKey(event);" title="enter your mobile number" placeholder="Enter Your Mobile Number" maxlength="10"/>
                                            </td>
                                            <td class="label" width="25%"> Phone: </td>
                                            <td class="element" width="25%">
                                                <input name="phone" type="text" class="input"  onkeypress="javascript:return isNumberKey(event);" title="enter your phone number" placeholder="Enter Your Phone Number" maxlength="12" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Email</td>
                                            <td class="element"><input name="email" type="email" class="input" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"  title="enter your email" placeholder="Enter Your Email"/></td>
                                            <td class="label">Broker</td>
                                            <td class="element">
                                                <select name="broker" class="select" id="broker" required="">
                                                    <option selected="" value="NA">NA</option>
                                                    <c:forEach var="ob" items="${userdt}">
                                                        <option value="${ob.id}">${ob.name}</option>
                                                    </c:forEach>
                                                </select><br><a href="addBroker" id="addBroker_link">Add Broker</a>
                                            </td>
                                        </tr>
                                        <tr id="row3_Lead Information">
                                            <td class="label" width="25%">Project Name</td>
                                            <td class="element" width="25%">
                                                <select name="projectname" class="select" id="project" required="">
                                                    <option selected="" value="">-- Select Project --</option>
                                                    <c:forEach var="ob" items="${projectdt}">
                                                        <option value="${ob.projectid}">${ob.name}</option>                                    
                                                    </c:forEach>                                    
                                                </select>
                                            </td>
                                            <td class="label" width="25%">Requirement</td>
                                            <td class="element" width="25%">
                                                <select name="requirement" class="select" id="requirement" required="">
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Lead Owner:</td>
                                            <td class="element">
                                                <select name="leadowner" class="select">
                                                    <c:forEach var="ob" items="${executivedt}">
                                                        <option value="${ob.id}">${ob.name}</option>
                                                    </c:forEach>
                                                </select>
                                                <!--                                <input type="text" value="$ {sessionScope.USERNAME}"  readonly="" class="input"/>
                                                                                <input type="hidden" value="$ {sessionScope.USERID}" name="Lowner"  class="input"/>-->
                                            </td>
                                            <td class="label">Lead Status:</td>
                                            <td class="element">
                                                <select name="leadstatus" class="select" required="">
                                                    <option value="">-- Select Status --</option>
                                                    <option>Info Given</option>
                                                    <option>Not Interested</option>
                                                    <option>Booked</option>
                                                    <option>Will Book</option>
                                                    <option>Revisit</option>
                                                    <option>Call Back</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="row4_Lead Information">
                                            <td class="label" width="25%"> Loan </td>
                                            <td class="element" width="25%">
                                                <input type="radio" name="loan" value="Yes" class="radio" />Yes<input type="radio" name="loan" value="No" class="radio" checked/>No
                                            </td>
                                            <td class="label" width="25%">&nbsp;</td>
                                            <td class="element" width="25%">&nbsp;</td>
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
                                                <textarea name="address" cols="" rows="" class="textarea"  title="enter address" placeholder="Enter Address"></textarea>  
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="btn2">
                                <input type="submit" value="Save And New" name="red" class="newbtn" /> 
                                <input type="submit" value="Submit" name="red" class="newbtn" id="submit1"/>  <input type="reset" value="Clear All" class="newbtn"/> <a href="ShowLeadGridView.jsp" class="newbtn">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </body>
</html>
