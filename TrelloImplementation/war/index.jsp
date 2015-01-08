<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">

.main{
       background-image:url(images/img.jpg);
       background-repeat: no-repeat;
       background-position: top center;
       background-size: cover;
     }
     
</style>
<!--  -->
<title>Login Page</title>
</head>
<body class="main" >
<center>
<h4 > <font color="white" >Google OAuth </font> <span class="glyphicon glyphicon-envelope"></span></h4> <hr/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<table bgcolor="Black" height="100px" width="400px" >
  <tr><td colspan="2"> <font color="white"><img alt="" src="/images/gmail_login_image.jpg"  height="60px" width="100px" > </font> </td><td> <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile&state=manjeetapplication&redirect_uri=http://localhost:8888/GetAccess.jsp&response_type=code&client_id=703050201280-pdsmru78424cvlgn8o9qsv64t54irm83.apps.googleusercontent.com&approval_prompt=force&access_type=offline"><button type="button" class="btn btn-primary btn-lg">Click Here for google Login</button></a></td></tr>
</table>
</center>
</body>
</html>