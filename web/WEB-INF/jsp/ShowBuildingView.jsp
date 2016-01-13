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
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <link href="css/bulddesign.css" rel="stylesheet" type="text/css" />
        <script>
            //ready function begins here
            $(document).ready(function () {
                $("#flatdialog").hide();

                //code to display flat details dialog here
                $(".showflatinfo").click(function () {
                    var flatid = $(this).closest('a').find('.flatiddt').val();
                    var flatname = $(this).closest('a').find('.flatnamedt').val();

                    var buildingid = $(this).closest('a').find('.buildingiddt').val();
                    var name = $(this).closest('a').find('.namedt').val();

                    console.log(name + " name");
                    var sqrfeet = $(this).closest('a').find('.sqrfeetdt').val();
                    var total = $(this).closest('a').find('.totaldt').val();
                    var signupid = $(this).closest('a').find('.signupiddt').val();
                    var flatarea;

                    //dialog called
                    $("#flatdialog").dialog({
                        modal: true,
                        effect: 'drop',
                        width: 600,
                        height: 450,
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });

                    //code to hide if sold begin here
                    if (!name) {
                        $(".solddt").hide();
                    } else {
                        $(".solddt").show();
                    }

                    //get flat details controller called
                    $.ajax({
                        url: "getflatdetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            id: flatid
                        },
                        cache: false,
                        success: function (data) {

                            flatarea = data[0].bhk;

                            $("#username").text(name);
                            $("#squarefeet").text(sqrfeet);
                            $("#total").text(total);
                            $("#flatname").val(flatname);
                            $("#flatstatus").val(data[0].status);
                            $("#flatid").val(flatid);
                            $("#projectid").val(buildingid);
                            $("#signupid").attr("href", "viewSignup?signupid=" + signupid);
                            if (!data[0].status) {
                                $("#flatstatus").val("UNSOLD");
                            }
                        }
                    });

                    //get flat area controller called
                    $.ajax({
                        url: "getflatareadetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            id: buildingid
                        },
                        cache: false,
                        success: function (data) {
                            $('#flatarea').find('option').remove();
                            $('#flatarea').append('<option disabled>--select--</option>');
                            for (var i = 0; i < data.length; i++) {
                                if (flatarea === data[i].requirement) {
                                    $('#flatarea').append('<option selected="" value="' + data[i].requirement + '">' + data[i].requirement + '</option>');
                                } else {
                                    $('#flatarea').append('<option value="' + data[i].requirement + '">' + data[i].requirement + '</option>');
                                }
                            }
                        }
                    });
                });
                //code to display flat details dialog ends! here
            });
            //ready function ends! here            
        </script>
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
        <div style="float: right" class="newbtn2"><a href="viewWingGridLink?projectid=${param.projectid}" style="color: white">Back</a></div>
        <c:forEach var="ob" items="${buildingdt}" begin="0" end="0" step="1">
            <div class="container123">
                <div class="bld-wall"><strong>Building No :- ${param.wings}</strong></div>
                <div class="bld-part"></div>
                <div class="bld-wall2">
                    <c:set var="count" value="${param.floorscount}" scope="page"  />
                    <div id="batman">
                        <c:forEach var="fd" items="${ob.floorsdt}">
                            <div class="bld-floor"> <strong>Floor No :-  ${count}<br/></strong><br />

                                <c:forEach var="of" items="${fd.flatdt}">
                                    <a href="#" class="showflatinfo" style="text-decoration:none;" >  
                                        <!--hidden field required for dialog begins here-->
                                        <input type="hidden" class="flatiddt" name="flatid" value="${of.customid}" />
                                        <input type="hidden" class="flatnamedt" name="flatid" value="${of.flatname}" />
                                        <input type="hidden" class="buildingiddt" name="buildingid" value="${param.projectid}" />
                                        <input type="hidden" class="namedt" name="name" value="${of.sname}" />
                                        <input type="hidden" class="sqrfeetdt" name="sqrfeet" value="${of.ssquarfeet}" />
                                        <input type="hidden" class="totaldt" name="total" value="${of.stotal}" />
                                        <input type="hidden" class="signupiddt" name="signupid" value="${of.signupid}" />
                                        <!--hidden field required for dialog ends! here-->
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
                                    </a>   

                                </c:forEach>
                                <c:set var="count" value="${count - 1}" scope="page"/>  
                            </div> 
                        </c:forEach>   
                    </div>

                    <div class="ground-flr">
                        <img src="images/door.png" width="40" height="84" class="door"/>  
                        <img src="images/tree.png" width="84" height="105" style="position: absolute; left: 233px; top: -10px;"/>
                        <img src="images/tree.png" width="84" height="105" style="position: absolute; left: -21px; top: -10px;"/>
                    </div>
                </div>
                <div class="bld-floor2"></div>
            </div>
        </c:forEach>

        <!--code for flat dialog begins here-->
        <div id="flatdialog" title="Flat Record">
            <form method="POST" action="updateflatdetails">
                <input type="hidden" name="redirectprojid" value="${param.projectid}" />
                <input type="hidden" name="redirectwings" value="${param.wings}" />
                <input type="hidden" name="redirectfloorscount" value="${param.floorscount}" />
                <table border='1'>
                    <tbody>
                        <tr class="solddt">
                            <td>User Name</td>
                            <td> <span id="username"></span> </td>
                        </tr>
                        <tr class="solddt">
                            <td>Square ft.</td>
                            <td> <span id="squarefeet"></span> </td>
                        </tr>
                        <tr class="solddt">
                            <td>Total</td>
                            <td> <span id="total"></span> </td>
                        </tr>
                        <tr>
                            <td>Flat Name</td>
                            <td>
                                <input type="text" name="flatname" id="flatname" value="" />
                            </td>
                        </tr>
                        <tr>
                            <td>Flat Area</td>
                            <td>
                                <select name="bhk" id="flatarea">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Flat Status</td>
                            <td>
                                <input type="text" name="status" id="flatstatus" value="" />
                                <input type="hidden" name="flatid" id="flatid" value="" />
                                <input type="hidden" name="projectid" id="projectid" value="" />
                            </td>
                        </tr>
                        <tr>
                            <td> <input type="submit" value="Update" name="btn"/> </td>
                            <td> <a id="signupid" href="viewSignup?signupid=">View more</a> </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <!--code for flat dialog ends! here-->
    </body>
</html>

