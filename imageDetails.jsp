<!-- Lakhoua Mehdi
UCI
34592546 -->

<!DOCTYPE html>

<%@ include file="Database.jsp" %>

<html>

<head>
	<title>Image Details</title>
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
	
	
	Title: <%=imageTitle%> </br>
	<%=imageLink%> </br>
	
	<img id="imageDisplay" alt="Invalid Link" src= <%=imageLink%> width='400' height='400' >  </br>
	
	
		<legend>Artist</legend>
		ArtistID: <%=artistID%></b></br>
		
		<legend>Detail</legend>
		Year: <%=iYear%>   </br>
		Type: <%=iType%> </br>
		Width: <%=iWidth%> </br>
		Height: <%=iHeight%></br>
		Location: <%=iLocation%></br>
		Description: <%=iDescription%></br>
	
	<div class="innerMenu">
    <ul>
	<li>
	<form action="editImage.jsp" target='rightFrame' method="post">
		<input name="imageID" type="hidden" value= <%=imageID%> >
		<input type="submit" value="Edit"/>
	</form>
	</li>
	
	<li>
		<form action="artistDetails.jsp" target='rightFrame' method="post">
		<input name="artistID" type="hidden" value= <%=artistID%> >
		<input type="submit" value="View Artist"/>
	</form>
	</li>
		
		<li>
	<form action="redirect.jsp"  target="leftFrame" method="post" onsubmit="document.location.href = 'empty.jsp';">
		<input name="funcID" type="hidden" value="9">
		<input name="imageID" type="hidden" value= <%=imageID%> >
    	<input type="submit" value="Delete"/>
	</form>
	</li>
	
	<li>
	</form>
		<form action='galleryDetails.jsp' target='leftFrame' method='post' onsubmit="parent.document.getElementById('rightFrame').contentWindow.document.location.href = 'empty.jsp';">
		<input name='galleryID' type='hidden' value=<%=galleryID%> >
		<input type="submit" value="View Gallery"/>
	</form>
	</li>
	</ul>
	</div>

</body>

</html> 