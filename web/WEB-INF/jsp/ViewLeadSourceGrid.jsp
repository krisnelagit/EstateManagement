<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewLeadSourceGrid
    Created on : 9 Dec, 2015, 12:27:13 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Lead Source</title>
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
                        url: "editLeadSourceLink",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            id: areaid
                        },
                        cache: false,
                        success: function (data) {
                            $("#areaid").val(data[0].leadsourceid);
                            $("#areaname").val(data[0].leadname);

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
                        url: "deleteleadsourcerecord",
                        data: {id: id, deskname: "leadsource"
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
                <strong class="heading"><img src="images/source.png" align="absmiddle" />Lead Source</strong>

            </div>
            <div class="newstyle3">
                <table class="display tablestyle" id="table_id">
                    <thead>
                        <tr>
                            <th align="left">Source Name</th>
                            <th align="left">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ob" items="${leadsourcedt}">
                            <tr>
                                <td>${ob.leadname}</td>
                                <td>
                                    <a href="${ob.leadsourceid}" class="edit_link"><img src="images/edit_1.png" class="edit"/></a> &nbsp;&nbsp; 
                                    <a onclick="confirmdelete('${ob.leadsourceid}', this);" class="edit_link" title="Delete" ><img src="images/delete_1.png" class="delete"/></a> 
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!--code for dialog to add new area begins here-->
        <div id="dialognk" title="Add Lead Source">
            <form action="addLeadSource" method="POST">        
                <table width="100%" cellpadding="5">
                    <tr>
                        <td>Lead Source Name</td>
                        <td><input type="text" name="leadname" value="" class="input001" required="" placeholder="Lead Source Name"/></td>
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
        <div id="dialogeditnk" title="Edit Lead Source">
            <form action="updateLeadSource" method="POST">  
                <input type="hidden" name="leadsourceid" id="areaid" value="" />
                <table width="100%" cellpadding="5">
                    <tr>
                        <td>Lead Source Name</td>
                        <td><input type="text" name="leadname" value="" class="input001" required="" id="areaname" placeholder="Lead Source Name"/></td>
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
