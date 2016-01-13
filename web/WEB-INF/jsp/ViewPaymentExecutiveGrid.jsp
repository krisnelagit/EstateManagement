<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewPaymentExecutiveGrid
    Created on : 11 Jan, 2016, 5:53:48 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Payments</title>
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
        <a href="viewPaymentsGridLink" class="create_link" style="float: right"><img src="images/school50.png"/></a>
        <strong class="heading"><img src="image/contact2.png" align="absmiddle" /> Payment's</strong>
        <hr class=" hr"/>
        <c:forEach var="ob" items="${projectdt}">
            <a href="viewexecutivesignupdetails?id=${ob.projectid}">
                <div id="lorem">
                    <span id="menuheading">
                        ${ob.projectname}
                    </span>

                    <hr>
                    <span id="menucontent">
                        Total Sales : 
                        <c:choose>
                            <c:when test="${empty ob.totalsales}">
                                N/A
                            </c:when>
                            <c:otherwise>
                                ${ob.totalsales}
                            </c:otherwise>
                        </c:choose>
                        <br>
                        Total Receipts : 
                        <c:choose>
                            <c:when test="${empty ob.totalreceipt}">
                                N/A
                            </c:when>
                            <c:otherwise>
                                ${ob.totalreceipt}
                            </c:otherwise>
                        </c:choose>
                        <br>
                        total O/S : 
                        <c:choose>
                            <c:when test="${empty ob.totalsales}">
                                N/A
                            </c:when>
                            <c:otherwise>
                                ${ob.totalsales - ob.totalreceipt}
                            </c:otherwise>
                        </c:choose> <br>
                        Dishonored :
                        <c:choose>
                            <c:when test="${empty ob.totaldishonoured}">
                                N/A
                            </c:when>
                            <c:otherwise>
                                ${ob.totaldishonoured}
                            </c:otherwise>
                        </c:choose> <br>
                        Due For Deposit : ${ob.pendingdeposit}<br>
                    </span>
                </div>
            </a>
        </c:forEach>
    </body>
</html>
