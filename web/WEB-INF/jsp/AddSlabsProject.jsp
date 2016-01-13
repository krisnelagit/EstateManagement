<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddSlabsProject
    Created on : 10 Dec, 2015, 12:49:07 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Slabs Project</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script src="js/BaseJava.js"></script>
        <style>
            .CSSTableGenerator {
                margin:0px;padding:0px;
                width:100%;
                border:1px solid #e8e8e8;

                -moz-border-radius-bottomleft:0px;
                -webkit-border-bottom-left-radius:0px;
                border-bottom-left-radius:0px;

                -moz-border-radius-bottomright:0px;
                -webkit-border-bottom-right-radius:0px;
                border-bottom-right-radius:0px;

                -moz-border-radius-topright:0px;
                -webkit-border-top-right-radius:0px;
                border-top-right-radius:0px;

                -moz-border-radius-topleft:0px;
                -webkit-border-top-left-radius:0px;
                border-top-left-radius:0px;
            }.CSSTableGenerator table{
                border-collapse: collapse;
                border-spacing: 0;
                width:100%;
                height:100%;
                margin:0px;padding:0px;
            }.CSSTableGenerator tr:last-child td:last-child {
                -moz-border-radius-bottomright:0px;
                -webkit-border-bottom-right-radius:0px;
                border-bottom-right-radius:0px;
            }
            .CSSTableGenerator table tr:first-child td:first-child {
                -moz-border-radius-topleft:0px;
                -webkit-border-top-left-radius:0px;
                border-top-left-radius:0px;
            }
            .CSSTableGenerator table tr:first-child td:last-child {
                -moz-border-radius-topright:0px;
                -webkit-border-top-right-radius:0px;
                border-top-right-radius:0px;
            }.CSSTableGenerator tr:last-child td:first-child{
                -moz-border-radius-bottomleft:0px;
                -webkit-border-bottom-left-radius:0px;
                border-bottom-left-radius:0px;
            }.CSSTableGenerator tr:hover td{

            }
            .CSSTableGenerator tr:nth-child(odd){ background-color:#f4f4f4; }
            .CSSTableGenerator tr:nth-child(even)    { background-color:#ffffff; }.CSSTableGenerator td{
                vertical-align:middle;


                border:1px solid #e8e8e8;
                border-width:0px 1px 1px 0px;
                text-align:left;
                padding:7px;
                font-size:10px;
                font-family:Arial;
                font-weight:normal;
                color:#000000;
            }.CSSTableGenerator tr:last-child td{
                border-width:0px 1px 0px 0px;
            }.CSSTableGenerator tr td:last-child{
                border-width:0px 0px 1px 0px;
            }.CSSTableGenerator tr:last-child td:last-child{
                border-width:0px 0px 0px 0px;
            }
            .CSSTableGenerator tr:first-child td{
                background:-o-linear-gradient(bottom, #f4f4f4 5%, #f4f4f4 100%);	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #f4f4f4), color-stop(1, #f4f4f4) );
                background:-moz-linear-gradient( center top, #f4f4f4 5%, #f4f4f4 100% );
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#f4f4f4", endColorstr="#f4f4f4");	background: -o-linear-gradient(top,#f4f4f4,f4f4f4);

                background-color:#f4f4f4;
                border:0px solid #e8e8e8;

                border-width:0px 0px 1px 1px;
                font-size:14px;
                font-family:Arial;
                font-weight:bold;
                color:#333333;
            }
            .CSSTableGenerator tr:first-child:hover td{
                background:-o-linear-gradient(bottom, #f4f4f4 5%, #f4f4f4 100%);	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #f4f4f4), color-stop(1, #f4f4f4) );
                background:-moz-linear-gradient( center top, #f4f4f4 5%, #f4f4f4 100% );
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#f4f4f4", endColorstr="#f4f4f4");	background: -o-linear-gradient(top,#f4f4f4,f4f4f4);

                background-color:#f4f4f4;
            }
            .CSSTableGenerator tr:first-child td:first-child{
                border-width:0px 0px 1px 0px;
            }
            .CSSTableGenerator tr:first-child td:last-child{
                border-width:0px 0px 1px 1px;
            }
        </style>

        <script>

            function addRow(tableID) {
                var table = document.getElementById(tableID);
                var rowCount = table.rows.length;
                var row = table.insertRow(rowCount);

                var colCount = table.rows[0].cells.length;

                for (var i = 0; i < colCount; i++) {

                    var newcell = row.insertCell(i);

                    newcell.innerHTML = table.rows[1].cells[i].innerHTML;
//                newcell.innerHTML = "";

                }
            }
            function setid(id)
            {
                var sethere = document.getElementById("setid");
                sethere.value = id;


            }

            function check()
            {
                if (document.getElementById('grandtotal').value != "100")
                {
                    alert("Please Make A Total Of 100%");
                    return false;
                }
                return true;
            }

            function calculate()
            {
                console.log("hey oim calculate");
                var table = document.getElementById('dataTable');
                var rowCount = table.rows.length;
                console.log("hey oim rowCount " + rowCount);
//            alert(rowCount)
//                mod code begin here
                var fin = "0";
                $('.slabper').each(function(){
                    fin= Number(fin)+Number(this.value);
                });
                $("#grandtotal").val(fin);
                

//                var sum = 0;
//
//                for (var i = 1; i < rowCount; i++) {
//                    var row = table.rows[i];
//                    var percents = row.cells[1].childNodes[0];
//                    console.log("hey oim percents" + percents.value);
//
//                    var finaltotal = document.getElementById('grandtotal');
//                    sum = Number(sum) + Number(percents.value);
//                    console.log("hey oim sum" + sum);
//                    finaltotal.value = sum;
//                }
            }

            function updaterec(res, id)
            {
//          var result=confirm("Are you sure to delete?");
                if (res === true)
                {
                    serial = $("#UPDATEREC").click('serialize');
                    $.ajax({
                        url: "deleteslabdetails",
                        type: "post",
                        data: {
                            id: id, 
                            deskname: "slab_master_details"
                        },
                        success: function (data) {    
                        },
                        error: function () {
                            alert("theres an error with AJAX");
                        }
                    });
                }
            }

            $(document).on('click', 'span.delete1', function () {
                var result = confirm("Are you sure to delete?");
                if (result == true)
                {
                    var table = document.getElementById('dataTable');
                    var rowCount = table.rows.length;
                    if (rowCount <= 2) {
                        alert("Cannot delete all the rows.");   // break;
                    }
                    else
                    {
                        $(this).closest('tr').find('td').fadeOut(600,
                                function () {
                                    calculate();
                                    $(this).parents('tr:first').remove();

                                });
                        updaterec(true, document.getElementById("setid").value);
                    }
                    return false;

                }
                else
                {
                    updaterec(false, 0);
                }
            });
        </script>
    </head>
    <body>
        <form action="insertslabprojectrequirement" method="post">              
            <input type="hidden" value="${param.slab_master_id}" name="slab_master_id">
            <div class="CSSTableGenerator">
                <img src="img/1396621656_Plus.png" width="20" height="20" alt="1396621656_Plus" onclick="addRow('dataTable')" style="float: left;"/><br/>
                <table border="0" align="center" id="dataTable">
                    <thead>
                        <tr >
                            <TD align="left">Slabs</TD>
                            <TD align="left">Slab Percent</TD>
                            <TD align="left">Actions</TD>
                        </tr>
                    </thead>
                    <tr style="display: none">
                        <td align="left">
                            <input type="text" value="" class="input001" name="txtProjectSlabADD" placeholder="Enter Slab">
                        </td>
                        <td align="left">
                            <input type="text" value="" class="input001 slabper" name="txtProjectSlabpercentADD" placeholder="Enter Slab Percent" onkeyup='calculate()' onclick='calculate()' id="slabpercent" autofocus="">
                        </td>
                        <td>
                            <span class="delete1"><img src="img/1396621437_Delete.png" alt="Delete" height="20" width="20"></span>
                        </td>
                    </tr>
                    <c:forEach var="ob" items="${slabdt}">
                        <c:if test="${not empty ob.slab_name}">
                            <tr>
                                <td  align="left">
                                    <input type="text" value="${ob.slab_name}" class="input001" name="txtProjectSlab" placeholder="Enter Slab" required="">   
                                </td>
                                <td align="left">
                                    <input type="text" value="${ob.slab_percent}" class="input001 slabper" name="txtProjectSlabPercent" placeholder="Enter Slab Percent" required="" onkeyup='calculate()' onfocus='calculate()' onclick='calculate()' onkeypress="javascript:return isDecimal(event);" id="slabpercent" autofocus="">
                                </td>
                                <td > 
                                    &nbsp;&nbsp;&nbsp;<span class="delete1" onclick="setid('${ob.id}')"><img src="img/1396621437_Delete.png" alt="Delete" height="20" width="20" ></span> <input type="hidden" name="txtreqid" value="${ob.id}"/>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
                <input type="submit" value="Submit" class="newbtn3" onclick="return check();"/>
                <div style="float: right;right: 443px;position: relative"><input type="text" name="" value="" readonly="" id="grandtotal"/>Total</div>
                <input type="hidden" name="project_id" value="${param.projectid}" />
                <input type="hidden" name="" value="" id="setid"/>
            </div>
        </form>
    </body>
</html>
