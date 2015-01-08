package com.manjeet.trelloimplementation;

import java.io.IOException;
import java.io.PrintWriter;

import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.manjeet.trelloclasses.Board;
import com.manjeet.utility.PMF;

public class RenameBoard extends HttpServlet 
{
	public void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException ,IOException
	{
		System.out.println(" **** The oBject Code to rename that one is "+req.getParameter("renameObjectCode"));
		
		PrintWriter out=res.getWriter();
		//=========================== Getting the Object and and persist the with the new name =================================//
		
		PersistenceManager pm=PMF.get().getPersistenceManager();
		
		Board board=pm.getObjectById(Board.class,req.getParameter("renameObjectCode"));
		
		board.setName(req.getParameter("rename"));
		
		try 
		{
			pm.makePersistent(board);
			System.out.println("Board Is renamed Thank You");
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		finally
		{
			pm.close();
		}
		
		out.println("Sucessfully Renamed");
		res.sendRedirect("http://localhost:8888/BoardEvent.jsp?hid="+req.getParameter("renameObjectCode")+"");
		
		//================================================ ************========================================================//
	}

}
