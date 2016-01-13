<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : Setting
    Created on : 30 Oct, 2014, 5:27:59 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Menu</title>
        <script src="js/jquery-1.10.2.min.js"></script>
<!--        <style type="text/css">
            a:link {
                text-decoration: none;
            }
            a:visited {
                text-decoration: none;
            }
            a:hover {
                text-decoration: none;
            }
            a:active {
                text-decoration: none;
            }
        </style>-->
        <!--<link href="css/main2.css" rel="stylesheet" type="text/css" />-->


    </head>

    <body>


            <c:choose>
                <c:when test="${sessionScope.USERTYPE.equals('Admin')}">


                    <a href="viewareagrid">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/area.png" width="23" height="21" align="absmiddle" /> Area</div>

                        </div>
                    </a>

                    <a href="viewBuilderGridLink">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/builder.png" align="absmiddle" /> Builder</div>

                        </div>
                    </a>

                    <a href="viewBrokerGridLink">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/broker.png" align="absmiddle" /> Broker</div>

                        </div>
                    </a>

                    <a href="viewleadsourcegrid">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/source.png" align="absmiddle" /> Lead Source</div>

                        </div>
                    </a>

                    <a href="viewprojectgrid">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/projects.png" align="absmiddle" /> Projects</div>

                        </div>
                    </a>

                    <a href="viewrequirementgrid">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/requirement.png" align="absmiddle" /> Requirement</div>

                        </div>
                    </a>

                    <a href="viewusersgrid">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Create User</div>

                        </div>
                    </a>

                    <a href="incentivepaymentGridLink">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Incentives Payment</div>

                        </div>
                    </a>
                    <a href="brokeragepaymentgridlink">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Brokerage Payment</div>

                        </div>
                    </a>
                    <a href="viewbuilderpaymentgridlink">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Builder Payment</div>

                        </div>
                    </a>
                    <a href="viewSignupPaymentgridLink">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Sign Up Payment</div>

                        </div>
                    </a>


                    <a href="viewVerifyLeadOwnergridLink">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Verify Lead Owner</div>

                        </div>
                    </a>

                </c:when>
                <c:when test="${sessionScope.USERTYPE.equals('Project Manager')}">
                    <a href="CreateNewUserGridView.jsp">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Create User</div>

                        </div>
                    </a>
                </c:when>
                <c:when test="${sessionScope.USERTYPE.equals('Calling Executive Manager')}">
                    <a href="CreateNewUserGridView.jsp">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Create User</div>

                        </div>
                    </a>
                    <a href="ProjectMasterGridView.jsp">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/projects.png" align="absmiddle" /> Projects</div>

                        </div>
                    </a>
                </c:when>
                <c:when test="${sessionScope.USERTYPE.equals('Broker Manager')}">
                    <a href="CreateNewUserGridView.jsp">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Create User</div>

                        </div>
                    </a>

                    <a href="AdminToBrokerPaymentModule.jsp">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Brokerage Payment</div>

                        </div>
                    </a>
                </c:when>
                <c:when test="${sessionScope.USERTYPE.equals('Accounts Manager')}">
                    <a href="AdminToBuilderPaymentModule.jsp">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Builder Payment</div>

                        </div>
                    </a>

                    <a href="AdminToBrokerPaymentModule.jsp">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Brokerage Payment</div>

                        </div>
                    </a>
                    <a href="AdminToCallerPaymentModule.jsp">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Incentives Payment</div>

                        </div>
                    </a>



                </c:when>
                <c:when test="${sessionScope.USERTYPE.equals('Project Accounts Manager')}">
                    <a href="SignUpPayment.jsp">
                        <div class="box01 fadeIn animated"> 

                            <div class="text02"><img src="images/profile.png" align="absmiddle" /> Sign Up Payment</div>

                        </div>
                    </a>
                </c:when>
                <c:otherwise>
                </c:otherwise>
            </c:choose>

    </body>
</html>
