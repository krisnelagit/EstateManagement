<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewSlabMaster
    Created on : 10 Dec, 2015, 12:06:56 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Slab</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css"/>
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {
                $("#dialognk").hide();

                //calls to open the dialog
                $(".create_link").click(function (e) {
                    e.preventDefault();
                    console.log("hey im clicked");
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
                    console.log("hey im after dialog clicked");
                });
            });
        </script>
        <style>
            .box01{
                width: 180px;
            }
        </style>
    </head>
    <body>
        <input class="create_link" style="float: right" type="button" value="Add">
        <br/>
        <c:forEach var="ob" items="${slabdt}">
            <div class="box02 fadeIn animated"> 
                <a href="addslabsproject?projectid=${param.projectid}&slab_master_id=${ob.slab_master_id}">
                    <div class="text02">${ob.slab_master_name}
                    </div>
                </a>
            </div>
        </c:forEach>

        <!--add new slab code begins here-->
        <div id="dialognk" title="Add Slab">
            <form action="insertSlab" method="POST">
                <input type="hidden" name="project_requirement_id" value="${param.projectid}" />
                <table width="100%" cellpadding="5">
                    <tr>
                        <td>Slab Name</td>
                        <td><input type="text" name="slab_master_name" value="" class="input001" required="" placeholder="Area Name"/></td>
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
            </form>        
        </div>
        <!--add new slab code ends! here-->


    </body>
</html>
