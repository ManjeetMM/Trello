package com.manjeet.trelloimplementation;

import java.io.IOException;
import java.util.ArrayList;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.manjeet.trelloclasses.Card;
import com.manjeet.trelloclasses.CardListClass;
import com.manjeet.utility.PMF;

public class CardServlet extends HttpServlet
{
	public void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException,IOException
	{
		//System.out.println("The HshCode Of the CARDLIST Object  is :"+req.getParameter("hashcodeOfCardListObj"));
		System.out.println("The name of the Card is "+req.getParameter("cardName"));
		
		PersistenceManager pm=PMF.get().getPersistenceManager();
		
		 CardListClass clc=pm.getObjectById(CardListClass.class,req.getParameter("hashcodeOfCardListObj").toString());
		 Card card=new Card();
		 card.setName(req.getParameter("cardName"));
		 
		 ArrayList<Card> alc=clc.getCards();
		 alc.add(card);
		try {
			pm.makePersistent(clc);
		    }
		catch (Exception e) 
		   {
			// TODO: handle exception
			e.printStackTrace();
		  }
		finally
		{
			pm.close();
		}
		
	}

}
