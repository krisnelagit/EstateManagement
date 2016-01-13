<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewBuilderPaymentGrid
    Created on : 15 Dec, 2015, 4:18:41 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Builder payment</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css"/>
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                //getting datatable ready
                $('#table_id').DataTable();
            });
        </script>
        <style>
            a:link {
                color: #333;
            }
            select{
                width: 60px;
                padding: 5px;
                height: 30px;
                border: thin #CCC solid;
            }
        </style>
    </head>
    <body>
        <strong class="heading"><img src="images/profile.png" align="absmiddle" /> Builder Payment</strong>
        <hr class=" hr"/>
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <th align="left">Project Name</th>
                    <th align="left">JE Percent</th>
                    <th align="left">Balance</th>
                    <th align="left">Total</th>
                    <th align="left">Paid</th>
                    <th align="left">Status</th>
                    <th align="left">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ob" items="${builderdt}">            
                    <tr>
                        <td>${ob.name}</td>
                        <td>${ob.jepercent}</td>
                        <td>${ob.balance}</td>
                        <td>${ob.total}</td>
                        <td>${ob.totalpaid}</td>
                        <td>${ob.status}</td>
                        <td>
                            <a href="../Edit/AddPaymentBuilder.jsp?Callerid=${ob.projectid}" class="email_link"><img src="images/edit_1.png" class="edit"/></a> &nbsp;&nbsp;
                            <a href="#" onclick="deleterecord('${ob.projectid}')"><img src="images/delete_1.png" class="delete"/></a>
                            &nbsp;  <a href="viewdetails.jsp?pid=${ob.projectid}">Payment Details</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
