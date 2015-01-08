<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<title>Contaning Details About Your Gmail</title>
</head>
<body  >
<center>
<b> Manjeet Kumar welcome's You </b><br/>
   <% if((request.getParameter("code"))!=null)
		{
	      out.print("<html><font color='green'>Your code is : </font> "+request.getParameter("code"));
		}
      else
	      out.print("<font color='red'>The user refused to grant the access");
   %>
   <% String c=request.getParameter("code"); %>
   <%
   try{
       java.net.URL url=new java.net.URL("https://accounts.google.com/o/oauth2/token");
       java.net.HttpURLConnection con=(HttpURLConnection) url.openConnection();
       con.setDoOutput(true);
       con.setRequestMethod("POST");
       con.setRequestProperty("Host", "accounts.google.com");
       
       con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
       String data = "code="+request.getParameter("code")+"&client_id=703050201280-pdsmru78424cvlgn8o9qsv64t54irm83.apps.googleusercontent.com"+
       					"&redirect_uri=http://localhost:8888/GetAccess.jsp&client_secret=-OPgixKPEmfmAmGvbqiC4kz6&grant_type=authorization_code&scope=";
       OutputStream outputStream = con.getOutputStream();
       outputStream.write(data.getBytes());
       outputStream.close();
       
       con.connect();
       out.println("<br/> We Are going to Know what it contains<br/>");
       //out.print(con.getInputStream().toString());
       
       InputStream ins = con.getInputStream();
       BufferedReader reader = new BufferedReader(new InputStreamReader(ins));
       StringBuilder out1 = new StringBuilder();
       String line;
       while ((line = reader.readLine()) != null) {
           out1.append(line);
       }
       System.out.println(out1.toString()); 
       
      
       JSONObject jsonobject=new JSONObject(out1.toString());
       System.out.println("json object Value"+jsonobject);
       String actoken=jsonobject.get("access_token").toString();
       String refreshtoken=jsonobject.get("refresh_token").toString();
       System.out.println("Your acess token is : "+actoken);
       System.out.println("Your Refresh Tocken is :"+refreshtoken);
       out.print("Access Tocken is : <font color='red'> <b>"+actoken+"<br/> </font>"+"<font color='green' fot-family='verdana' >Your Refresh Tocken is </font> :"+refreshtoken);
       
       reader.close();
       /* 
               /plus/v1/people/me?access_token=  
       */
       
       
       java.net.URL urll = new java.net.URL("https://www.googleapis.com/plus/v1/people/me?access_token="+actoken);
       
       BufferedReader readerr = new BufferedReader(new InputStreamReader(urll.openStream()));
       
       StringBuilder outp = new StringBuilder();
       String linee;

       while ((linee= readerr.readLine()) != null) 
       {
    	   outp.append(linee);
    	   
           
       }
       
       System.out.print("Here i am getting the object"+outp.toString());
       out.println("<br/></b>");
       //out.println("<font color='blue'>"+outp.toString());
       JSONObject js=new JSONObject(outp.toString());
       System.out.println("");
       System.out.println("JSON Object is:"+js);
       String Name =js.getString("displayName");
       System.out.print("Your name is :"+Name);
       out.print("<span class='glyphicon glyphicon-user'></span>");
       out.print("Youe Name is :"+Name+"<br/>");
       JSONObject jsnew =js.getJSONObject("image");
       System.out.print("Json Image Object is : "+jsnew);
       
       out.println("Your Image Url Is :"+jsnew.getString("url"));
       
       
       
       //out.println("Your email containing object is"+js.getString("emails").toString());
       
        java.util.ArrayList  al=new java.util.ArrayList();
        al.add(js.get("emails"));
        
        out.println("Your emails are "+al);
        
        System.out.print("Your email is :");
        org.json.JSONArray a=(org.json.JSONArray)js.get("emails");
        
         System.out.print(""+a); 
         JSONObject  em= (JSONObject)a.get(0);
         System.out.println(""+em);
         
         System.out.println("Your emwil id is"+em.get("value"));
        
        
        
       
        %>
        
        <img alt="" height="100px" width="100px" src="<%=jsnew.getString("url").toString() %>">
        <% 
       
       
       readerr.close();
        
        //=================== Forwarding to the (/trelloimlementation) =====================
        		
        request.setAttribute("Name", Name);
        request.setAttribute("Image", jsnew.getString("url"));
        request.setAttribute("Email", em.get("value"));
        RequestDispatcher rd=request.getRequestDispatcher("trelloimplementation");
        rd.forward(request, response); 
        
       //===================================================================================
     
 
   }
       
   catch(Exception e)
   {
 
	   e.printStackTrace();
	   
   }
   %>
</center>
</body>
</html>