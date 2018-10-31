<!-- Lakhoua Mehdi
UCI
34592546 -->

<!DOCTYPE html>

<%@ page import="java.util.Date"%>
<%@ include file="Database.jsp" %>

<html>

<head>
	<title>Your image</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
	<%
		//get connection to the database
		Database db = Database.getDatabase();
		String imageID = request.getParameter("imageID");
		String imageTitle = db.getTitleOfImage(imageID);
		String imageLink = db.getLinkOfImage(imageID);
		String galleryID = db.getGalleryIDOfImage(imageID);
		String artistID = db.getArtistIDOfImage(imageID);
		String detailID = db.getDetailIDOfImage(imageID);
		
		String iYear = db.getYearOfDetail(detailID); 
		String iType = db.getTypeOfDetail(detailID);
		String iWidth = db.getWidthOfDetail(detailID);
		String iHeight = db.getHeightOfDetail(detailID);
		String iLocation = db.getLocationOfDetail(detailID);
		String iDescription = db.getDescriptionOfDetail(detailID);
	%>
	<div class="innerMenu">
	<ul>
	<div class= "addForm">

		<form action="/gallery/redirect.jsp" target='leftFrame' method="post" onsubmit="document.location.href = 'empty.jsp';">
		<input name="funcID" type="hidden" value="10">
		<input name="imageID" type="hidden" value= <%=imageID%> >
		
			<legend>Edit Image:</legend>
			Title: 
			<input name="title" type="text" value= <%=imageTitle%>  required> <br/> 
			Link: 
			<input name="link" type="text" value= <%=imageLink%> required> <br/> 
			Artist: 
			<select name="artistID" value= <%=artistID%> required>
			<option disabled value></option>
				<%
				ResultSet rs = db.getAllArtists();
				if (rs != null) {
					while( rs.next()){
						out.println("<option value="+ rs.getString("artist_id") + " title="+ rs.getString("artist_id") +">" +rs.getString("name")+"</option>)" );
					}
				}	
				%>
				</select>
			<legend>Details:</legend>
			Year:
			<input name="year" type="number" value= <%=iYear%> min="0" max=<%=new java.text.SimpleDateFormat("yyyy").format(new java.util.Date())%> required>
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
			<input name="width" type="number" value= <%=iWidth%> min="0" required>
			Height: 
			<input name="height" type="number" value= <%=iHeight%> min="0" required> <br/> 
			Location: 
			<input name="location" type="text" value= <%=iLocation%> required> <br/> 
			Description: <br/> 
			<textarea name="description" rows="5" cols="50" required><%=iDescription%></textarea> <br/>
			<li><input type="submit" value="Edit"/> </li>
	 
		</div>		
	
	</form>
		<form action="/gallery/empty.jsp" target="rightFrame" method="post">
		<li><input type="submit" value="Cancel"/></li>
	</form>
	
	</ul>
	</div>
</body>