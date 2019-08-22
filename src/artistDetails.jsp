<!-- Lakhoua Mehdi
UCI
34592546 -->

<!DOCTYPE html>

<%@ include file="Database.jsp" %>

<html>

<head>
	<title>Artist Details</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
	<br><br><br><br><br>
	<%
		//get connection to the database
		Database db = Database.getDatabase();
		String artistID = request.getParameter("artistID");
	%>
	
		<legend>Artist</legend>
		ID: <%=artistID%></br>
		Name: <%=db.getNameOfArtist(artistID)%></br>
		Birth Year: <%=db.getBirthYearOfArtist(artistID)%></br>
		Country: <%=db.getCountryOfArtist(artistID)%></br>
		Description: <%=db.getDescriptionOfArtist(artistID)%></br>

</body>

</html> 
