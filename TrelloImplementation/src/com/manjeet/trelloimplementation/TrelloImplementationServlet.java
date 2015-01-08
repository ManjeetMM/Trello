package com.manjeet.trelloimplementation;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.KeyFactory;
import com.manjeet.trelloclasses.Board;
import com.manjeet.trelloclasses.TrelloUser;
import com.manjeet.utility.PMF;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("serial")
public class TrelloImplementationServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException
	{
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		PersistenceManager pm=PMF.get().getPersistenceManager();
		try
		{
		TrelloUser ttemp=pm.getObjectById(TrelloUser.class,req.getAttribute("Email").toString());
		RequestDispatcher rd=req.getRequestDispatcher("View.jsp");
		rd.forward(req, resp);
		}
		catch(Exception ee)
		{
			ee.printStackTrace();
		
		
		Key key=KeyFactory.createKey(TrelloUser.class.getSimpleName(), req.getAttribute("Email").toString());
		
		
		System.out.println("First time here");
		TrelloUser trelloUser=new TrelloUser();
		trelloUser.setKey(key);
		trelloUser.setName(req.getAttribute("Name").toString());
		trelloUser.setEmail(req.getAttribute("Email").toString());
		trelloUser.setImage(req.getAttribute("Image").toString());
		ArrayList<Board> alb=new ArrayList();
		trelloUser.setBoardlist(alb);
		
		try {
			  pm.makePersistent(trelloUser);
			  
			  System.out.println("Sucesssfully Trello user saved");
		    }
		
		catch (Exception e)
		   {
			e.printStackTrace();
		   }
		
		
		finally
		  {
			pm.close();
			RequestDispatcher rd=req.getRequestDispatcher("View.jsp");
			rd.forward(req, resp);
			
		  }
		
		}

		
	}
}
