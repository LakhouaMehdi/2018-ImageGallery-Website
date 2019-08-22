<!-- Lakhoua Mehdi
UCI
34592546 -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!-- Import libraries -->

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.Exception"%>

<%@ include file="Database.jsp" %>

<html>
  <head>
    <title>redirect</title>
  </head>
  
  <body>
  
  <%
	//get connection to the database
	Database db = Database.getDatabase();
	//get ID from submitted forms if any to fiure out what to do
	int funcID = Integer.parseInt(request.getParameter("funcID"));
 
	if (funcID == 2) //Need to add a gallery
	{	String gName = request.getParameter("name");
		String gDescription = request.getParameter("description");
		db.addAGallery(gName, gDescription);
		out.println("Added a gallery:" + gName + ":" + gDescription);
		response.sendRedirect("/gallery//galleries.jsp");
	}
	else if (funcID == 3) //Need to add an artist
	{
		String aName = request.getParameter("name");
		String aBirthYear = request.getParameter("birthyear");
		String aCountry = request.getParameter("country");
		String aDescription = request.getParameter("description");
		db.addAnArtist(aName, aBirthYear, aCountry, aDescription);	
		out.println("Added an artist:" + aName + ":" + aBirthYear + ":" + aCountry + ":" + aDescription);
		response.sendRedirect("/gallery//artists.jsp");
	} 
	else if (funcID == 5) //Need to edit name and description of gallery
	{   String gName = request.getParameter("name");
		String gDescription = request.getParameter("description");
		String galleryID = request.getParameter("galleryID");
		db.editGalleryByID(galleryID, gName, gDescription);
		out.println("Edited gallery:" + galleryID + ":" + gName + ":" + gDescription );
		response.sendRedirect(response.encodeRedirectURL("/gallery//galleryDetails.jsp?funcID=4&galleryID=" +galleryID)); 
	}
	else if (funcID == 6) //Need to delete a gallery
	{ 	String galleryID = request.getParameter("galleryID");
		db.deleteGalleryByID(galleryID);
		out.println("Deleted gallery:" + galleryID );
		response.sendRedirect("/gallery//galleries.jsp");	
	}
	else if (funcID == 7) //Need to create an image to add to the gallery
	{
		String galleryID = request.getParameter("galleryID");
		String title = request.getParameter("title");
		String link = request.getParameter("link");
		String artistID = request.getParameter("artistID");
		String iYear = request.getParameter("year");
		String iType = request.getParameter("type");
		String iWidth = request.getParameter("width");
		String iHeight = request.getParameter("height");
		String iLocation = request.getParameter("location");
		String iDescription = request.getParameter("description");
		
		db.addImageToGallery(galleryID, title, link, artistID, iYear, iType, iWidth, iHeight, iLocation, iDescription);
		response.sendRedirect(response.encodeRedirectURL("/gallery//galleryDetails.jsp?funcID=4&galleryID=" +galleryID)); 
	}
	else if (funcID == 9) //Need to delete an image from the gallery (keep the artist)
	{
		
		String imageID = request.getParameter("imageID");
		String galleryID = db.getGalleryIDOfImage(imageID);
		db.deleteImageByID(imageID);
		out.println("Deleted image:" + imageID );
		response.sendRedirect(response.encodeRedirectURL("/gallery//galleryDetails.jsp?funcID=4&galleryID=" +galleryID)); 
	}
	else if (funcID == 10) //Need to edit an image from the gallery
	{
		String imageID = request.getParameter("imageID");
		String title = request.getParameter("title");
		String link = request.getParameter("link");
		String artistID = request.getParameter("artistID");
		String iYear = request.getParameter("year");
		String iType = request.getParameter("type");
		String iWidth = request.getParameter("width");
		String iHeight = request.getParameter("height");
		String iLocation = request.getParameter("location");
		String iDescription = request.getParameter("description");
		
		db.editImageByID(imageID, title, link, artistID, iYear, iType, iWidth, iHeight, iLocation, iDescription);
		
		response.sendRedirect(response.encodeRedirectURL("/gallery//imageDetails.jsp?funcID=8&imageID=" +imageID)); 
	}
		else if (funcID == 11) //Need to edit artist
	{   
		String artistID = request.getParameter("artistID");
		String aName = request.getParameter("name");
		String aBirthYear = request.getParameter("birthyear");
		String aCountry = request.getParameter("country");
		String aDescription = request.getParameter("description");
		db.editArtistByID(artistID, aName, aBirthYear, aCountry, aDescription);
		out.println("Edited artist:" + aName + ":" + aBirthYear + ":" + aCountry + ":" + aDescription);
		response.sendRedirect("/gallery//artists.jsp");
	}
	

	
%>

	
  </body>
</html>
