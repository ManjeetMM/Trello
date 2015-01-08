package com.manjeet.trelloclasses;

import java.util.*;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.datanucleus.annotations.Unowned;

@PersistenceCapable
public class TrelloUser 
{
	@PrimaryKey
	@Persistent
	private Key key;
	
	@Persistent
	private String name;
	
	@Persistent
	private String email;
	
	@Persistent
	@Unowned
	private ArrayList<Board> boardlist;
	
	
	
	/**
	 * @return the boardlist
	 */
	public ArrayList<Board> getBoardlist() {
		return boardlist;
	}

	/**
	 * @param boardlist the boardlist to set
	 */
	public void setBoardlist(ArrayList<Board> boardlist) {
		this.boardlist = boardlist;
	}

	@Persistent 
	private String image;

	public Key getKey()
	{
		return key;
	}

	public void setKey(Key key) {
		this.key = key;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
	

}
