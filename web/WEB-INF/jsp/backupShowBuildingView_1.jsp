<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ShowBuildingView
    Created on : 10 Dec, 2015, 5:51:02 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Building</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <link href="css/bulddesign.css" rel="stylesheet" type="text/css" />
        <script>
            $(function () {
                $(".email_link").click(function (e) {
                    e.preventDefault();
                    var url = $(this).attr("href");
                    var mytitle = "Flats Record";
                    $("#dialog").load(url, null, function () {
                        $("#dialog").dialog({
                            title: mytitle,
                            modal: true,
                            width: 600,
                            close: function (event, ui) {
                                $("#dialog").empty(); // remove the content
                            }//END CLOSE
                        });//END DIALOG
                    });//END DIALOG
                });//END MODAL_LINK
            });//END FUNCTIO


            function aa(a)
            {

                var url = encodeURI(a);
                var mytitle = "Flats Record";
                $("#dialog").load(url, null, function () {
                    $("#dialog").dialog({
                        title: mytitle,
                        modal: true,
                        width: 600,
                        close: function (event, ui) {
                            $("#dialog").empty(); // remove the content
                        }//END CLOSE
                    });//END DIALOG
                });//END DIALOG
            }
        </script>

    </head>
    <body>
        <div style="float: right" class="newbtn2"><a href="ProjectMasterGridView.jsp" style="color: white">Back</a></div>
        <c:forEach var="ob" items="${buildingdt}">
            <div class="container123">
                <div class="bld-wall"><strong>Building No :- ${param.wings}</strong></div>
                <div class="bld-part"></div>
                <div class="bld-wall2">
                    <c:forEach var="fd" items="${ob.floorsdt}">
                    <c:forEach var="i"  begin="0" end="${ob.floorsdt-1}" step="1">
                        <c:set var="j" value="${ob.floorsdt-i}" />
                    <div class="bld-floor"> <strong>Floor No :-  ${j}<br/></strong><br />
                        
                            <c:forEach var="of" items="${fd.flatdt}">
                            <a onclick="aa('showFlatsDetails?flatid=${of.customid}')" href="#" style="text-decoration:none;" >   
                                <c:if test="${of.status=='SOLD'}">
                                    <div class="window2">
                                        <div class="detail" title="date : ${of.Sdate} / Name :  ${of.Sname}">${of.flatname}</div>
                                    </div>
                                </c:if>
                                <c:if test="${of.status=='UNSOLD'}">
                                    <div class="window">
                                        <div class="detail">${of.flatname}</div>
                                    </div>
                                </c:if>
                            
                        </c:forEach>
                                
                        </c:forEach>
                                </a>
                    </div>                            
                    </c:forEach>
                    <div class="ground-flr">
                        <img src="images/door.png" width="40" height="84" class="door"/>  
                        <img src="images/tree.png" width="84" height="105" style="position: absolute; left: 233px; top: -10px;"/>
                        <img src="images/tree.png" width="84" height="105" style="position: absolute; left: -21px; top: -10px;"/>
                    </div>
                </div>
                <div class="bld-floor2"></div>
            </div>
        </c:forEach>
    </body>
</html>
