
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%@page import="com.manjeet.trelloclasses.*"%>
    <%@page import="com.manjeet.utility.*"%>
    <%@page import="java.util.*" %>
    <%@page import="javax.jdo.PersistenceManager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"> -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="/jsLib/jquery-1.11.1.min.js"></script>
<title>Board</title>
</head>

<body bgcolor="#3083FF">
 <h4 style="background-color:#506EAA; height:50px" ></h4><hr/>

 <h3>
  
     <%
      PersistenceManager pm=PMF.get().getPersistenceManager();
      String value=request.getParameter("hid");
      System.out.println("The Value Of the object Hash Code is :"+value);

      Board board=pm.getObjectById(Board.class,value);

      System.out.println("Board Object Name is in the page BoardEvent.jsps"+board.getName());
     %>
     
   <label onclick="showRenameForm()"  id='boardLabel'>   <% out.print(board.getName()); %> </label>
   
 <!--   Form For Renaming The Board -->
 
    <form action="/renameBoard" method="post" id="renameForm"> <table><tr><td>Rename Board</td> <td> <input type="text" name="rename" id="Rename" /> </td><td> <input type="hidden" value="<%=request.getParameter("hid") %>" name="renameObjectCode" /> </td> <td> <input type="submit" value="SAVE"  onclick="return RenameCheck()"/> </td> </tr></table> </form>  
 
   <script type="text/javascript">  
        var i=0;
        document.getElementById('renameForm').style.visibility='hidden'; 
   </script>
  
  <!--    Rename form Ends Here  -->
   
</h3>

   <% 
       ArrayList<CardListClass> alc= board.getCardListClasses();
       if(!alc.isEmpty())
       {
         for(CardListClass c:alc)
         {
	       /* System.out.println("Name of the cardListCass "+c.getName());
	       System.out.println("HshCode Key value of the CardList Are : ******"+c.getHashCode()); */
	       
	     //out.print("<font color='white'>"+c.getName()+"</font><br/>");
    %>
	  <%-- <button id='<%=c.getHashCode() %>'  onclick="callToAddCard(event)"><%=c.getName() %></button> --%>
	  
	  <div id=" <%=c.getHashCode() %> " style="background-color: #CCCCFF ; position: float; width: 310px"> <label  style="position: fixed; "><%=c.getName() %></label> <br/>
	
    <%
      //============================================================
      
       ArrayList<Card> cards=c.getCards();
       if(!cards.isEmpty())
       {
         System.out.println("  Cards Are There ");
         for(Card card:cards)
         {
         %>
         
         <button>  <%=card.getName() %> </button>   
         <%
         }
       }
       else 
       {
    	
    	   System.out.println("  Cards Are  Not There ");
       }
       
       //===========================================================
    %>
    <!-- <label><a id="cardForm" > Add Card </a> </label><br/>   -->
      <div style="background-color: white ; position: float; width: 310px">
       <form id="AddCard" action="/card" method="post">
          <table>
              <tr>
                <td> <input type="text" height="70px" name="cardName"  placeholder="Card Name"/> </td> <td><input type="hidden" value="<%=c.getHashCode() %>" name="hashcodeOfCardListObj"/></td>
              </tr>
              <tr> <td> <input type="submit" value="Add" />  </td>
              </tr>
          </table> 
        </form>
      </div>
       <script >
       </script>
   </div><br/>
    <%		   
    		   
        }  
      }

   %>
 
 
 <div align="left" style="top:40px ; left: 20px; position:relative;">
   <form action="/CardListServlet" method="POST" id="AddingCardList">
      <table style="background-color:#4585C5 ">
            <tr><td>Add The List </td></tr>
            <tr><td><input type="text" name="ListName" id="ListName" /></td><td> <input type="hidden" value=<%=request.getParameter("hid") %>  name="hid2"/> </td> <input type="hidden" value="<%=request.getParameter("hid") %>" name="hcodeObject" /> <td> <input type="submit" Value="save"  onclick="return listNameCheck()"/> </td> </tr>
      </table>
   </form>
 </div>



 <script type="text/javascript">
        var RenameCheck=function()
        {
        	var name=document.getElementById('Rename').value;
        	console.log("Name is"+name);
        	if(name==null || name=="")
        		{
        		alert(" Please Enter Some Value in Rename Feilld ");
        		  return false;
        		}
        	else
        		return true;
        	
        }
        
        
        var listNameCheck=function()
        {
        	var name=document.getElementById('ListName').value;
        	console.log("Name is"+name);
        	if(name==null || name=="")
        		{
        		alert(" Please Enter Some Valiu in The List Name ");
        		  return false;
        		}
        	else
        		return true;
        	
        }
        
        
       var  showRenameForm=function()
       {
    	   if(i==0)
    		   {
    		   document.getElementById('renameForm').style.visibility='visible';
    		   i=1;
    		   }
    	   else
    		   {
    		   document.getElementById('renameForm').style.visibility='hidden';
    		   i=0;
    		   }
       }
       
  
          
         
         function callToAddCard(event)
         {
        	console.log("Event Id Value is : "+event.target.id);
        	
        	var xmlHttp = null;

            xmlHttp = new XMLHttpRequest();
            xmlHttp.open( "GET", '/card.jsp?cardLObjectHshCode='+event.target.id, true );
            xmlHttp.send(null);
            return xmlHttp.responseText;
         }
 </script>


</body>
</html>