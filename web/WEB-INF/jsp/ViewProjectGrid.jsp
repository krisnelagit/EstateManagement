<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewProjectGrid
    Created on : 9 Dec, 2015, 1:05:52 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Projects</title>
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
                        url: "deleteprojectrecord",
                        data: {id: id, deskname: "projectmaster"
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
                else {
                    var res = confirm("Are you sure to delete?");
                    if (res === true) {
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
        <a href="#" onclick="checkdelete(this);" style="cursor: pointer;" class="newbtn2">Delete</a>&nbsp; &nbsp; 
        <a href="addProjectlink" class="newbtn2">Add</a>
        <strong class="heading"><img src="image/projects.png" align="absmiddle" /> Project Master</strong>
        <hr class=" hr"/>
        <form action="multipleDeleteProject" id="myform" method="POST">
            <table class="display tablestyle" id="table_id">
                <thead>
                    <tr>
                        <th>&nbsp;</th>
                        <th align="left">Name</th>
                        <th align="left">Location</th>
                        <th align="left">Address</th>
                        <th align="left">Builder Name</th>
                        <th align="left">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ob" items="${projectdt}">
                        <tr>
                            <td> <input type="checkbox" style="height: 20px" name="chkuser" value="${ob.projectid}" /> </td>
                            <td>${ob.name}</td> 
                            <td>${ob.location}</td> 
                            <td>${ob.address}</td> 
                            <td>${ob.buildernameJ}</td> 
                            <td>
                                <a href="editprojectLink?id=${ob.projectid}" class="edit_link"><img src="images/edit_1.png" class="edit"/></a> &nbsp;
                                <a href="viewSlabMasterLink?projectid=${ob.projectid}"><img src="images/slab.png" title="Add Slab" class="edit"/></a>&nbsp; 
                                <a onclick="confirmdelete('${ob.projectid}', this);" title="Delete" ><img src="images/delete_1.png" width="16" height="17" /></a>&nbsp; 
                                <a href="viewWingGridLink?projectid=${ob.projectid}"><img src="images/slab.png" title="View Wing" class="edit"/></a>

                            </td> 
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </form>
    </body>
</html>
