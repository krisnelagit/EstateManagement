<!doctype html>
<!--[if lt IE 7]> <html class="ie6 oldie"> <![endif]-->
<!--[if IE 7]>    <html class="ie7 oldie"> <![endif]-->
<!--[if IE 8]>    <html class="ie8 oldie"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="">
    <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login</title>
        <link href="css/login.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/box.css"  type="text/css"/>
        <style>
            html{
                background:#f4f4f4;	
            }
        </style>
    </head>
    <body class="body">
        <form action="verifylogin" method="POST">
            <div class="krisnela_container"><img src="image/logo2.png" width="332" height="60" /></div><br />
            <br />
            <br />

            <div class="login_header">Login</div>
            <div class="login_container">
                <input name="username" type="text" placeholder="username" class="login_input" required=""/>
                <br /><br />
                <input name="password" type="password" placeholder="password" class="login_input" required=""/>
                <br /><br />
                <input type="submit" value="Login" class="login_btn"/> 
                <br /><br />
                <a href="#" class="fp">Forgot your password?</a><br />
            </div>
            <center><h1><font face="" color="red" size="2"></font></h1></center>
            <div style="width: 400px;margin: 0 auto;">
                <div class="alert-box error"><span>trial copy: </span></div>
                <div class="alert-box success"><span>secured: </span>Krisnela Support Protected $ {leftdays} Days Left.</div>
            </div>
            
            
            

            
            <br>
            <br>
            <br>
        </form>
    </body>
</html>