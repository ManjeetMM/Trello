package com.manjeet.trelloclasses;

import java.util.ArrayList;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.datanucleus.annotations.Unowned;


@PersistenceCapable
public class Board 
{
	
	@Persistent(valueStrategy=IdGeneratorStrategy.IDENTITY)
	private Key key;
	
	@Persistent
	private String Name;
	
	@PrimaryKey
	@Persistent 
	private String hashCode;
	
	

    @Unowned
	@Persistent
	private ArrayList <CardListClass> cardListClasses;
	

	public ArrayList<CardListClass> getCardListClasses() {
		return cardListClasses;
	}

	public void setCardListClasses(ArrayList<CardListClass> cardListClasses) {
		this.cardListClasses = cardListClasses;
	}

	public String getHashCode() {
		return hashCode;
	}

	public void setHashCode(String hashCode) {
		this.hashCode = hashCode;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public Key getKey() {
		return key;
	}

	public void setKey(Key key) {
		this.key = key;
	}
	
	

}
