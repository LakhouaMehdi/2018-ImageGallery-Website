<!-- Lakhoua Mehdi
UCI
34592546 -->

<%@ include file="Database.jsp" %>

<html>
  <head>
    <title>Image Database</title>
	<link rel="stylesheet" type="text/css" href="style.css">
  </head>
  
  <body>
  
	<h1>Images</h1>
  
  	<%
		//Get connection to the database
		Database db = Database.getDatabase();
		
		
			String typeFilter = (request == null) ? "Any": request.getParameter("typeFilter");
			String locationFilter = (request == null) ? "Any": request.getParameter("locationFilter");
			String artistFilter = (request == null) ? "Any": request.getParameter("artistFilter");
			String fromYearFilter = (request == null) ? "Any": request.getParameter("fromYearFilter");
			String toYearFilter = (request == null) ? "Any": request.getParameter("toYearFilter");
			
			if(typeFilter == null) typeFilter = "Any";
			if(locationFilter == null || locationFilter == "") locationFilter = "Any";
			if(artistFilter == null) artistFilter = "Any";
			if(fromYearFilter == null || fromYearFilter == "") fromYearFilter = "Any";
			if(toYearFilter== null || toYearFilter == "") toYearFilter = "Any";
		
	%>
	<legend>Filters:</legend>
	Type: <%=typeFilter%>
	<br>
	Location: <%=locationFilter%>
	<br>
	Artist: <%=artistFilter%>
	<br>
	From <%=fromYearFilter%> To <%=toYearFilter%>
	<br><br>
	
	<!-- Display the artists -->
	
		<div class= "imageList">
		<table>
	
		<%
		//Display the images
	 	ResultSet rs = db.getFilteredImages(typeFilter, locationFilter, artistFilter, fromYearFilter, toYearFilter);
		
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
	
	<form action="searchImages.jsp" target="leftFrame" method="post" onsubmit="document.location.href = 'empty.jsp';" >
		Type: 
				<select name="typeFilter">
					<option selected value="Any">Any</option>
					<option value="JPG">JPG</option>
					<option value="PNJ">PNJ</option>
					<option value="GIF">GIF</option>
					<option value="TIF">TIF</option>
					<option value="RAW">RAW</option>
				</select>
				<br> 
		Location:
		<input name="locationFilter" type="text"> <br/> 
		
		Artist:
			<select name="artistFilter" required>
				<option selected value="Any">Any</option>
				<%
				rs = db.getAllArtists();
				if (rs != null) {
					while( rs.next()){
						out.println("<option value="+ rs.getString("artist_id") + " title="+ rs.getString("artist_id") +">" +rs.getString("name")+"</option>)" );
					}
				}	
				%>
			</select>
			<br>
			
		Creation year: <br>
		From 
		<input name="fromYearFilter" type="number" min="0" max=<%=new java.text.SimpleDateFormat("yyyy").format(new java.util.Date())%> >
		To
		<input name="toYearFilter" type="number" min="0" max=<%=new java.text.SimpleDateFormat("yyyy").format(new java.util.Date())%> >
		<br> 
		<input type="submit" value="Search"  />
				 
	</form>
	 
  </body>
</html>
