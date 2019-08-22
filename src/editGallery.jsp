<!-- Lakhoua Mehdi
UCI
34592546 -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="Database.jsp" %>	
<html>
  <head>
    <title>Edit Gallery</title>
	<link rel="stylesheet" type="text/css" href="style.css">
  </head>
 

 <body>
	<%	//get connection to the database
		Database db = Database.getDatabase();
		String galleryID = request.getParameter("galleryID"); 
	%>
	<br><br><br><br><br>
	<div class= "addForm">
	<form action="/gallery/redirect.jsp"  target="leftFrame" method="post" onsubmit="document.location.href = 'empty.jsp';" >
		<input name="funcID" type="hidden" value="5">
		<input name="galleryID" type="hidden" value= <%=galleryID%> >
			<b><legend>Edit Gallery</legend></b>
			Name: <input name="name" type="text" value= <%=db.getNameOfGallery(galleryID)%> required>  <br>
			Description: <br/> <textarea name="description" rows="5" cols="50" required><%=db.getDescriptionOfGallery(galleryID)%></textarea> <br>
    		<input type="submit" value="Edit"/>
	</form>
    </div>
	
  </body>
</html>
