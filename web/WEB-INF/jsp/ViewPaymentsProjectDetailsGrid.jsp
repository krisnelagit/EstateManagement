<%-- 
    Document   : ViewPaymentsProjectDetailsGrid
    Created on : 12 Jan, 2016, 5:35:14 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Payments</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css"/>
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/jquery.dataTables.js"></script>
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
            $(document).ready(function () {
                //getting datatable ready
                $('#table_id').DataTable();                             
            });
        </script>
    </head>
    <body>
        <!--<a href="addsignupLink" class="newbtn2 create_link">Add</a>-->
        <strong class="heading"><img src="image/contact2.png" align="absmiddle" /> Payment's</strong>
        <hr class=" hr"/>
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    
                </tr>
            </thead>
        </table>
    </body>
</html>
