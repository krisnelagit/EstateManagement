<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ChangePassword
    Created on : 12 Jan, 2016, 11:52:40 AM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <style>
            .input001{width: 200px; height: 30px;}
            input{width: 90px;}
            .input002{width: 50px; height: 30px}
        </style>
        <script language='javascript' type='text/javascript'>
            function check(input) {
                if (input.value !== document.getElementById('password').value) {
                    input.setCustomValidity('New Password Must be Matching.');
                } else {
// input is valid -- reset the error message
                    input.setCustomValidity('');
                }
            }

            function checkOG(input) {
                if (input.value !== document.getElementById('userogpassword').value) {
                    input.setCustomValidity('Old Password Must be Matching.');
                } else {
// input is valid -- reset the error message
                    input.setCustomValidity('');
                }
            }
        </script>
    </head>
    <body>
    <center>
        <c:choose>
            <c:when test="${empty sessionScope.MSG}">

            </c:when>
            <c:otherwise>
                ${sessionScope.MSG}
                <c:remove var="MSG" scope="session" />
            </c:otherwise>
        </c:choose>
        <form action="updatePassword" method="post">
            <table border="0" cellpadding="5" cellspacing="5" class="box03">
                <tbody>
                    <tr>
                        <td>Old Password</td>
                        <td>
                            <input type="password" name="txtOldPassword" value="" class="input001" required="" title="enter old password" placeholder="Enter Old Password" oninput="checkOG(this)"/>
                        </td>
                    </tr>
                    <tr>
                        <td>New Password</td>
                        <td>
                            <input type="password" name="txtNewPassword" value="" class="input001" required="" title="enter new password" placeholder="Enter New Password" id="password"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Confirm New Password</td>
                        <td>
                            <input type="password" name="txtConfirmNewPassword" value="" class="input001" required="" title="confirm new password" placeholder="Confirm New Password" oninput="check(this)"/>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="hidden" name="" value="${userdt.password}" id="userogpassword"/>  <input type="hidden" name="txtuserid" value="${userdt.id}" /> </td>
                        <td><input type="submit" value="Submit" class="newbtn"/> <input type="reset" value="Reset" class="newbtn"/> </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </center>
</body>
</html>
