<!-- Lakhoua Mehdi
UCI
34592546 -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	


<%@ include file="Database.jsp" %>
	
<html>
  <head>
    <title>Gallery details</title>
	<link rel="stylesheet" type="text/css" href="style.css">
  </head>
 
  <body>
	<%
		//get connection to the database
		Database db = Database.getDatabase();
		String galleryID = request.getParameter("galleryID");
		String galleryName = db.getNameOfGallery(galleryID);
		String galleryDescription = db.getDescriptionOfGallery(galleryID);
	%>	
	
		<h1><%=galleryName%></h1>
		<p style = "text-align: left;"><%=galleryDescription%></p>
		
		<b><legend style="text-align:center;color: DodgerBlue;"><%=db.getNumberOfImagesInGallery(galleryID)%> image(s) found </legend></b>
	

	<div class="imageList">
	<table>
	 <%
		//Display the images in the gallery
	 	ResultSet rs = db.getImagesOfGallery(galleryID);
		
			if (rs != null) {
				int count = 0;
				out.println("<table>");
				out.println("<tr>");
				while( rs.next()){
					
					String imageID = rs.getString("image_id");
					
					out.println("<td>");
					
					out.println("<legend style='text-align:center;color: black;'>" +rs.getString("title") +"</legend>");
					out.println("<a href='" + rs.getString("link") +  "'><img src='"+ rs.getString("link") +"' alt='Invalid Link' width='200' height='200' > </a> " );
					out.println("<br>");
				
					out.println("<form action='imageDetails.jsp' target='leftFrame' method='post'>");				
					out.println("<input name='imageID' type='hidden' value='" + imageID + "'>");
					out.println("<input type='submit' value='View'/>");
					out.println("</form>");
			
					out.println("</td>");
					
					count ++;
					if (count%5 == 0) 
					out.println("</tr><tr>");
				}
			}
		
	%> 
	</table>
	</div>

	<div class="innerMenu">
 
    <ul>

	<li>
	<form action="/gallery/addImage.jsp"  target="rightFrame"  method="post">
	<input name="galleryID" type="hidden" value= <%=galleryID%> >
	<input type="submit" value="Add more images" />
	</form> 
	</li>
	
	<li>
	<form action="editGallery.jsp"  target="rightFrame"  method="post">
	<input name="galleryID" type="hidden" value= <%=galleryID%> >
	<input type="submit" value="Edit" />
	</form>
	</li>
	
	<li>
	<form action="deleteGallery.jsp"  target="rightFrame"  method="post">
	<input name="galleryID" type="hidden" value= <%=galleryID%> >
	<input type="submit" value="Delete" />
	</form>
	</li>
	
	<li>
	</form>
		<form action='galleries.jsp' target='leftFrame' method='post' onsubmit="parent.document.getElementById('rightFrame').contentWindow.document.location.href = 'empty.jsp';">
		<input type="submit" value="Return"/>
	</form>
	</li>
	
</ul>
</div>
	
</body>
</html>