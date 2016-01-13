<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewSignUpGrid
    Created on : 15 Dec, 2015, 5:50:30 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign up PAYMENT</title>
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
                
                //code for password incorrect here
                if ('${sessionScope.passnot}' === 'passnot') {
                    alert('Incorrect Password');
                    <c:remove var="passnot"></c:remove>
                }

            });
        </script>
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
                        url: "deletesignupmasterrecord",
                        data: {id: id, deskname: "signupmaster"
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
        <a href="addsignupLink" class="newbtn2 create_link">Add</a>
        <strong class="heading"><img src="image/contact2.png" align="absmiddle" /> Sign UP's</strong>
        <hr class=" hr"/>
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <th align="left">Date</th>
                    <th align="left">Name</th>
                    <th align="left">Mobile</th>
                    <th align="left">Project</th>
                    <th align="left">Requirement</th>
                    <th align="left">Balance / Total</th>
                    <th align="left">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ob" items="${signupdt}">
                    <tr>
                        <td>${ob.date}</td>
                        <td title="Address : ${ob.address} / Email : ${ob.email}"><a href="viewSignupDetailLink?signupid=${ob.signupid}">${ob.name}</a></td>
                        <td>${ob.mobile}</td>
                        <td>${ob.projn}</td>
                        <td title="Sqft : ${ob.sqrfeet}/ Rate : ${ob.rate}">${ob.requirement}</td>
                        <td>${ob.balance} / ${ob.total}</td>
                        <td>
                            <a title="Slab Details" href="editsignupslabs?signupid=${ob.signupid}&total=${ob.total}" class="email_link"><img src="images/slab.png" alt="" class="edit"/></a> &nbsp;&nbsp;
                            <a onclick="confirmdelete('${ob.signupid}', this);" class="edit_link" title="Delete" ><img src="images/delete_1.png" class="delete"/></a> 
                            <a title="Edit"  href="editSignuplink?signupid=${ob.signupid}"><img src="images/edit_1.png" class="edit"/></a>&nbsp;&nbsp;
                            <a title="Payment" href="addSignupPayment?Callerid=${ob.signupid}&signup=yes" class="email_link"><img src="images/signuppayment.png" alt="" class="edit"/></a>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
