<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditSignupSlabs
    Created on : 29 Dec, 2015, 10:23:59 AM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Sign up Slabs</title>
        <script src="js/BaseJava.js"></script>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script>
            function Insert(tableID) {
                try {
                    var table = document.getElementById(tableID);
                    console.log("table "+table);
                    var rowCount = table.rows.length;
                    var sum = 0;
                    var grand = 0;
                    var grandamt = 0;
                    for (var i = 1; i < rowCount; i++) {
                        var row = table.rows[i];
                        var percent = row.cells[1].childNodes[1];
                        var rate = row.cells[2].childNodes[1];
                        var finaltotal = document.getElementById('grandtotal');
                        console.log("finaltotal "+finaltotal);
//                        var finaltotalamt = document.getElementById('grandtotalamt');
//                        console.log("finaltotalamt "+finaltotalamt);
                        var total = document.getElementById("total");
                        console.log("total "+total);
                        sum = Number(total.value) * Number(percent.value) / 100;
                        rate.value = sum;

                        grand = Number(grand) + Number(percent.value);
                        finaltotal.value = grand;

//                        grandamt = Number(grandamt) + Number(rate.value);
//                        finaltotalamt.value = grandamt;

                    }
                } catch (e) {
                    alert(e+" error from insert");
                }
            }

            function InsertRate(tableID) {
                try {
                    var table = document.getElementById(tableID);
                    var rowCount = table.rows.length;
                    var sum = 0;
                    var grand = 0;
                    for (var i = 1; i < rowCount; i++) {
                        var row = table.rows[i];
                        var percent = row.cells[1].childNodes[1];
                        var rate = row.cells[2].childNodes[1];
                        var finaltotal = document.getElementById('grandtotal');
                        var total = document.getElementById("total");
                        sum = Number(rate.value) / Number(total.value) * 100;
                        percent.value = sum;

                        grand = Number(grand) + Number(percent.value);
                        finaltotal.value = grand;

                    }
                } catch (e) {
                    alert(e+" eror from insertrate");
                }
            }

            function check() {
                if (document.getElementById('grandtotal').value !== "100")
                {
                    alert("Please Make A Total Of 100%");
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <a href="viewsignupGridLink" class="newbtn2 create_link">Back</a>
        <strong class="heading">Update Sign UP's Slab</strong>
        <hr class=" hr"/>
        <br/>
        <form action="updateSignupslabs" method="POST">
            <table border="0" id="dataTable1234">
                <thead>
                    <tr>
                        <th>Slabs</th>
                        <th>Percents</th>
                        <th>Rate</th>
                        <th>Balance</th>
                        <th>Paid</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ob" items="${signupslabsdt}">
                        <tr>
                            <td>
                                <input type="text" name="txtslabname" value="${ob.slabname}"  readonly="" style="width: 170px"  />
                            </td>
                            <td>  
                                &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txtslabpercent" value="${ob.slabpercent}" onkeypress="return isNumberKey(event)" style="width: 50px" onkeyup="Insert('dataTable1234')" autofocus="" onfocus="Insert('dataTable1234')" maxlength="3"/> % &nbsp;
                            </td>
                            <td> 
                                <input type="text" name="txtslabrate" value="${ob.slabrate}"  style="width: 170px" onkeyup="InsertRate('dataTable1234')" onkeypress="return isNumberKey(event)"/> 
                                <input type="hidden" name="txtslabid" value="${ob.slabid}" /> &nbsp; &nbsp;
                            </td> 
                            <td> 
                                <input type="text" name="" value="${ob.slabbalance}" readonly="readonly" disabled="disabled"/> &nbsp;
                            </td>
                            <td>
                                <input type="text" name="" value="${ob.slabtotal}" readonly="readonly" disabled="disabled"/> 
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div style="float: right">
                <input type="text" name="" value="${totalrate}" readonly="readonly" disabled="disabled" style="width: 170px"/>&nbsp; &nbsp;
                <input type="text" name="" value="${totalbalance}" readonly="readonly" disabled="disabled" style="width: 170px"/>&nbsp; &nbsp;
                <input type="text" name="" value="${totalpaid}" readonly="readonly" disabled="disabled" style="width: 170px"/>
            </div>
            <br/>


            TOTAL(%) : <INPUT type="text" readonly="true" id="grandtotal" style="width: 50px" >
            <input type="submit" value="submit" class="newbtn" onclick="return check();"/>
            <input type="hidden" name="txttotal" value="${requesttotal}" id="total"/>
        </form>
    </body>
</html>
