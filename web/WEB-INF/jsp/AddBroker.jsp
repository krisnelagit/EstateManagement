<%-- 
    Document   : AddBroker
    Created on : 16 Dec, 2015, 4:50:07 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Broker</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script> 
        <style>
            .input001{width: 200px; height: 30px;}
            input{width: 90px;}
            .input002{width: 50px; height: 30px}
        </style>
        <script src="js/BaseJava.js"></script>
    </head>
    <body>
        
    <center>
        <form action="insertBroker" method="POST">
        <table border="0" cellpadding="3" cellspacing="3" class="box04">
            <thead>
                <tr>
                    <th colspan="2" align="left">Create New Broker</th>

                </tr>
            </thead>
            <tbody>
                <tr>
                    <td align="left">Name</td>
                    <td align="left"> <input type="text" name="name" value="" class="input001" required="" onkeypress="javascript:return isTextKey(event);" title="enter your name" placeholder="Enter Your Name"/> </td>
                </tr>
                <tr>
                    <td align="left">Address</td>
                    <td align="left"> 
                        <!--<input type="text" name="txtNewUserAddress" value="" class="input001" required=""/>-->
                        <textarea name="address" rows="4" cols="20" class="input001 select" required="" placeholder="Enter Your Address"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="left">Mobile</td>
                    <td align="left"> <input type="text" name="mobile" value="" class="input001" required="" onkeypress="javascript:return isNumberKey(event);" title="enter your mobile number" placeholder="Enter Your Mobile Number" maxlength="10"/> </td>
                </tr>
                <tr>
                    <td align="left">Email</td>
                    <td align="left"> <input type="email" name="email"  value="" class="input001" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?" required=""  title="enter your email" placeholder="Enter Your Email"/> </td>
                </tr>
                <tr>
                    <td align="left">Login Id</td>
                    <td align="left"> <input type="text" name="login_id" value="" class="input001" required="" onkeypress="javascript:return isTextKey(event);" title="enter your login id" placeholder="Enter Your Login Id"/> </td>
                </tr>
                <tr>
                    <td align="left">Password</td>
                    <td align="left"> <input type="text" name="password" value="" class="input001" required="" title="enter password" placeholder="Enter Password" id="password"/> </td>
                </tr>
                <tr>
                    <td align="left">Confirm Password</td>
                    <td align="left"> <input type="text" name="confirm_password" value="" class="input001" required="" title="confirm password" placeholder="Confirm Password" oninput="check(this)"/> </td>
                </tr>
                <tr>
                    <td align="left">Type</td>
                    <td align="left"> 
                        <input type="text" name="type" value="Broker" readonly="readonly" />                            
                    </td>
                </tr>
                <tr  id="Brokerage">
                    <td align="left">Brokerage</td>
                    <td align="left"> <input type="text" id="BrokerageText" name="brokerage" value="0" class="input001" onkeypress="javascript:return isNumberKey(event);" title="enter your brokerage" placeholder="Enter Your Brokerage"/> </td>
                </tr>
                <tr>
                    <td align="left"> </td>
                    <td align="left"><input type="submit" name="checkbtn" value="Save" class="newbtn"/> <input type="reset" value="Clear All" class="newbtn"/> <a href="addLeadLink" class="newbtn">Cancel</a></td>
                </tr>
            </tbody>
        </table>
    </form>
</center>
</body>
</html>