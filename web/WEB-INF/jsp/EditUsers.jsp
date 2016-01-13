<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditUsers
    Created on : 8 Dec, 2015, 3:40:01 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit users</title>        
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script> 
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css"/>        
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/bootstrap-multiselect.js"></script>
        <script>
            $(document).ready(function (){
                $('.table_id').DataTable();
                $('.multiselect').multiselect();
            });
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
        <form action="updateusers" method="POST">
            <input type="hidden" name="id" value="${usersdt.id}" />
            <table border="0" cellpadding="3" cellspacing="3" class="box04">
                <thead>
                    <tr>
                        <th colspan="2" align="left">Edit User</th>

                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td align="left">Name</td>
                        <td align="left"> <input type="text" name="name" value="${usersdt.name}" class="input001" required="" onkeypress="javascript:return isTextKey(event);" title="enter your name" placeholder="Enter Your Name"/> </td>
                    </tr>
                    <tr>
                        <td align="left">Address</td>
                        <td align="left"> 
                            <!--<input type="text" name="txtNewUserAddress" value="" class="input001" required=""/>-->
                            <textarea name="address" rows="4" cols="20" class="input001 select" required="" placeholder="Enter Your Address">${usersdt.address}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">Mobile</td>
                        <td align="left"> <input type="text" name="mobile" value="${usersdt.mobile}" class="input001" required="" onkeypress="javascript:return isNumberKey(event);" title="enter your mobile number" placeholder="Enter Your Mobile Number" maxlength="10"/> </td>
                    </tr>
                    <tr>
                        <td align="left">Email</td>
                        <td align="left"> <input type="email" name="email"  value="${usersdt.email}" class="input001" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" required=""  title="enter your email" placeholder="Enter Your Email"/> </td>
                    </tr>
                    <tr>
                        <td align="left">Login Id</td>
                        <td align="left"> <input type="text" name="login_id" value="${usersdt.login_id}" class="input001" required="" onkeypress="javascript:return isTextKey(event);" title="enter your login id" placeholder="Enter Your Login Id"/> </td>
                    </tr>
                    <tr>
                        <td align="left">Password</td>
                        <td align="left"> <input type="password" name="password" value="${usersdt.password}" class="input001" required="" title="enter password" placeholder="Enter Password" id="password"/> </td>
                    </tr>
                    <tr>
                        <td align="left">Type</td>
                        <td align="left"> <input type="text" name="type" value="${usersdt.type}" readonly="" class="input001"  title="enter password" placeholder="Enter Password"/> </td>
                    </tr>
                    <c:choose>
                        <c:when test="${(usersdt.type ne 'Broker') && (usersdt.type ne 'Builder')}">
                            <tr>
                                <td align="left">Incentives</td>
                                <td align="left"><input type="number" name="incentives" value="${usersdt.incentives}" class="input001" required=""/></td>
                            </tr>
                        </c:when>
                        <c:when test="${(usersdt.type ne 'Builder') && (usersdt.type ne 'Sales Manager') && (usersdt.type ne 'Calling Executive')}">
                            <tr>
                                <td align="left">Brokerage</td>
                                <td align="left"><input type="number" name="brokerage" value="${usersdt.brokerage}" class="input001" required=""/></td>
                            </tr>
                        </c:when>
                        <c:when test="${(usersdt.type=='Project Manager') || (usersdt.type=='Sales Executive')
                                        || (usersdt.type=='Sales Manager') || (usersdt.type=='Campaign Manager') 
                                        || (usersdt.type=='Area Manager')}">
                            <c:choose>
                                <c:when test="${(usersdt.type=='Project Manager') || (usersdt.type=='Sales Executive')
                                                || (usersdt.type=='Sales Manager') || (usersdt.type=='Campaign Manager')}">
                                        <tr id="project2">
                                            <td align="left">Project</td>
                                            <td align="left">
                                                <select name="drpExistUserMultiproject" class="multiselect" multiple="multiple">
                                                    <c:forEach var="obj" items="${projectsdt}">
                                                        <option value="${obj.projectid}">${obj.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                </c:when>
                                <c:when test="${usersdt.type=='Area Manager'}">
                                    <tr id="project3">
                                        <td align="left">area</td>
                                        <td align="left">
                                            <select name="drpExistUserMultiArea" class="multiselect" multiple="multiple">
                                                <c:forEach var="obj" items="${areasdt}">
                                                    <option value="${obj.areaid}">${obj.name}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                </c:when>
                            </c:choose>
                            <tr>
                        <table class="display tablestyle table_id" id="dataTable">
                            <thead>
                                <tr>
                                    <th align="left">Name</th>
                                    <th align="left">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="obc" items="${customList}">
                                    <tr>
                                        <td>${obc.projareaname}</td>
                                        <td>delete code</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        </tr>
                    </c:when>
                </c:choose>   
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <input type="submit" value="Update" class="newbtn3"/>
                    </td>

                </tr>
                </tbody>
            </table>
        </form>
    </center>
</body>
</html>
