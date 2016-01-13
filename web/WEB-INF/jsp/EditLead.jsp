<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 
    Document   : EditLead
    Created on : 18 Dec, 2015, 5:54:57 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Lead</title>
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <style>
            html {
                overflow-y: scroll; 
            }
        </style>
        <style>
            .CSSTableGenerator {
                margin:0px;padding:0px;
                width:100%;
                border:1px solid #e8e8e8;

                -moz-border-radius-bottomleft:0px;
                -webkit-border-bottom-left-radius:0px;
                border-bottom-left-radius:0px;

                -moz-border-radius-bottomright:0px;
                -webkit-border-bottom-right-radius:0px;
                border-bottom-right-radius:0px;

                -moz-border-radius-topright:0px;
                -webkit-border-top-right-radius:0px;
                border-top-right-radius:0px;

                -moz-border-radius-topleft:0px;
                -webkit-border-top-left-radius:0px;
                border-top-left-radius:0px;
            }.CSSTableGenerator table{
                border-collapse: collapse;
                border-spacing: 0;
                width:100%;
                height:100%;
                margin:0px;padding:0px;
            }.CSSTableGenerator tr:last-child td:last-child {
                -moz-border-radius-bottomright:0px;
                -webkit-border-bottom-right-radius:0px;
                border-bottom-right-radius:0px;
            }
            .CSSTableGenerator table tr:first-child td:first-child {
                -moz-border-radius-topleft:0px;
                -webkit-border-top-left-radius:0px;
                border-top-left-radius:0px;
            }
            .CSSTableGenerator table tr:first-child td:last-child {
                -moz-border-radius-topright:0px;
                -webkit-border-top-right-radius:0px;
                border-top-right-radius:0px;
            }.CSSTableGenerator tr:last-child td:first-child{
                -moz-border-radius-bottomleft:0px;
                -webkit-border-bottom-left-radius:0px;
                border-bottom-left-radius:0px;
            }.CSSTableGenerator tr:hover td{

            }
            .CSSTableGenerator tr:nth-child(odd){ background-color:#f4f4f4; }
            .CSSTableGenerator tr:nth-child(even)    { background-color:#ffffff; }.CSSTableGenerator td{
                vertical-align:middle;


                border:1px solid #e8e8e8;
                border-width:0px 1px 1px 0px;
                text-align:left;
                padding:7px;
                font-size:10px;
                font-family:Arial;
                font-weight:normal;
                color:#000000;
            }.CSSTableGenerator tr:last-child td{
                border-width:0px 1px 0px 0px;
            }.CSSTableGenerator tr td:last-child{
                border-width:0px 0px 1px 0px;
            }.CSSTableGenerator tr:last-child td:last-child{
                border-width:0px 0px 0px 0px;
            }
            .CSSTableGenerator tr:first-child td{
                background:-o-linear-gradient(bottom, #f4f4f4 5%, #f4f4f4 100%);	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #f4f4f4), color-stop(1, #f4f4f4) );
                background:-moz-linear-gradient( center top, #f4f4f4 5%, #f4f4f4 100% );
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#f4f4f4", endColorstr="#f4f4f4");	background: -o-linear-gradient(top,#f4f4f4,f4f4f4);

                background-color:#f4f4f4;
                border:0px solid #e8e8e8;
                border-width:0px 0px 1px 1px;
                color:#333333;
            }
            .CSSTableGenerator tr:first-child:hover td{
                background:-o-linear-gradient(bottom, #f4f4f4 5%, #f4f4f4 100%);	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #f4f4f4), color-stop(1, #f4f4f4) );
                background:-moz-linear-gradient( center top, #f4f4f4 5%, #f4f4f4 100% );
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#f4f4f4", endColorstr="#f4f4f4");	background: -o-linear-gradient(top,#f4f4f4,f4f4f4);

                background-color:#f4f4f4;
            }
            .CSSTableGenerator tr:first-child td:first-child{
                border-width:0px 0px 1px 0px;
            }
            .CSSTableGenerator tr:first-child td:last-child{
                border-width:0px 0px 1px 1px;
            }
        </style>
        <script>
            $(document).ready(function () {
                //hides the add dialog on pageload
                $("#dialognk").hide();

                //calls to open the dialog
                $(".adddescription_link").click(function (e) {
                    e.preventDefault();

                    $("#dialognk").dialog({
                        modal: true,
                        effect: 'drop',
                        width: 450,
                        height: 200,
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });
                });
            });
        </script>
    </head>
    <body>
        <form action="updateLead" method="POST">
            <div id="show" class="bodycontainer">
                <div id="rwb" class="rwb">
                    <p><img src="image/lead2.png" width="41" height="43" align="absmiddle" /> &nbsp;&nbsp;<strong class="text001">EDIT LEAD</strong><br />
                        <br />
                    </p>
                    <div id="preHTMLContainer">
                        <div id="secDivLead Information">
                            <table id="secHeadLead Information" cellpadding="0" cellspacing="0" width="95%">
                                <tbody width="100%">
                                    <tr>
                                        <td class="secHead"> Lead Information &nbsp;&nbsp; ref. no: <input type="text" name="" class="input"  value="${param.id}" readonly="readonly" disabled="disabled" /> </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table id="secContentLead Information" class="secContent" border="0" cellpadding="0" cellspacing="1" width="95%">
                                <tbody width="100%">
                                    <tr id="row0_Lead Information">
                                        <td class="label" width="25%"> * Date: <input type="hidden" name="leadid" value="${param.id}" /> </td>
                                        <td class="element" width="25%"><input name="date" type="text" value="${leaddt.date}" class="input" id="datepicker" required="" title="enter your date"  placeholder="Enter Your Date"/></td>
                                        <td class="label" width="25%"> * Name: </td>
                                        <td class="element" width="25%"><input name="name" type="text" value="${leaddt.name}" class="input" onkeypress="javascript:return isTextKey(event);"  required="true" title="enter your name"  placeholder="Enter Your Name" /></td>
                                    </tr>
                                    <tr id="row1_Lead Information">
                                        <td class="label" width="25%"> * Mobile: </td>
                                        <td class="element" width="25%">
                                            <input name="mobile" type="text" value="${leaddt.mobile}" class="input" onkeypress="return isNumberKey(event)" min="8" maxlength="10" required="true" title="enter your mobile number" placeholder="Enter Your Mobile Number" readonly/>
                                        </td>
                                        <td class="label" width="25%"> Phone: </td>
                                        <td class="element" width="25%">
                                            <input name="phone" value="" type="text" value="${leaddt.phone}" class="input"  onkeypress="javascript:return isNumberKey(event);" title="enter your phone number" placeholder="Enter Your Phone Number" maxlength="12" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label">Email</td>
                                        <td class="element">
                                            <c:choose>
                                                <c:when test="${not empty leaddt.email}">
                                                    <input name="email" type="text" value="${leaddt.email}" class="input" onkeypress="return isNumberKey(event)" min="8" maxlength="10"  title="enter your phone no" placeholder="Enter Your Phone No."/>
                                                </c:when>
                                                <c:otherwise>
                                                    <input name="email" type="text" value="noemail@given.com" class="input" onkeypress="return isNumberKey(event)" min="8" maxlength="10"  title="enter your phone no" placeholder="Enter Your Phone No."/>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>                            
                                        <td class="label">Broker</td>
                                        <td class="element">
                                            <select name="broker" class="select" id="broker" required="">
                                                <option selected="" value="NA" >NA</option>
                                                <c:forEach var="ob" items="${brokerdt}">
                                                    <c:choose>
                                                        <c:when test="${ob.id==leaddt.broker}">
                                                            <option value="${ob.id}" selected="" >${ob.name}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${ob.id}" >${ob.name}</option>
                                                        </c:otherwise>
                                                    </c:choose>                                        
                                                </c:forEach>                                    
                                            </select>
                                        </td>
                                    </tr>
                                    <tr id="row3_Lead Information">
                                        <td class="label" width="25%">Project Name</td>
                                        <td class="element" width="25%">
                                            <select name="projectname" class="select"  id="project" required="">
                                                <c:forEach var="ob" items="${projectdt}">
                                                    <c:choose>
                                                        <c:when test="${ob.projectid==leaddt.projectname}">
                                                            <option selected="" value="${ob.projectid}">${ob.name}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${ob.projectid}">${ob.name}</option>
                                                        </c:otherwise>
                                                    </c:choose>                                        
                                                </c:forEach>                                    
                                            </select>
                                            <div id="msgproject"></div>
                                        </td>
                                        <td class="label" width="25%">Requirement</td>
                                        <td class="element" width="25%">
                                            <select name="requirement" class="select" id="requirement" required="">
                                                <c:forEach var="ob" items="${projectddr}">
                                                    <c:set var="requirement" value="${ob.requirement}"/>
                                                    <c:set var="requirementparts" value="${fn:split(requirement, ' ')}" />
                                                    <c:choose>
                                                        <c:when test="${requirementparts[0]==leaddt.requirement}">
                                                            <option selected="true" >${requirementparts[0]}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option>${requirementparts[1]}</option>
                                                        </c:otherwise>
                                                    </c:choose>                                        
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label">Lead Owner:</td>
                                        <td class="element">
                                            <select name="leadowner" class="select">
                                                <c:forEach var="ob" items="${executivedt}">
                                                    <c:choose>
                                                        <c:when test="${ob.id==leaddt.leadowner}">
                                                            <option selected="" value="${ob.id}">${ob.name}</option>                                                
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${ob.id}">${ob.name}</option>    
                                                        </c:otherwise>
                                                    </c:choose>                                        
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td class="label">Lead Status:</td>
                                        <td class="element">
                                            <select name="leadstatus" class="select" required="">
                                                <option value="">-- Select Status --</option>
                                                <c:choose>
                                                    <c:when test="${leaddt.leadstatus=='Info Given'}">
                                                        <option selected="">Info Given</option>
                                                        <option>Not Interested</option>
                                                        <option>Booked</option>
                                                        <option>Will Book</option>
                                                        <option>Revisit</option>
                                                        <option>Call Back</option>
                                                    </c:when>
                                                    <c:when test="${leaddt.leadstatus=='Not Interested'}">
                                                        <option>Info Given</option>
                                                        <option selected="">Not Interested</option>
                                                        <option>Booked</option>
                                                        <option>Will Book</option>
                                                        <option>Revisit</option>
                                                        <option>Call Back</option>
                                                    </c:when>
                                                    <c:when test="${leaddt.leadstatus=='Booked'}">
                                                        <option>Info Given</option>
                                                        <option>Not Interested</option>
                                                        <option selected="">Booked</option>
                                                        <option>Will Book</option>
                                                        <option>Revisit</option>
                                                        <option>Call Back</option>
                                                    </c:when>
                                                    <c:when test="${leaddt.leadstatus=='Will Book'}">
                                                        <option>Info Given</option>
                                                        <option>Not Interested</option>
                                                        <option>Booked</option>
                                                        <option selected="">Will Book</option>
                                                        <option>Revisit</option>
                                                        <option>Call Back</option>
                                                    </c:when>
                                                    <c:when test="${leaddt.leadstatus=='Revisit'}">
                                                        <option>Info Given</option>
                                                        <option>Not Interested</option>
                                                        <option>Booked</option>
                                                        <option>Will Book</option>
                                                        <option selected="">Revisit</option>
                                                        <option>Call Back</option>
                                                    </c:when>
                                                    <c:when test="${leaddt.leadstatus=='Call Back'}">
                                                        <option>Info Given</option>
                                                        <option>Not Interested</option>
                                                        <option>Booked</option>
                                                        <option>Will Book</option>
                                                        <option>Revisit</option>
                                                        <option selected="">Call Back</option>
                                                    </c:when>
                                                </c:choose>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr id="row4_Lead Information">
                                        <td class="label" width="25%"> Loan </td>
                                        <td class="element" width="25%">
                                            <c:choose>
                                                <c:when test="${leaddt.loan=='No'}">
                                                    <input type="radio" name="loan" value="Yes" class="radio" />Yes<input type="radio" name="loan" value="No" class="radio" checked/>No
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="radio" name="loan" value="Yes" class="radio" checked/>Yes<input type="radio" name="loan" value="No" class="radio" />No
                                                </c:otherwise>
                                            </c:choose>                                
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
                                            <textarea name="address" cols="" rows="" class="textarea"  title="enter address" placeholder="Enter Address">${leaddt.address}</textarea>  
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <p> </p>
                        <div id="secDivDescription Information">
                            <table id="secContentDescription Information" class="secContent" border="0" cellpadding="0" cellspacing="1" width="95%">
                                <tbody width="100%">
                                    <tr>
                                        <td class="secHead"> Description Information </td>
                                    </tr>
                                </tbody>                           
                            </table>
                            <table id="secContentDescription Information" class="secContent" border="0" cellpadding="0" cellspacing="1" width="95%">
                                <tbody width="100%">
                                    <tr id="row0_Description Information"><br/>
                                <a href="#" class="newbtn adddescription_link" style="float:right; margin-right:50px;">Add</a>
                                <td class="label" width="25%"> Description: </td>
                                <td class="element" width="0%">
                                    <div class="CSSTableGenerator">
                                        <table border="1">
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Comments</th>
                                                    <th>Comments By</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="ob" items="${commentsdt}">
                                                    <tr>
                                                        <td style="text-align: center">${ob.date}</td>
                                                        <td style="text-align: center">${ob.comments}</td>
                                                        <td style="text-align: center">${ob.commentsby}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="btn2">
                            <input type="submit" value="Update" name="red" class="newbtn" id="submit1"/>  
                            <a href="viewLeadGridLink" class="newbtn">Cancel</a>
                        </div>
                    </div>
                </div>
            </div>                            
        </form>

        <!--code for dialog to add new Description for vicidial begins here-->
        <div id="dialognk" title="Add Comments">
            <form action="insertVicidialComments" method="POST">        
                <table width="100%" cellpadding="5">
                    <tr>
                        <td>Comments</td>
                        <td>
                            <textarea name="comments" rows="4" cols="20" class="textarea" id="commentshere" required=""></textarea>
                            <input type="hidden" name="phonenumber" id="phonenumber" value="${leaddt.mobile}" />
                            <input type="hidden" name="commentsby" id="commentsby" value="${leaddt.leadowner}" />
                            <input type="hidden" name="editleadid" id="editleadid" value="${param.id}" />
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" value="Add" class="newbtn"/></td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br>
            </form>
        </div>
        <!--code for dialog to add new Description for vicidial ends! here-->
    </body>
</html>
