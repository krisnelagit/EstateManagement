<%-- 
    Document   : AdminDashboard
    Created on : 7 Dec, 2015, 5:29:14 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" type="text/css" href="css/table.css">
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables2.css">
        <link rel="stylesheet" type="text/css" href="css/modal_1.css">
        <link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css">
        <script src="js/jquery-1.10.2.min.js"></script>
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/canvas.js"></script>
        <script>
            $(document).ready(function(){
                $('#table_id').DataTable();
                $('#table_id2').DataTable();
            });
        </script>
    </head>
    <body>
         <strong class="heading"><img src="image/dashboard.png" width="22" height="22" align="absmiddle" /> &nbsp;ADMIN </strong><br />
            <hr class=" hr"/>
            <br />
            <div class="dashboard_table animated fadeIn">
                <div class="CSSTableGenerator" >

                    <p class="heading"><strong>TODAYS FOLLOW UP</strong></p><hr class="hr"/>   

                    <table class="display tablestyle" id="table_id2">
                        <thead>
                            <tr>
                                <th align="left">Date</th>
                                <th align="left">Followup by</th>
                                <th align="left">Next Followup date</th>
                                <th align="left">Lead Name</th>
                                <th align="left">Status</th>
                                <th align="left">Edit</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>   

                </div>
            </div>


            <div class="dashboard_table animated fadeIn">

                <div class="CSSTableGenerator" >

                    <p class="heading"><strong style="padding-top:10px;">TODAYS VISITS</strong></p><hr class="hr"/>  

                    <table class="display tablestyle" id="table_id">
                        <thead>
                            <tr>
                                <td bgcolor="#00436b"><strong>Date</strong></td>
                                <td bgcolor="#00436b"><strong>Name</strong></td>
                                <td bgcolor="#00436b"><strong>Time</strong></td>
                                <td bgcolor="#00436b"><strong>Visited</strong></td>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
    </body>
</html>
