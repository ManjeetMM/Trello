package com.manjeet.trelloimplementation;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.jdo.PersistenceManager;

import com.google.appengine.api.datastore.Key;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.KeyFactory;
import com.manjeet.trelloclasses.Board;
import com.manjeet.trelloclasses.CardListClass;
import com.manjeet.trelloclasses.TrelloUser;
import com.manjeet.utility.PMF;

public class BoardServlet extends HttpServlet
{
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException
	{
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		System.out.println("Comming To the add Board");
		String BoardName= req.getParameter("boardName");
		
		PersistenceManager pm=PMF.get().getPersistenceManager();
		Key k=KeyFactory.createKey(Board.class.getSimpleName(), BoardName);
		
		Board board=new Board();
		System.out.println("Hash Code Of the Object:"+board.hashCode());
		String hshCode=""+board.hashCode();
		
		board.setName(BoardName);
		board.setKey(k);
		board.setHashCode(hshCode);
		
		//===================================
		ArrayList<CardListClass> alt=new ArrayList<>();
		board.setCardListClasses(alt);
		//================================
		
		TrelloUser t=pm.getObjectById(TrelloUser.class,req.getParameter("hidden"));
		ArrayList<Board> al=t.getBoardlist();
		System.out.println("Here");
		al.add(board);
		
		System.out.println("wanna get the emai id in Board Servlet Page"+req.getParameter("hidden"));
		
		t.setBoardlist(al);
		try
		{
			System.out.println("Here for persisting the Object tuser");
			pm.makePersistent(t);
			
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		finally
		{
			req.setAttribute("Email",req.getParameter("hidden"));
			RequestDispatcher rd=req.getRequestDispatcher("View.jsp");
			rd.forward(req, resp);
		}
	}

}
