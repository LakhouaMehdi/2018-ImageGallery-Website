<!-- Lakhoua Mehdi
UCI
34592546 -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ page import="java.util.Date"%>
<%@ include file="Database.jsp" %>

<html>
  <head>
    <title>Add Image</title>
	<link rel="stylesheet" type="text/css" href="style.css">
  </head>
 

 <body>
	
	 <br><br><br><br><br>
<form action="/gallery/redirect.jsp" target="leftFrame" method="post" onsubmit="document.location.href = 'empty.jsp';" >
		<input name="funcID" type="hidden" value="7">
		<input name="galleryID" type="hidden" value= <%=request.getParameter("galleryID")%> >
		
			<b><legend style="text-align:left;color: forestgreen;"><legend>Add Image to gallery </legend></b>
			Title: 
			<input name="title" type="text" required> <br/> 
			Link: 
			<input name="link" type="text" required> <br/> 
			Artist:
			<select name="artistID" required>
			<option disabled selected value></option>
				<%
				Database db = Database.getDatabase();
				ResultSet rs = db.getAllArtists();
				if (rs != null) {
					while( rs.next()){
						out.println("<option value="+ rs.getString("artist_id") + " title="+ rs.getString("artist_id") +">" +rs.getString("name")+"</option>)" );
					}
				}	
				%>
				</select>
				<br> 
			
			<b><legend><legend>Details:</legend></b>
			Year:
			<input name="year" type="number" min="0" max=<%=new java.text.SimpleDateFormat("yyyy").format(new java.util.Date())%> required>
			Type:
				<select name="type" required>
				<option disabled selected value></option>
				<option value="JPG">JPG</option>
				<option value="PNJ">PNJ</option>
				<option value="GIF">GIF</option>
				<option value="TIF">TIF</option>
				<option value="RAW">RAW</option>
				</select>
				<br> 
			Width: 
			<input name="width" type="number" min="0" required>
			Height: 
			<input name="height" type="number" min="0" required> <br/> 
			Location: 
			<input name="location" type="text" required> <br/> 
			Description: <br/> 
			<textarea name="description" rows="5" cols="50" required></textarea>  <br/> 
			<input type="submit" value="Add"  />
	</form>
	


  
  </body>
</html>
