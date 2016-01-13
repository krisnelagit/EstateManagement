<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewWingsGrid
    Created on : 10 Dec, 2015, 5:19:31 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View wings</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <style>
            .box01{
                width: 180px;
            }
        </style>
    </head>
    <body>
        <br/>
        
        <c:forEach var="i" begin="1" end="${wingsdt.wings}" step="1">
            <a href="showbuildingviewofprojects?projectid=${param.projectid}&wings=${i}&floorscount=${wingsdt.floors}">
                <div class="box01 fadeIn animated">
                    <div class="text02">
                        Building No-${i}
                    </div>
                </div>
            </a>
        </c:forEach>
        
        
        
    </body>
</html>
