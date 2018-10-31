<!-- Lakhoua Mehdi
UCI
34592546 -->

<html>
  <head>
    <title>Add Gallery</title>
	<link rel="stylesheet" type="text/css" href="style.css">
  </head>
 

 <body>
  <br><br><br><br><br>
  
	<div class= "addForm">
	<br><br> 
	<form action="/gallery/redirect.jsp" target="leftFrame" method="post" onsubmit="document.location.href = 'empty.jsp';">
		<input name="funcID" type="hidden" value="2">
		
			<b><legend>Add a gallery</legend></b>
		
			Name: <input name="name" type="text" required> <br>
			Description: <br/> <textarea name="description" rows="5" cols="50" required></textarea> <br>
		
    		<input type="submit" value="Add"/>
		
	</form>
	</div>
  
  </body>
</html>
