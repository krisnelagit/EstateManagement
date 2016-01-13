<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Estate  - <decorator:title default="Welcome!" /></title>
        <link rel="stylesheet" type="text/css" href="css/animate.css"/>
        <link rel="stylesheet" type="text/css" href="css/menu.css"/>
        <link href="css/main.css" rel="stylesheet" type="text/css" />
        <link href="css/main2.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
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

            .profile_photo {

                background-position: center;
                background-size: cover;
                width: 45px;
                height: 45px;
                border-radius: 50px;
                margin-top: -4px;
                display: inline-block;
            }

            body {
                overflow: hidden;
            }

            /* Preloader */

            #preloader {
                position:fixed;
                top:0;
                left:0;
                right:0;
                bottom:0;
                background-color:#fff; // change if the mask should have another color then white 
                //  makes sure it stays on top 
            }

            #status {
                width:200px;
                height:200px;
                position:absolute;
                left:50%; /* centers the loading animation horizontally one the screen */
                top:50%; /* centers the loading animation vertically one the screen */
                background-image:url(img/preloader.gif); /* path to your loading animation */
                background-repeat:no-repeat;
                background-position:center;
                margin:-100px 0 0 -100px; /* is width and height divided by two */

            }
        </style>
        <script>
            function go() {
                window.location.replace("logout.jsp", 'window', 'toolbar=1,location=1,directories=1,status=1,menubar=1,scrollbars=1,resizable=1');
                self.close();
            }
        </script>

        <decorator:head/>

        <link rel="shortcut icon" href="images/krisnela_technologies.ico"></link>
    </head>

    <body>
        <!--estate management body decorator coding begin here-->
        <div class="bg">
            <div id="nav">
                <ul>
                    <li>
                        <a href="adminDashboard"><img src="image/home.png" width="22" height="21" align="absmiddle" /> &nbsp;&nbsp;Dashboard</a>
                    </li>
                    <li>
                        <a href="viewLeadGridLink"><img src="image/leads.png" width="22" height="19" align="absmiddle" />&nbsp;&nbsp;&nbsp;Tele Calling Leads</a>
                    </li>
                    <li>
                        <a href="viewsignupGridLink"><img src="image/leads.png" width="22" height="19" align="absmiddle" />&nbsp;&nbsp;&nbsp;Sign Ups/Bookings</a>
                    </li>
                    <li>
                        <a href="viewnewsignupGridLink"><img src="image/leads.png" width="22" height="19" align="absmiddle" />&nbsp;&nbsp;&nbsp;New Sign Ups/Bookings</a>
                    </li>
                    <li>
                        <a href="viewPaymentsGridLink"><img src="image/leads.png" width="22" height="19" align="absmiddle" />&nbsp;&nbsp;&nbsp;Payments</a>
                    </li>
                    <li>
                        <a href="../View/AdminSyncPage.jsp"><img src="image/sync2.png" width="22" height="22" align="absmiddle" />&nbsp;&nbsp;&nbsp;Sync Data</a>
                    </li>
                </ul>                
                <br class="clearboth"/>
            </div>
        </div>
        <div class="menu_header">
            <div class="profile_right"> &nbsp;
                <table style="margin-left: 30px;">
                    <tr>
                        <td align="left" valign="top">

                        </td>
                        <td  align="left" valign="top" style="color: #e74c3c"><div style="color: #333; display: inline-block; margin-top: 7px;">Welcome </div> <div style="display: inline-block; margin-top: 7px;">${sessionScope.USERNAME}</div></td>
                        <td width="46" align="left" valign="top"><a href="setting" class="settings"  title="Settings"></a></td>
                        <td width="50" align="left" valign="top"><a href="changepasswordlink" class="Cpass"><img src="images/change_password.png" alt="" title="Change Password"  width="21" height="20" /></a></td>
                        <td width="50" align="left" valign="top"><a href="logout" class="logout" title="Logout"><img src="image/logout.png" width="21" height="20" /></a></td>
                        <!--<td width="50" align="left" valign="top"><a href="javascript:go()" class="logout" title="Logout"><img src="image/logout.png" width="21" height="20" /></a></td>-->
                    </tr>
                </table>
            </div>
            <div class="menu_header2"> <img src="image/logo_1.png" class="krisnela_logo"/> </div>
        </div>

        <!-- Preloader -->
        <div id="preloader" style="z-index: 6">
            <div id="status">&nbsp;</div>
        </div>

        <!-- jQuery Plugin -->
        <!--<script type="text/javascript" src="js/jquery.min.js"></script>-->

        <!-- Preloader -->
        <script type="text/javascript">
            //<![CDATA[
            $(window).load(function () { // makes sure the whole site is loaded
                $('#status').fadeOut(); // will first fade out the loading animation
                $('#preloader').delay(350).fadeOut('fast'); // will fade out the white DIV that covers the website.
                $('body').delay(350).css({'overflow': 'visible'});
            });

            //]]>
        </script> 

        <!--estate management body decorator coding ends! here-->
        <div class="container-body-estate">    
            <div class="bg2">


                <decorator:body/>

            </div>
        </div>
    </body>
</html>