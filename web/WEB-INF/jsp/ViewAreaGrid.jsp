<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewAreaGrid
    Created on : 8 Dec, 2015, 12:41:52 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Area</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css"/>
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script>
            $(function () {
                //popup for Edit followup details
                $("#dialogeditnk").hide();
                //on click of edit
                $(".edit_link").click(function (e) {
                    e.preventDefault();
                    var areaid = $(this).attr('href');
                    $("#areaid").val('');
                    $("#areaname").text('');
                    $.ajax({
                        url: "editAreaLink",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            id: areaid
                        },
                        cache: false,
                        success: function (data) {
                            $("#areaid").val(data[0].areaid);
                            $("#areaname").val(data[0].name);

                            $("#dialogeditnk").dialog({
                                modal: true,
                                effect: 'drop',
                                width: 450,
                                height: 200,
                                show: {
                                    effect: "drop"
                                },
                                hide: {
                                    effect: "drop"
                                }
                            });
                        }
                    });

                });
            });//END FUNCTION
        </script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                //getting datatable ready
                $('#table_id').DataTable();

                //hides the dialog on pageload
                $("#dialognk").hide();

                //calls to open the dialog
                $(".create_link").click(function (e) {
                    e.preventDefault();
                    $("#dialognk").dialog({
                        modal: true,
                        effect: 'drop',
                        width: 450,
                        height: 200,
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });
                });

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
            .input001{width: 200px; height: 30px;}
            input{width: 90px;}
        </style>

        <script>
            function confirmdelete(id, ob) {
                var res = confirm('Are you sure to delete?');
                if (res === true) {
                    $(ob).closest('tr').find('td').fadeOut(600,
                            function () {
                                $(ob).parents('tr:first').remove();
                            });

                    $.ajax({
                        type: "post",
                        url: "deletearearecord",
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
        <div class="newstyle">
            <div class="newstyle2">
                <a href="#" class="newbtn2 create_link">Add</a>
                <strong class="heading"><img src="image/area.png" align="absmiddle" /> Area Master</strong>

            </div>
            <div class="newstyle3">
                <table class="display tablestyle" id="table_id">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th align="left">Name</th>
                            <th align="left">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ob" items="${areadt}">
                            <tr>
                                <td> <input type="checkbox" style="height: 20px" name="chkuser" value="${ob.areaid}" /> </td>
                                <td>${ob.name}</td>
                                <td>
                                    <a href="${ob.areaid}" class="edit_link"><img src="images/edit_1.png" class="edit"/></a> &nbsp;&nbsp; 
                                    <a onclick="confirmdelete('${ob.areaid}', this);" class="edit_link" title="Delete" ><img src="images/delete_1.png" class="delete"/></a> 
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!--code for dialog to add new area begins here-->
        <div id="dialognk" title="Add Area">
            <form action="addArea" method="POST">        
                <table width="100%" cellpadding="5">
                    <tr>
                        <td>Area Name</td>
                        <td><input type="text" name="Name" value="" class="input001" required="" placeholder="Area Name"/></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" value="Submit" class="newbtn"/>&nbsp;&nbsp;&nbsp;<input type="reset" value="Reset" class="newbtn"/></td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br>
            </form>
        </div>
        <!--code for dialog to add new area ends! here-->

        <!--code for dialog to add edit area begins here-->
        <div id="dialogeditnk" title="Edit Area">
            <form action="updateArea" method="POST">  
                <input type="hidden" name="areaid" id="areaid" value="" />
                <table width="100%" cellpadding="5">
                    <tr>
                        <td>Area Name</td>
                        <td><input type="text" name="Name" value="" class="input001" required="" id="areaname" placeholder="Area Name"/></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" value="Update" class="newbtn"/>&nbsp;&nbsp;&nbsp;<input type="reset" value="Reset" class="newbtn"/></td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br>
            </form>
        </div>
        <!--code for dialog to add edit area ends! here-->

    </body>
</html>
