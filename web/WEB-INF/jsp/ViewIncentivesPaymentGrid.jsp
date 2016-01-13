<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewIncentivesPaymentGrid
    Created on : 15 Dec, 2015, 11:28:26 AM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin to Caller Payment</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css"/>
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
        <script>
            function confirmdelete(id, ob)
            {
                var res = confirm('Are you sure to delete?');
                if (res == true)
                {
                    $(ob).closest('tr').find('td').fadeOut(600,
                            function () {
                                $(ob).parents('tr:first').remove();
                            });

                    $.ajax({
                        type: "post",
                        url: "deleteIncentiverecord",
                        data: {id: id, deskname: "areamaster"
                        },
                        success: function (data) {
                        },
                        error: function () {
                        }
                    });
                }
            }
        </script>
    </head>
    <body>
        <strong class="heading"><img src="images/profile.png" align="absmiddle" /> Caller Payment</strong>
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
                <c:forEach var="ob" items="${incentivesdt}">
                    <tr>
                        <td>${ob.callername}</td>                    
                        <td>${ob.incentives}</td>                    
                        <td>${ob.balance}</td>                    
                        <td>${ob.total}</td>                    
                        <td>${ob.totalpaid}</td>                    
                        <td>${ob.status}</td>                    
                        <td>
                            <a href="editPayment?Callerid=${ob.id}" class="email_link"><img src="images/editb.png" class="edit"/></a> &nbsp;&nbsp;
                            <a href="#" onclick="deleterecord('${ob.id}')"><img src="images/deleteb.png" class="delete"/></a>
                        </td>                    
                    </tr>                
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
