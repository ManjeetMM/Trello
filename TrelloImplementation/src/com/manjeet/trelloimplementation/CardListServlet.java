package com.manjeet.trelloimplementation;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.manjeet.trelloclasses.Board;
import com.manjeet.trelloclasses.Card;
import com.manjeet.trelloclasses.CardListClass;
import com.manjeet.utility.PMF;

public class CardListServlet extends HttpServlet
{
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException,IOException
	{
		res.setContentType("text/html");
		PrintWriter out=res.getWriter();
		
		System.out.println("Inside the CardListServlet Getting The Board Object hashcode"+req.getParameter("hid2"));
		out.println("Object Hash Code "+req.getParameter("hcodeObject"));
		String cardlistclassName=req.getParameter("ListName");
		PersistenceManager pm=PMF.get().getPersistenceManager();
		Board board = pm.getObjectById(Board.class,req.getParameter("hcodeObject"));
		
		CardListClass cardlistclass=new CardListClass();
		cardlistclass.setName(cardlistclassName);
		String cardlistclassHashCode=""+cardlistclass.hashCode();
		cardlistclass.setHashCode(cardlistclassHashCode);
		//=============================================
		ArrayList<Card> cardArrayList=new ArrayList<>();
		cardlistclass.setCards(cardArrayList);
		//=============================================
		//ArrayList <CardListClass> CLCArrayList=new ArrayList<>();
		ArrayList <CardListClass> CLCArrayList=board.getCardListClasses();
		CLCArrayList.add(cardlistclass);
		board.setCardListClasses(CLCArrayList);
		
		try 
		{
			
			pm.makePersistent(board);
			
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		finally
		{
			pm.close();
			/*req.setAttribute("objectHashCode", req.getParameter("hcodeObject"));
			RequestDispatcher rd=req.getRequestDispatcher("http://localhost:8888/Boards.jsp?hid="+req.getParameter("hcodeObject")+"");
		   */
		}
		  res.sendRedirect("http://localhost:8888/BoardEvent.jsp?hid="+req.getParameter("hcodeObject")+"");
		//res.sendRedirect("http://localhost:8888/Boards.jsp?hid="+req.getParameter("hcodeObject")+"");
		
	}

}
