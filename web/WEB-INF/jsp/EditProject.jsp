<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditProject
    Created on : 9 Dec, 2015, 4:44:14 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Project</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script> 
        <script src="js/BaseJava.js"></script>
        <script>
            function addRow(tableID) {
                var table = document.getElementById(tableID);
                var rowCount = table.rows.length;
                console.log(rowCount + " Row count");
                var row = table.insertRow(rowCount);
                console.log(row + " Row ");

                var colCount = table.rows[0].cells.length;
                console.log(colCount + " colCount ");

                for (var i = 0; i < colCount; i++) {
                    console.log(table.rows[1] + " table i ");

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

            function updaterec(res, id)
            {
                if (res === true)
                {
                    serial = $("#UPDATEREC").click('serialize');
                    $.ajax({
                        url: "deleterequirement",
                        data: {
                            id: id},
                        cache: false,
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
                if (result === true)
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
    <center>
        <form action="updateproject" method="post">
            <input type="hidden" name="projectid" value="${param.id}" />
            <input type="hidden" name="area" value="${projectdt[0].area}" />
            <table width="341" height="252" border="0">
                <tbody>
                    <tr>
                        <td>Name</td>
                        <td>
                            <input type="text" name="name" value="${projectdt[0].name}" class="input001" required="" onkeypress="javascript:return isTe
                                    xtKey(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Location</td>
                        <td>
                            <input type="text" name="location" value="${projectdt[0].location}" class="input001" required="" onkeypress="javascript:return isTe
                                    xtKey(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Address</td>
                        <td>
                            <textarea name="address" rows="4" cols="20" required="">${projectdt[0].address}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Builder Name</td>
                        <td>
                            <input type="text" readonly="" name="txtEditProjectBuilderName" value="${projectdt[0].buildernamej}" class="input001" required="" onkeypress="javascript:return isTe
                                    xtKey(event);"/>
                            <!--<input type="hidden" name="" value="" />-->
                        </td>
                    </tr>
                    <tr>
                        <td>JE Percents(%)</td>
                        <td><input type="text" name="jepercent" value="${projectdt[0].jepercent}" class="input001"  placeholder="Enter JE %" required="" onkeypress="javascript:return isNumb
                                erKey(event);"/></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <img src="img/1396621656_Plus.png" width="20" height="20" alt="1396621656_Plus" onclick="addRow('dataTable')" style="float: left;"/><br/>
                            <table border="0" align="center" id="dataTable">
                                <thead>
                                    <tr >
                                        <TD align="left">Requirement</TD>
                                        <TD align="left">Sqr.Feets</TD>
                                        <TD align="left">Carpet</TD>
                                        <TD align="left">Actions</TD>
                                    </tr>
                                </thead>
                                <tr style="display: none">
                                    <td  align="left" >
                                        <select name="drprequirementADD" class="select">
                                            <c:forEach var="ob" items="${requirementdt}">
                                                <option value="${ob.name}">${ob.name}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td align="left"><input type="text" value="" class="input001" name="txtProjectSqrFeetADD" placeholder="Enter Square Feets"></td>
                                    <td align="left"><input type="text" value="" class="input001" name="txtcarpetSqrFeetADD" placeholder="Enter Square Feets"></td>
                                    <td> &nbsp;&nbsp;&nbsp;<span class="delete1"><img src="img/1396621437_Delete.png" alt="Delete" height="20" width="20"></span></td>
                                </tr>
                                <c:forEach var="op" items="${projectdt}">
                                    <tr>
                                        <td  align="left">
                                            <select name="drprequirement"  required="" class="select">
                                                <c:forEach var="ko" items="${requirementdt}">
                                                    <c:choose>
                                                        <c:when test="${ko.name==op.reqJ}">
                                                            <option value="${ko.name}" selected="">${ko.name}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${ko.name}">${ko.name}</option>
                                                        </c:otherwise>
                                                    </c:choose>                                                    
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td align="left">
                                            <input type="text" value="${op.sqrj}" class="input001" name="txtProjectSqrFeet" required="">
                                        </td>
                                        <td align="left">
                                            <input type="text" value="${op.carpet}" class="input001" name="txtCarpetSqrFeet" required="">
                                        </td>
                                        <td >
                                            &nbsp;&nbsp;&nbsp;<span class="delete1" onclick="setid('${op.reqidj}')"><img src="img/1396621437_Delete.png" alt="Delete" height="20" width="20" ></span> 
                                            <input type="hidden" name="txtreqid" value="${op.reqidj}"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <input type="submit" value="Update" class="newbtn3"/>
                            <input type="hidden" name="txtEditProjectId" value="${param.id}" />
                            <input type="hidden" name="" value="" id="setid"/>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </center>
</body>
</html>
