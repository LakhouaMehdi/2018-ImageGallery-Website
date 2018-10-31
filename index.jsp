<!-- Lakhoua Mehdi
UCI
34592546 -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	
<html>
  <head>
    <title>Image Database</title>
	<link rel="stylesheet" type="text/css" href="style.css">
  </head>
 

 <body>



 <div class="topMenu">
 
 <ul>
  <li><a href="galleries.jsp" target="leftFrame" onclick="document.getElementById('rightFrame').contentWindow.document.location.href = 'empty.jsp';">Galleries</a></li>
  <li><a href="artists.jsp" target="leftFrame" onclick="document.getElementById('rightFrame').contentWindow.document.location.href = 'empty.jsp';">Artists</a></li>
  <li><a href="searchImages.jsp" target="leftFrame" onclick="document.getElementById('rightFrame').contentWindow.document.location.href = 'empty.jsp';">Search</a></li>
</ul>

	
 </div>
 
 <iframe name = "leftFrame" src="galleries.jsp" align="left" style="border:none;height:95%;width:65%;" ></iframe>

 <iframe name = "rightFrame" id="rightFrame" src="empty.jsp" align="right" style="border:none;height:95%;width:34%;" ></iframe>
	

  
  </body>
</html>
