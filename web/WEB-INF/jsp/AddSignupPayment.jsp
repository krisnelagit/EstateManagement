<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddSignupPayment
    Created on : 29 Dec, 2015, 12:48:39 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Sign up Payment</title>
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css"/>
        <link href="css/modal_1.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                var bankdetails = $('#dropdownlist');
                $('.bankdetails').hide();
                $('.onlinepayment').hide();

                //on bank details change begins here                
                bankdetails.change(function (e) {
                    if (bankdetails.val() === 'Cheque') {
                        $('.bankdetails').show();
                        $('.onlinepayment').hide();
                    }
                    else if (bankdetails.val() === 'Online Payment') {
                        $('.bankdetails').hide();
                        $('.onlinepayment').show()();
                    }
                    else
                    {
                        $('.bankdetails').hide();
                        $('.onlinepayment').hide();
                    }
                });
                //on bank details change ends! here

                //on pay keyup begins here
                $('#pay').keyup(function () {
                    //mod to jquery equivalent
                    var bal = $("#bal").val();
                    var total = $("#total").val();
                    var storebal = $("#bal1").val();
                    console.log("storebal " + storebal);
                    var pay = $("#pay").val();
                    console.log("pay " + pay);
                    if (Number(bal) <= 0 || Number(pay) > Number(storebal)) {
                        $("#pay").val(0);
                        $("#bal").val(storebal);
                    }
                    var updatebal = Number(storebal) - Number(pay);
                    console.log("updatebal " + updatebal);
                    $("#bal").val(updatebal);
                });
                //on pay keyup ends! here

                //chk change pe begins! here
                $('.chk').change(function () {
                    $(this).closest('tr').find('.print').val($(this).is(':checked'));
                });
                //chk change pe ends! here

                //on popup close begin here
                $('#close_popup').click(function () {
                    document.getElementById('modal_popup1').style.visibility = 'hidden';
                });
                //on popup close ends! here


                $('#table_id123').DataTable();
                $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});


            });
        </script>
        <script>
            function checked(a) {
                alert('entered');
                var prdnameid = $(a).closest('tr').find('.print').val();
                alert(prdnameid);
            }

            function Modal_Popup(callerid, btnName, btnColor) {
                var usrid = getParameterByName('Callerid');
                document.getElementById('modal_popup1').style.opacity = '1';
                document.getElementById('modal_popup1').style.top = '60%';
                document.getElementById('modal_popup1').style.visibility = 'visible';
                $('#hiddendiv').empty();
                $('#hiddendiv').append("<input type='hidden' name='callerid' value='" + callerid + "'>");
                $('#hiddendiv').append("<input type='hidden' name='btnName' value='" + btnName + "'>");
                $('#hiddendiv').append("<input type='hidden' name='btnColor' value='" + btnColor + "'>");
                $('#hiddendiv').append("<input type='hidden' name='usrid' value='" + usrid + "'>");
            }

            function getParameterByName(name) {
                name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
                var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                        results = regex.exec(location.search);
                return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
            }
        </script>
    </head>
    <body>
        <a href="viewsignupGridLink" class="newbtn2 create_link">Back</a>
        <strong class="heading">Add Payment</strong>
        <hr>
        <br/>
        <form action="insertSignupPayment" method="POST">
            <input type="hidden" name="page" value="${param.signup}" />
            <table border="0" class="table" align="center">
                <tbody>
                    <tr>
                        <td>Name</td>
                        <td> <input type="text" name="payname" value="${paymentdt.name}" readonly="readonly" class="input"/> </td>
                    </tr>
                    <tr>
                        <td>Date</td>
                        <td> <input type="text" name="paymentdate" value="" class="input datepicker"/> </td>
                    </tr>
                    <tr>
                        <td>Balance</td>
                        <td>
                            <input type="text" name="paybalance" value="${paymentdt.balance}" readonly="readonly" class="input" id="bal"/>
                            <input type="hidden" name="paybalance" value="${paymentdt.balance}" readonly="readonly" class="input" id="bal1"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Total</td>
                        <td> <input type="text" name="paytotal" value="${paymentdt.total}" readonly="readonly" class="input" id="total"/> </td>
                    </tr>
                    <tr>
                        <td>Pay</td>
                        <td><input type="number" name="paidamount" value="" class="input" required=""  id="pay"/></td>
                    </tr>
                    <tr>
                        <td>Payment Mode</td>
                        <td>
                            <select name="paymentmode" class="select" id="dropdownlist" required="">
                                <option value="">--select mode--</option>
                                <option>Cheque</option>
                                <option>Cash</option>
                                <option>Online Payment</option>
                            </select>
                        </td>
                    </tr>
                    <tr class="bankdetails">
                        <td>Cheque No.</td>
                        <td> <input type="text" name="paychequeno" value="" class="input" /> </td>
                    </tr>
                    <tr class="bankdetails">
                        <td>Bank Name</td>
                        <td> <input type="text" name="paybankname" value="" class="input" /> </td>
                    </tr>
                    <tr class="onlinepayment">
                        <td>Transaction Details</td>
                        <td> <textarea name="onlinepay" rows="4" cols="20"></textarea> </td>
                    </tr>
                    <tr>
                        <td>Select Slab</td>
                        <td>
                            <select name="slabname" class="select" required="">
                                <option selected="" value="">--select--</option>
                                <c:forEach var="ob" items="${selectslabdt}">
                                    <option value="${ob.slabname},${ob.rate},${ob.id}">${ob.slabname}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td> <input type="hidden" name="userid" value="${param.Callerid}" /> </td>
                        <td><input type="submit" value="Pay" class="newbtn" name="btn"/></td>
                    </tr>
                </tbody>
            </table>
        </form>
        <br/>
        <form action="printSignupPayment" method="POST">
            <input type="image" src="images/printer.png" value="print" style=""/>
            <input type="hidden" name="signupid" value="${param.Callerid}" />
            <table class="display tablestyle" id="table_id123">
                <thead>
                    <tr>
                        <th align="left">Select</th>
                        <th align="left">Date</th>
                        <th align="left">Mode</th>
                        <th align="left">Cheque No.</th>
                        <th align="left">Bank Name</th>
                        <th align="left">Online</th>
                        <th align="left">For Slab</th>
                        <th align="left">Paid</th>
                        <th align="left">Received</th>
                        <th align="left">Cleared</th>
                        <th align="left">Due for deposit</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ob" items="${signuppaymetdt}">
                        <tr>
                            <td> <input type="checkbox" name="chk" value="ON"  class="chk"/> </td>
                            <td>
                                ${ob.paymentdate}
                                <input type="hidden" name="printdate" value="${ob.paymentdate}" />
                            </td>
                            <td>
                                ${ob.paymentmode}
                            </td>
                            <td>
                                ${ob.chequeno}
                                <input type="hidden" name="printcheque" value="${ob.chequeno}" />
                            </td>
                            <td>
                                ${ob.bankname}
                                <input type="hidden" name="printbank" value="${ob.bankname}" />
                            </td>
                            <td>
                                ${ob.onlinepay}
                            </td>
                            <td>
                                ${ob.slab}
                            </td>
                            <td>
                                ${ob.paidamount}
                                <input type="hidden" name="printamt" value="${ob.paidamount}" />
                                <input type="hidden" name="print" value="false" class="print"/>
                            </td>
                            <c:choose>
                                <c:when test="${ob.paymentmode=='Cheque'}">
                                    <td>
                                        <c:choose>
                                            <c:when test="${ob.received=='No'}">
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Received', 'Yes')" style="background-color: red;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:when>
                                            <c:otherwise>
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Received', 'No')" style="background-color: green;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ob.cleared=='No'}">
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Cleared', 'Yes')" style="background-color: red;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:when>
                                            <c:otherwise>
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Cleared', 'No')" style="background-color: green;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ob.deposit=='No'}">
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Deposit', 'Yes')" style="background-color: red;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:when>
                                            <c:otherwise>
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Deposit', 'No')" style="background-color: green;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ob.received=='No'}">
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Received', 'Yes')" style="background-color: red;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:when>
                                            <c:otherwise>
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Received', 'No')" style="background-color: green;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ob.cleared=='No'}">
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Cleared', 'Yes')" style="background-color: red;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:when>
                                            <c:otherwise>
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Cleared', 'No')" style="background-color: green;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ob.deposit=='No'}">
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Deposit', 'Yes')" style="background-color: red;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:when>
                                            <c:otherwise>
                                                <div onclick="Modal_Popup('${ob.paymentdetailsid}', 'Deposit', 'No')" style="background-color: green;width: 20px;height: 20px;border-radius: 50px;margin: auto"></div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </form>

        <!--code for some modal popup begins here-->
        <div id="modal_popup1">
            <div class="modal-content">
                <div>
                    <img src="image/close.png" width="20" height="20" class="close_img" id="close_popup"></img>
                </div>
                <form action="updaterecievedandcleared" method="POST" class="quick_contact_form_popup">
                    <span><strong>Password Authentication</strong></span>
                    <br/><br/>
                    <label>
                        <div id="hiddendiv"></div>
                        <table border="0" style="padding-top: 3px;">
                            <tbody>
                                <tr>
                                    <td>Password :</td>  <td><input type="password"  name="passwd" /></td>
                                </tr>
                            </tbody>
                        </table>
                    </label>
                    <label>
                        <input type="submit" class="submit" value="Save" style="position:relative; left:140px;" />
                    </label>
                </form>
            </div>
            <div class="overlay"></div>
        </div>
        <!--code for some modal popup ends! here-->
    </body>
</html>
