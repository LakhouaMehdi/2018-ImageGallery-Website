<!-- Lakhoua Mehdi
UCI
34592546 -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<%@ include file="Database.jsp" %>

<html>
  <head>
    <title>Image Database</title>
	<link rel="stylesheet" type="text/css" href="style.css">
  </head>
  
  <body>
  
	<h1>Galleries</h1>
  
	<%
		//Get connection to the database
		Database db = Database.getDatabase();
	%>

<!-- Display the galleries -->

	<div class= "galleryList">
		<table
		<%
		//Display the galleries
		ResultSet rs = db.getAllGalleries();
			
			if (rs != null) {
				int count = 0;
				out.println("<tr>");
				while( rs.next()){
					out.println("<td>");

					out.println("<legend style='text-align:center;color: black;'>" +rs.getString("name") +"</legend>");
					String urlOfFirst = db.getFirstImageOfGallery(rs.getString("gallery_id"));
					if(urlOfFirst != null) {
						out.println("<img alt='Invalid Link' src='"+ urlOfFirst +"'>" ); }
					else {
						out.println("<img alt='Invalid Link' src='data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw0NDQ0NDQ0NDQ0NDQ0ODQ0NDQ8NDQ0NFREWFhURFhUYHSgiGCYlJxUVITEhJSs3Li4uFx8zODMsNygtLisBCgoKBQUFDgUFDisZExkrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrK//AABEIALcBEwMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAABAUBAwYCB//EADwQAQACAQEEAg4JBQEBAAAAAAABAgMRBAUhMRJRFBUiMkFSYnFykZKiwdETM1Nhc4GCobE0QpPh8LIj/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/APoIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADLAAyMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAkbPseXJ3tJ08aeFfWstn3NEccl5t5NeEesFNETM6REzM8ojjMp2DdWW/fRGOPK5+pb/wDw2eP7Mf8A6n4yhbRvqOWOsz5VuEeoEjZ91YqcbROSfK5epD35s8VmmSsaRMdCYiNIjTl8fUh5NvzWtFpvPczForHCusfdC92mkZ8E6celWLV8/OAcyAAAAAAAAAAAAAAAAAAAAAAAAAA9Y8drTpWs2nqrGqXurDjyZJrkjXudaxrpEzHNdZsuLZ6xrEUieUVrznzQCq2fc+S3G8xSOqO6t8lls+7sOPlXpT41+M/6QNp31adfo6xXyrcZ9S2vlilOnblFYmZiNQato2vocK48t58nHbo+vRW7Rte134RjyY48nHbX16JvbfB129iTtvg67exIKSdmzTOs48szPOZpeZljsXL9lk/x2+S87b4Ou3sSdt8HXb2JBR9i5fssn+O3yXe5pvGOaXrevQnh0qzGtZ8/5s9t8HXb2JO2+Drt7Egrd47FeMtuhS9q27qOjWZiNeccEbsXL9lk/wAdvku+2+Drt7Etmz7fiy26NJmZ0meNZjgDnL47V4Wras9VqzWf3eVpv/v8fo2/lVgAAAAAAAAAAAAAAAAAAAAAA2bPlnHet4/tmJ88eGF/vLFGXBM146RF6THh0jX94c46Dcufp4ujPPHPR/T4Pl+QOenk6Xbv6a/4ai2/B9HkvXwc6+jPL5fkvdu/pr/hg5yImZiIjWZnSIjnMrGNzZejr0qRbxePq1Q9jyRTLjtPKLRr90dbqItExrExMaa6xPDQHJ5KTWZraNJidJjql5St5Za3zXtXlwjXxtI01RQBabl2PpT9LaO5r3kdduv8v+5I+37HamWa0rMxbuqRWJnhPg/IENP3J9d+i3wQbVmszExpMTMTHVKduT679FvgDbv/AL/H6Nv5Va03/wB/j9G38qsAAAAAAAAAAAAAAAAAAAAAABN3Pm6GaInlfuZ8/g/770Ij7uccvOC53/g1rXJH9vc2808v++9L27+mv+G9RptGD8Smk/db/UsbfGmz5I6sYOaZ6U6aazp1azp6mE/dmwfSz0ra/Rx789QIEx+8ax98dbfsWzTmvFY4RztPVV0W0bLjyVitqxpEaV04TXzPOxbJXDWaxOszOs2nhM9QN9KRWIrWNIiIiI6oZAHP76xdHN0vBesT+ccJ+BuT679Fvgn78xdLFF/DS37Tw+SBuT679FvgDbv/AL/H6Nv5Va03/wB/j9G38qsAAAAAAAAAAAAAAAAAAAAAAAAFxuHPwvjnwd3Xzcp+HrTt5fUZfQlz+x5vo8lL+CJ7r0Z4S6S98domJtSYnnE2iYmActTTWOlEzGvGI4TMLeu+aViIjFMREaRETGkQmdj7N4uH3TsfZvFw+6CJ27r9nb2oZ7d1+zt7UJXY+zeLh907H2bxcPugi9u6/Z29qDt3X7O3tQldj7N4uH3TsfZvFw+6CDn3vW9LUnHbuqzHfR1NG5Prv0W+C17H2bxcPuvWOmCk61jFWdNNYmsToCt3/wB/j9G38qtZ79tE3x6TE9zPKYnwqwAAAAAAAAAAAAAAAAAAAAAAAAA0ADQ0ADQ0ADQ0ADQ0AAAAAAAAAAAAABlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB//Z'>" );
					}
					out.println("</br>" + rs.getString("description") + "</br>");		

					out.println("<form action='galleryDetails.jsp' target='leftFrame' method='post' >");
					out.println("<input name='galleryID' type='hidden' value='" + rs.getString("gallery_id") + "'>");
					out.println("<input type='submit' value='Open'/>");
					out.println("</form>");
					out.println("</td>");
					
					count ++;
					if (count%3 == 0) 
					out.println("</tr><tr>");
				}
				out.println("</tr>");
			}
		%>
		</table>
	 </div>
	 
	 
	<div class="innerMenu">
    <ul>
	<li>
	<form action="addGallery.jsp"  target="rightFrame"  method="post">
	<input type="submit" value="Add Gallery" />
	</form> 
	</li>
	</ul>
	</div>

		
  </body>
</html>


