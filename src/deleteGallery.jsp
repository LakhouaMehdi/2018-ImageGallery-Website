<!-- Lakhoua Mehdi
UCI
34592546 -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	
<html>
  <head>
    <title>Delete Gallery</title>
	<link rel="stylesheet" type="text/css" href="style.css">
  </head>
 

 <body>
	<%	
		String galleryID = request.getParameter("galleryID"); 
	%>
	<br><br><br><br><br>
	<div class= "addForm"> 
	<form action="redirect.jsp"  target="leftFrame" method="post" onsubmit="document.location.href = 'empty.jsp';">
		<input name="funcID" type="hidden" value="6">
		<input name="galleryID" type="hidden" value= <%=galleryID%> >
			<b><legend>Delete Gallery</legend></b> <br>
			Confirm by typing any word: <input type="text" required> <br>
    		<input type="submit" value="Delete"/>
	</form>
	</div>
  
 
  </body>
</html>
