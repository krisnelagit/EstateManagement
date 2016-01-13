<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewBrokeragePaymentGrid
    Created on : 15 Dec, 2015, 12:57:03 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Brokerage payment</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css"/>
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function() {
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
        <strong class="heading"><img src="images/profile.png" align="absmiddle" /> Broker Payment</strong>

        <hr class=" hr"/>
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <th align="left">Name</th>
                    <th align="left">Incentives</th>
                    <th align="left">Balance</th>
                    <th align="left">Total</th>
                    <th align="left">Paid</th>
                    <th align="left">Status</th>
                    <th align="left">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ob" items="${brokeragedt}">
                    <tr>
                        <td>${ob.name}</td>
                        <td>${ob.brokerage}</td>
                        <td>${ob.balance}</td>
                        <td>${ob.total}</td>
                        <td>${ob.totalpaid}</td>
                        <td>${ob.status}</td>
                        <td>
                            <a href="editpaymentbroker?Callerid=${ob.id}" class="email_link"><img src="images/edit_1.png" class="edit"/></a> &nbsp;&nbsp;
                            <a href="#" onclick="deleterecord('${ob.id}')"><img src="images/delete_1.png" class="delete"/></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
