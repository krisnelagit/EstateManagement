<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewVerifyLeadOwnerGrid
    Created on : 16 Dec, 2015, 10:10:37 AM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Lead Owner</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css"/>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
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
        <strong class="heading"><img src="image/area.png" align="absmiddle" /> Verify Lead Owner</strong>
        <div class="newstyle3">
            <table class="display tablestyle" id="table_id">
                <thead>
                    <tr>
                        <th align="left">Name</th>
                        <th align="left">Old Lead Owner</th>
                        <th align="left">New Lead Owner</th>
                        <th align="left">Reason</th>
                        <th align="left">Verified</th>            
                        <th align="left">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ob" items="${verifyleadownerdt}">
                        <tr>
                            <td>${ob.leadname}</td>
                            <td>${ob.oldleadowner}</td>
                            <td>${ob.newleadowner}</td>
                            <td>${ob.reason}</td>
                            <td>${ob.isverified}</td>
                            <td>
                                <a href="../Edit/VerifyLeadOwner.jsp?id=${ob.leadid}" class="email_link"><img src="images/edit_1.png" class="edit"/></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
