<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewNewSignupProjectGrid
    Created on : 12 Jan, 2016, 1:35:32 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign up</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <style>
            #lorem {
                /*background-color: lightgrey;*/
                width: 250px;
                padding: 20px;
                border: 1px solid #ccc;
                margin: 25px;
                display: inline-block
            }
            #menuheading {
                /*background-color: lightgrey;*/
                font-size: 18px;
                font-family: arial;
            }
            #menucontent {
                /*background-color: lightgrey;*/
                font-size: 16px;
                color: grey;
                font-family: arial;
                line-height: 30px
            }
        </style>
    </head>
    <body>                
        <a href="viewnewsignupExecutiveGridLink" class="create_link" style="float: right"><img src="images/sales1.png"/></a>
        <strong class="heading"><img src="image/contact2.png" align="absmiddle" /> SIGN UPS / BOOKINGS</strong>
        <hr class=" hr"/>
        <c:forEach var="ob" items="${projectdt}">
            <a href="viewprojectsignupdetails?id=${ob.projectid}">
                <div id="lorem">
                    <span id="menuheading">
                        ${ob.projectname}
                    </span>

                    <hr>
                    <span id="menucontent">
                        Total Bookings : 
                        <c:choose>
                            <c:when test="${empty ob.totalbooking}">
                                N/A
                            </c:when>
                            <c:otherwise>
                                ${ob.totalbooking}
                            </c:otherwise>
                        </c:choose>
                        <br>
                        Allotment Printed : 50
                        <br>
                        Allotment Pending : 50
                        <br>
                        Payment O/S : 
                        <c:choose>
                            <c:when test="${empty ob.totalamount}">
                                N/A
                            </c:when>
                            <c:otherwise>
                                ${ob.totalamount - ob.totalreceipt}
                            </c:otherwise>
                        </c:choose> 
                        <br>
                        Canceled : 50
                        <br>
                    </span>
                </div>
            </a>
        </c:forEach>

    </body>
</html>
