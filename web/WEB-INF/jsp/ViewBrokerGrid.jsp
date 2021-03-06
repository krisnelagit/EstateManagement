<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewBrokerGrid
    Created on : 9 Dec, 2015, 11:56:37 AM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Brokers</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css"/>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
        </script>
        <script>
            function confirmdelete(id, ob)
            {
                var res = confirm('Are you sure to delete?');
                if (res === true)
                {
                    $(ob).closest('tr').find('td').fadeOut(600,
                            function () {
                                $(ob).parents('tr:first').remove();
                            });

                    $.ajax({
                        type: "post",
                        url: "deleterecord",
                        data: {id: id, deskname: "userdetails"
                        },
                        success: function (data) {
                        },
                        error: function () {
                        }
                    });
                }
            }
            
            //for multiple select and delete
            function checkdelete(o) {
                if ($("input:checked").length < 1)
                    return false;
                else{
                    var res=confirm("Are you sure to delete?");
                    if(res===true){
                        $('#myform').submit();
                    }
                }
            }
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
        <a href="#" onclick="checkdelete(this);" style="cursor: pointer;" class="newbtn2">Delete</a>
        <strong class="heading"><img src="image/broker.png" align="absmiddle" /> Broker Master</strong>
        <hr class=" hr"/>
        <form action="multipleDeleteBroker" id="myform" method="POST">
            <table class="display tablestyle" id="table_id">
                <thead>
                    <tr>
                        <th>&nbsp;</th>
                        <th align="left">Name</th>
                        <th align="left">Location</th>
                        <th align="left">Telephone</th>
                        <th align="left">Email</th>
                        <th align="left">Brokerage</th>
                        <th align="left">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ob" items="${brokerdt}">
                        <tr>
                            <td><input type="checkbox" style="height: 20px" name="chkuser" value="${ob.id}" /></td>
                            <td>${ob.name}</td>
                            <td>${ob.address}</td>
                            <td>${ob.mobile}</td>
                            <td>${ob.email}</td>
                            <td>${ob.brokerage}</td>
                            <td>
                                <a href="editusersLink?id=${ob.id}" class="edit_link"><img src="images/edit_1.png" class="edit"/></a> &nbsp;&nbsp;
                                <a onclick="confirmdelete('${ob.id}', this);" title="Delete" ><img src="images/delete_1.png" width="16" height="17" /></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </form>
    </body>
</html>
