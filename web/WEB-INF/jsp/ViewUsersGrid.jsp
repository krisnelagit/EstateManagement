<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewUsersGrid
    Created on : 8 Dec, 2015, 3:34:27 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
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
        <a href="#" onclick="checkdelete(this);" style="cursor: pointer;" class="newbtn2">Delete</a>&nbsp;&nbsp;
        <a href="adduserlink" class="newbtn2">Add</a>
        <strong class="heading"><img src="images/profile.png" align="absmiddle" /> User Details</strong>
        <hr class=" hr"/>
        <form action="multipleDeleteCreateUser" id="myform" method="POST">
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <th>&nbsp;</th>
                    <th align="left">Name</th>
                    <th align="left">Address</th>
                    <th align="left">Mobile</th>
                    <th align="left">Email</th>
                    <th align="left">Login Id</th>
                    <th align="left">Password</th>
                    <th align="left">Type</th>
                    <th align="left">Incentives</th>
                    <th align="left">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ob" items="${usersdt}">
                    <tr>
                        <td> <input type="checkbox" style="height: 20px" name="chkuser" value="${ob.id}" /> </td>
                        <td>${ob.name}</td> 
                        <td>${ob.address}</td> 
                        <td>${ob.mobile}</td> 
                        <td>${ob.email}</td> 
                        <td>${ob.login_id}</td> 
                        <td>${ob.password}</td> 
                        <td>${ob.type}</td> 
                        <td>${ob.incentives}</td>
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
