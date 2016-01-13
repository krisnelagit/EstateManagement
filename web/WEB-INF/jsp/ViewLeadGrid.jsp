<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : ViewLeadGrid
    Created on : 16 Dec, 2015, 11:00:35 AM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Lead</title>
        <link href="css/table1.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css"/>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <!--<script type="text/javascript" src="js/jquery.dataTables.js"></script>-->
        <script type="text/javascript" src="js/datatable.js"></script>
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
                        url: "deleteleadrecord",
                        data: {id: id, deskname: "leadmaster"
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
        <a href="addLeadLink" class="newbtn2 ">Add</a>   
        <strong class="heading"><img src="image/leads3.png" align="absmiddle" /> LEADS</strong>
        <hr class=" hr"/>
        <div style="overflow: auto;">
            <form id="frm1" method="post">
                <div id="recordcount" style="float: left; margin-bottom: 5px;">
                    <select id="recordcnt" name="recordcnt" style="width: 60px">
                        <c:if test="${recordcnt == '10'}">
                            <option selected="selected">10</option>
                            <option>25</option>
                            <option>50</option>
                            <option>100</option>
                        </c:if>
                        <c:if test="${recordcnt == '25'}">
                            <option>10</option>
                            <option selected="selected">25</option>
                            <option>50</option>
                            <option>100</option>
                        </c:if>
                        <c:if test="${recordcnt == '50'}">
                            <option>10</option>
                            <option>25</option>
                            <option selected="selected">50</option>
                            <option>100</option>
                        </c:if>
                        <c:if test="${recordcnt == '100'}">
                            <option>10</option>
                            <option>25</option>
                            <option>50</option>
                            <option selected="selected">100</option>
                        </c:if>
                        <c:if test="${recordcnt == null || recordcnt == ''}">
                            <option>10</option>
                            <option>25</option>
                            <option>50</option>
                            <option>100</option>
                        </c:if>
                    </select>&nbsp;entries&nbsp;&nbsp;
                    <input type="submit" class="view" style="border: none; cursor: pointer; width: 50px;" value="Show" onclick="return ReloadPage(this, 'TableDemoWithSearchAndRecordCount');"/>
                </div>
                <div id="search" style="float: right; margin-bottom: 5px;">
                    <input type="hidden" id="txtoldsearch" name="txtoldsearch" value="${txtsearch}"/>
                    Search : <input type="text" id="txtsearch" name="txtsearch" value="${txtsearch}"/>&nbsp;&nbsp;
                    <input type="submit" class="view" style="border: none; cursor: pointer;" value="Search" onclick="return Search(this, 'TableDemoWithSearchAndRecordCount');"/>
                    <input type="hidden" id="condition" name="condition" value="${condition}"/>
                    <input type="hidden" id="stSearchURL" name="stSearchURL" value="${stSearchURL}"/>
                </div>
                <br>
                <table class="table1" style="border: 1px solid #ccc;">
                    <thead>
                        <tr>
                            <td align="left" id="date">Date</td>
                            <td align="left" id="name">Name</td>
                            <td align="left" id="mobile">Mobile</td>
                            <td align="left" id="phone">Phone</td>
                            <td align="left" id="email">Email</td>
                            <td align="left" id="loan">Loan</td>
                            <td align="left" id="address">Address</td>
                            <!--<td align="left" id="">Description</td>-->
                            <td align="left" id="leadstatus">Status</td>
                            <td align="left">Actions</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${leaddt == null}">
                            <tr>
                                <td colspan="3" style="text-align: center;">
                                    No data available in table
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${page == null}">
                            <c:set var="count" value="1" scope="page"></c:set>
                        </c:if>
                        <c:if test="${page != null}">
                            <c:set var="count" value="${(page-1)*recordcnt+1}" scope="page"></c:set>
                        </c:if>
                        <c:forEach var="obj" items="${leaddt}">
                            <c:choose>
                                <c:when test="${obj.leadstatus=='Call Back'}">
                                    <c:set var="color" value="#b1d3e8" />
                                </c:when>
                                <c:when test="${obj.leadstatus=='Info Given'}">
                                    <c:set var="color" value="#e8d2b1" />
                                </c:when>
                                <c:when test="${obj.leadstatus=='Site Visit'}">
                                    <c:set var="color" value="#c4ebcf" />
                                </c:when>
                                <c:when test="${obj.leadstatus=='Not Interested'}">
                                    <c:set var="color" value="#ebc4c4" />
                                </c:when>
                            </c:choose>

                            
                            <tr>
                                <td style="background-color: ${color}" align="center" style="width: 10%;">
                                    ${obj.date}
                                </td>
                                <td style="background-color: ${color}">${obj.name}</td>
                                <td style="background-color: ${color}">${obj.mobile}</td>
                                <td style="background-color: ${color}">${obj.phone}</td>
                                <td style="background-color: ${color}">${obj.email}</td>
                                <td style="background-color: ${color}">${obj.loan}</td>
                                <td style="background-color: ${color}">${obj.address}</td>
                                <!--<td>$ {obj.description}</td>-->
                                <td style="background-color: ${color}">${obj.leadstatus}</td>
                                <td style="background-color: ${color}">
                                    <a href="editLeadLink?id=${obj.leadid}" class="edit_link"><img src="images/edit_1.png" class="edit"/></a>
                                    <a onclick="confirmdelete('${obj.leadid}', this);" class="edit_link" title="Delete" ><img src="images/delete_1.png" class="delete"/></a> 
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <br>
                <div id="recdet">
                    ${recdet}
                </div>
                <c:set var="dis" value="" scope="page"></c:set>
                <c:if test="${pagecnt == 0}">
                    <c:set var="dis" value="disabled='disabled'" scope="page"></c:set>
                </c:if>   
                <div id="paging">
                    <input type="hidden" id="pagecnt" name="pagecnt" value="${pagecnt}"/>
                    <input type="hidden" id="page" name="page" value="${page}"/>
                    <input type="hidden" id="startpage" name="startpage" value="${startpage}"/>
                    <input class='prev' type="submit" style="cursor: pointer;" value='Previous' ${dis}></input>
                    <c:if test="${pagecnt <= 10}">
                        <c:forEach var="i" begin="1" end="${pagecnt}">
                            <input id="${i}" class='pg' type="submit" style="cursor: pointer;" value='${i}'/>
                        </c:forEach>
                    </c:if>
                    <c:if test="${pagecnt > 10}">
                        <c:if test="${page == null}">
                            <c:forEach var="i" begin="1" end="10">
                                <input id="${i}" class='pg' type="submit" style="cursor: pointer;" value='${i}'/>
                            </c:forEach>
                            <input id="11" class='pg1' type="submit" style="cursor: pointer;" value='...'/>
                        </c:if>
                        <c:if test="${page != null}">
                            <c:if test="${startpage > 1}">
                                <input id="${startpage-10}" class='pg1' type="submit" style="cursor: pointer;" value='...'/>
                            </c:if>

                            <c:if test="${startpage+9 <= pagecnt}">
                                <c:forEach var="i" begin="${startpage}" end="${startpage+9}">
                                    <input id="${i}" class='pg' type="submit" style="cursor: pointer;" value='${i}'/>
                                </c:forEach>
                            </c:if>
                            <c:if test="${startpage+9 > pagecnt}">
                                <c:forEach var="i" begin="${startpage}" end="${pagecnt}">
                                    <input id="${i}" class='pg' type="submit" style="cursor: pointer;" value='${i}'/>
                                </c:forEach>
                            </c:if>

                            <c:if test="${startpage+10 < pagecnt}">
                                <input id="${startpage+10}" class='pg1' type="submit" style="cursor: pointer;" value='...'/>
                            </c:if>                                
                        </c:if>
                    </c:if>
                    <input class='next' type="submit" style="cursor: pointer;" value='Next' ${dis}></input>
                </div>
                <br /><br />
            </form>
        </div>
    </body>
</html>
