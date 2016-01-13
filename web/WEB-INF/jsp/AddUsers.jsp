<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddUsers
    Created on : 8 Dec, 2015, 3:40:01 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add users</title>        
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script> 
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css"/>        
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/bootstrap-multiselect.js"></script>
        <script>
            $(document).ready(function () {
                var droplist = $('#dropdownlist');
                $('#project1').hide();
                $('#project2').hide();
                $('#project3').hide();
                $('#Incentives').hide();
                $('#Brokerage').hide();
                document.getElementById("IncentivesText").required = false;
                document.getElementById("BrokerageText").required = false;
                droplist.change(function (e) {
                    if (droplist.val() == 'Broker') {
                        $('#Brokerage').show();
                        $('#project2').hide();
                        $('#project3').hide();
                        $('#Incentives').hide();
                        document.getElementById("IncentivesText").required = false;
                        document.getElementById("BrokerageText").required = true;
                    }
                    else if (droplist.val() == 'Project Manager' || droplist.val() == 'Campaign Manager' || droplist.val() == 'Sales Executive')
                    {
                        $('#project2').show();
                        $('#project1').hide();
                        $('#project3').hide();
                        $('#Incentives').hide();
                        $('#Brokerage').hide();
                        document.getElementById("IncentivesText").required = false;
                        document.getElementById("BrokerageText").required = false;
                    }
                    else if (droplist.val() == 'Sales Manager')
                    {
                        $('#project2').show();
                        $('#project1').hide();
                        $('#project3').hide();
                        $('#Incentives').show();
                        $('#Brokerage').hide();

                        document.getElementById("IncentivesText").required = true;
                        document.getElementById("BrokerageText").required = false;
                    }
                    else if (droplist.val() == 'Area Manager')
                    {
                        $('#project3').show();
                        $('#project1').hide();
                        $('#project2').hide();
                        $('#Incentives').hide();
                        $('#Brokerage').hide();
                        document.getElementById("IncentivesText").required = false;
                        document.getElementById("BrokerageText").required = false;
                    }
                    else if (droplist.val() == 'Calling Executive' || droplist.val() == 'Broker Manager')
                    {
                        $('#Incentives').show();
//                        $('#IncentivesText')
                        document.getElementById("IncentivesText").required = true;
                        $('#project3').hide();
                        $('#project1').hide();
                        $('#project2').hide();
                        $('#Brokerage').hide();
                        document.getElementById("BrokerageText").required = false;
                    } else if (droplist.val() == 'Sign Up Manager')
                    {
                        $('#project2').show();
                        $('#project1').hide();
                        $('#project3').hide();
                        $('#Incentives').hide();
                        $('#Brokerage').hide();
                        document.getElementById("IncentivesText").required = false;
                        document.getElementById("BrokerageText").required = false;
                    
                    } else if (droplist.val() == 'Project Accounts Manager')
                    {
                        $('#project2').show();
                        $('#project1').hide();
                        $('#project3').hide();
                        $('#Incentives').hide();
                        $('#Brokerage').hide();
                        document.getElementById("IncentivesText").required = false;
                        document.getElementById("BrokerageText").required = false;
                    }
                    else {
                        $('#project1').hide();
                        $('#project2').hide();
                        $('#project3').hide();
                        $('#Incentives').hide();
                        $('#Brokerage').hide();
                        document.getElementById("IncentivesText").required = false;
                        document.getElementById("BrokerageText").required = false;
                    }
                })

                $('.multiselect').multiselect();
            });

            function check(input) {
                if (input.value != document.getElementById('password').value) {
                    input.setCustomValidity('New Password Must be Matching.');
                } else {
                    // input is valid -- reset the error message
                    input.setCustomValidity('');
                }
            }
        </script>
        <style>
            .input001{width: 200px; height: 30px;}
            input{width: 90px;}
            .input002{width: 50px; height: 30px}
        </style>
        <script src="js/BaseJava.js"></script>
    </head>
    <body>
    <center>
        <form action="insertUsers" method="POST">
            <table border="0" cellpadding="3" cellspacing="3" class="box04">
                <thead>
                    <tr>
                        <th colspan="2" align="left">Create New User</th>

                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td align="left">Name</td>
                        <td align="left"> <input type="text" name="name" value="" class="input001" required="" onkeypress="javascript:return isTextKey(event);" title="enter your name" placeholder="Enter Your Name"/> </td>
                    </tr>
                    <tr>
                        <td align="left">Address</td>
                        <td align="left"> 
                            <!--<input type="text" name="txtNewUserAddress" value="" class="input001" required=""/>-->
                            <textarea name="address" rows="4" cols="20" class="input001 select" required="" placeholder="Enter Your Address"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">Mobile</td>
                        <td align="left"> <input type="text" name="mobile" value="" class="input001" required="" onkeypress="javascript:return isNumberKey(event);" title="enter your mobile number" placeholder="Enter Your Mobile Number" maxlength="10"/> </td>
                    </tr>
                    <tr>
                        <td align="left">Email</td>
                        <td align="left"> <input type="email" name="email"  value="" class="input001" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" required=""  title="enter your email" placeholder="Enter Your Email"/> </td>
                    </tr>
                    <tr>
                        <td align="left">Login Id</td>
                        <td align="left"> <input type="text" name="login_id" value="" class="input001" required="" onkeypress="javascript:return isTextKey(event);" title="enter your login id" placeholder="Enter Your Login Id"/> </td>
                    </tr>
                    <tr>
                        <td align="left">Password</td>
                        <td align="left"> <input type="password" name="password" value="" class="input001" required="" title="enter password" placeholder="Enter Password" id="password"/> </td>
                    </tr>
                    <tr>
                        <td align="left">Confirm Password</td>
                        <td align="left"> <input type="password" name="confirm_password" value="" class="input001" required="" title="confirm password" placeholder="Confirm Password" oninput="check(this)"/> </td>
                    </tr>
                    <tr>
                        <td align="left">Type</td>
                        <td align="left"> 
                            <select name="type"  id="dropdownlist"  class="input003" required="">
                                <option selected="" value="">Select Type</option>
                                <c:choose>
                                    <c:when test="${sessionScope.USERTYPE.equals('Admin')}">
                                        <option>Builder</option>
                                        <option>Broker</option>
                                        <option>Broker Manager</option>
                                        <option>Calling Executive Manager</option>
                                        <option>Calling Executive</option>
                                        <option>Sales Executive</option>
                                        <option>Sales Manager</option>
                                        <option>Project Manager</option>
                                        <option>Area Manager</option>
                                        <option>Campaign Manager</option>
                                        <option>Loan Manager</option>
                                        <option>Loan Employee</option>
                                        <option>Accounts Manager</option>
                                        <option>Project Accounts Manager</option>
                                        <option>Sign Up Manager</option>
                                        <option value="Admin">Admin</option>
                                        <option value="creator">Data Manager</option>
                                    </c:when>
                                    <c:when test="${sessionScope.USERTYPE.equals('Calling Executive Manager')}">
                                        <option>Calling Executive</option>
                                        <option>Broker</option>
                                    </c:when>
                                    <c:when test="${sessionScope.USERTYPE.equals('Project Manager')}">
                                        <option>Sales Executive</option>
                                        <option>Broker</option>
                                    </c:when>
                                    <c:when test="${sessionScope.USERTYPE.equals('Broker Manager')}">
                                        <option>Broker</option>
                                    </c:when>
                                    <c:when test="${sessionScope.USERTYPE.equals('creator')}">
                                        <option>Broker</option>
                                        <option>Builder</option>
                                    </c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </td>
                    </tr>
                    <tr  id="project1">
                        <td align="left">Project</td>
                        <td align="left">
                            <select name="drpNewUserproject">
                                <option selected="">Select Project</option>
                                <c:forEach var="ob" items="${projectdt}">
                                    <option value="${ob.projectid}">${ob.name}</option>
                                </c:forEach>                                
                            </select>
                        </td>
                    </tr>
                    <tr  id="project2">
                        <td align="left">Project</td>
                        <td align="left">
                            <select name="drpNewUserMultiproject" class="multiselect" multiple="multiple">
                                <c:forEach var="ob" items="${projectdt}">
                                    <option value="${ob.projectid}">${ob.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr  id="project3">
                        <td align="left">Area</td>
                        <td align="left">
                            <select name="drpNewUserMultiArea" class="multiselect" multiple="multiple">
                                <c:forEach var="ob" items="${areadt}">
                                    <option value="${ob.areaid}">${ob.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr  id="Incentives">
                        <td align="left">Incentives</td>
                        <td align="left"> <input type="text" id="IncentivesText" name="txtNewUserIncentives"  class="input001" onkeypress="javascript:return isNumberKey(event);" title="enter your incentives" placeholder="Enter Your Incentives"/> </td>
                    </tr>
                    <tr  id="Brokerage">
                        <td align="left">Brokerage</td>
                        <td align="left"> <input type="text" id="BrokerageText" name="txtNewUserBrokerage" value="0" class="input001" onkeypress="javascript:return isNumberKey(event);" title="enter your brokerage" placeholder="Enter Your Brokerage"/> </td>
                    </tr>
                    <tr>
                        <td align="left"> </td>
                        <td align="left"><input type="submit" name="checkbtn" value="Save and New" class="newbtn"/><input name="checkbtn" type="submit" value="Create New User" class="newbtn"/> <input type="reset" value="Clear All" class="newbtn"/> <a href="viewusersgrid" class="newbtn">Cancel</a></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </center>
</body>
</html>
