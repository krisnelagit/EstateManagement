<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddProject
    Created on : 9 Dec, 2015, 1:35:42 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add project</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script> 
        <style>
            .input001{width: 200px; height: 30px;}
            input{width: 90px;}
            .input002{width: 50px; height: 30px}
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
                    //alert(newcell.childNodes);


                    //  rowCount++;
                }
                //   rowid.value=rowCount;
            }


            $(document).on('click', 'span.delete', function () {
                var table = document.getElementById('dataTable');
                var rowCount = table.rows.length;
                if (rowCount <= 2) {
                    alert("Cannot delete all the rows.");   // break;
                }
                else
                {
                    $(this).closest('tr').find('td').fadeOut(600,
                            function () {
                                //                        $(this).parents('tr:first').remove();
                                $(this).parents('tr:first').remove();
                            });
                    //                     Insert('dataTable');

                }
                return false;
            });


            //Allow numbers only 
            function isNumberKey(evt)
            {

                var charCode = (evt.which) ? evt.which : event.keyCode;

                if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode !== 8)
                    return false;
                return true;

            }
        </script>
    </head>
    <body>
    <center>
        <form action="insertProject" method="POST">
            <table border="0" cellpadding="5" cellspacing="5" class="box04">
                <tbody>
                    <tr>
                        <td align="left">Project Name</td>
                        <td align="left">
                            <input type="text" name="name" value="" class="input001" required="" title="enter your project name" placeholder="Enter Your Project Name"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">Location</td>
                        <td align="left">
                            <input type="text" name="Location" value="" class="input001" required="" title="enter your location" placeholder="Enter Your Location"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">Address</td>
                        <td align="left">
                            <textarea name="Address" rows="4" cols="20" class="input001 select" required="" placeholder="Enter Your Address"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">Builder Name</td>
                        <td align="left">
                            <select name="buildername" class="input001" required="">
                                <c:forEach var="ob" items="${buildersdt}">
                                    <option value="${ob.id}">${ob.name}</option>                            
                                </c:forEach>
                            </select>                        
                        </td>
                    </tr>
                    <tr>
                        <td align="left">JE Percent</td>
                        <td align="left">
                            <input type="text" value="" class="input001" name="jepercent" placeholder="Enter JE %" required="" onkeypress="javascript:return isNumberKey(event);">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">No.of Wings</td>
                        <td align="left"><input type="text" value="" class="input001" name="wings" placeholder="No.of Wings" required="" onkeypress="javascript:return isNumberKey(event);"></td>
                    </tr>
                    <tr>
                        <td align="left">No.of Floors</td>
                        <td align="left"><input type="text" value="" class="input001" name="floors" placeholder="No.of Floors" required="" onkeypress="javascript:return isNumberKey(event);"></td>
                    </tr>
                    <tr>
                        <td align="left">Flats Per Floor</td>
                        <td align="left"><input type="text" value="" class="input001" name="flats" placeholder="Enter Flats" required="" onkeypress="javascript:return isNumberKey(event);"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <img src="img/1396621656_Plus.png" width="20" height="20" alt="1396621656_Plus" onclick="addRow('dataTable')" style="float: left;"/><br/>
                            <table border="0" align="center" id="dataTable">
                                <thead>
                                    <tr >
                                        <TD align="left">Requirement</TD>
                                        <TD align="left">Sqr.Feets</TD>
                                        <TD align="left">Carpet area</TD>
                                        <TD align="left">Actions</TD>
                                    </tr>
                                </thead>
                                <tr>
                                    <td  align="left">
                                        <select name="drprequirement"  required="">
                                            <c:forEach var="ob" items="${requirementdt}">
                                                <option value="${ob.name}">${ob.name}</option>
                                            </c:forEach>                                        
                                        </select>
                                    </td>
                                    <td align="left">
                                        <input type="text" value="" class="input001" name="txtProjectSqrFeet" placeholder="Enter Square Feets" required="" onkeypress="javascript:return isNumberKey(event);">
                                    </td>
                                    <td align="left">
                                        <input type="text" value="" class="input001" name="txtcarpetSqrFeet" placeholder="Enter Square Feets" required="" onkeypress="javascript:return isNumberKey(event);">
                                    </td>
                                    <td>
                                        <span class="delete" ><img src="img/1396621437_Delete.png" alt="Delete" height="20" width="20" ></span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">Area</td>
                        <td align="left">
                            <select name="drparea" required="">
                                <c:forEach var="oa" items="${areadt}">
                                    <option value="${oa.areaid}">${oa.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="left"></td>
                        <td align="left">
                            <input type="submit" value="Add" class="newbtn"/> <input type="reset" value="Clear All" class="newbtn"/> <a href="viewprojectgrid" class="newbtn">Cancel</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </center>
</body>
</html>
