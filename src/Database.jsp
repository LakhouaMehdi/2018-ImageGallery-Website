<!-- Lakhoua Mehdi
UCI
34592546 -->

<!-- Import libraries -->

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.Exception"%>


<%!
static class Database {
	
	//Singleton
	private static Database db = null;
	
	//Database variables
	private Connection con;
	private Statement stmt;
	private ResultSet rs;
	private PreparedStatement pstmt;
	
	private Database() {
		loadSQLDriver ();
		connect();
	}
	
	public static synchronized Database getDatabase()
	{
		if (db == null) {
			db = new Database();
		}
		return db;
	
	}
	//Loads the SQL driver
	private void loadSQLDriver ()
	{
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		}
		catch(Exception e) {
			System.out.println("can't load mysql driver");
			System.out.println(e.toString());
			System.exit(1);
		}
	}
	
	//Connects to the database
	private void connect ()
	{
	    String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs118";
	
		try {
			con= DriverManager.getConnection(url,id,pwd); 
		}
		catch(Exception e) {
			System.out.println("can't connect to database");
			System.out.println(e.toString());
			System.exit(1);	
		}
	}
	
	//Returns all galleries
	public ResultSet getAllGalleries()
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM gallery";
			rs = stmt.executeQuery(sql);
			return rs;
		}
		catch(Exception e) {
			System.out.println("Failed galleries query");
			System.out.println(e.toString());
			return null;
		}
	}
	
	//Returns all artists
	public ResultSet getAllArtists()
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM artist";
			rs = stmt.executeQuery(sql);
			return rs;
		}
		catch(Exception e) {
			System.out.println("Failed artists query");
			System.out.println(e.toString());
			return null;
		}
	}
	
	//Returns all images
	public ResultSet getAllImages()
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM image";
			rs = stmt.executeQuery(sql);
			return rs;
		}
		catch(Exception e) {
			System.out.println("Failed images query");
			System.out.println(e.toString());
			return null;
		}
	}
	
	//get all images that satisfy the criteria
	public ResultSet getFilteredImages(String typeFilter, String locationFilter, String artistFilter, String fromYearFilter, String toYearFilter)
	{
		String sql = "SELECT * FROM image,detail,artist WHERE image.image_id = detail.image_id AND image.artist_id = artist.artist_id";
	
		if(artistFilter != null && !artistFilter.equals("Any") )
		{
			sql += " AND image.artist_id = '" + artistFilter + "'";
		}
		
		if(typeFilter != null && !typeFilter.equals("Any") )
		{
			sql += " AND type = '" + typeFilter +"'";
		}
		
		if(locationFilter != null && !locationFilter.equals("Any") )
		{
			sql += " AND location = '" + locationFilter +"'";
		}
		
		if(fromYearFilter != null && !fromYearFilter.equals("Any") )
		{
			sql += " AND year >= '" + fromYearFilter +"'";
		}
	
		if(toYearFilter != null && !toYearFilter.equals("Any") )
		{
			sql += " AND year <= '" + toYearFilter +"'";
		}
	
		try {
			rs = stmt.executeQuery(sql);
			return rs;
		}
		catch(Exception e) {
			System.out.println("Failed image filtering query");
			System.out.println(e.toString());
			return null;
		}
		
	}
	
	//returns all the images for the gallery
	public ResultSet getImagesOfGallery( String gID )
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM image WHERE gallery_id = " + gID;
			rs = stmt.executeQuery(sql);
			return rs;
		}
		catch(Exception e) {
			System.out.println("No image in gallery");
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the number of images in the gallery
	public int getNumberOfImagesInGallery ( String gID )
	{
			int count=0;
			try {
				stmt = con.createStatement();
				String sql = "SELECT * FROM image WHERE gallery_id = " + gID;
				rs = stmt.executeQuery(sql);
				if (rs != null) {
					while(rs.next())
					{
						count++;
					}
				}
			}
			catch(Exception e) {
				System.out.println("No image in gallery");
				System.out.println(e.toString());
				return 0;
			}
		
			return count;
		
	}
	
	
	//returns the name of the gallery with the given id
	public String getNameOfGallery( String gID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT name FROM gallery WHERE gallery_id = " + gID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("name");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println("Gallery doesn't exist");
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the description of the gallery with the given id
	public String getDescriptionOfGallery( String gID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT description FROM gallery WHERE gallery_id = " + gID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("description");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println("Gallery doesn't exist");
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the title of the image with the given id
	public String getTitleOfImage(String iID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT title FROM image WHERE image_id = " + iID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("title");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}

	//returns the link of the image with the given id
	public String getLinkOfImage(String iID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT link FROM image WHERE image_id = "+ iID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("link");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the gallery id of the image with the given id
	public String getGalleryIDOfImage(String iID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT gallery_id FROM image WHERE image_id = "+ iID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("gallery_id");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the artist id of the image with the given id
	public String getArtistIDOfImage(String iID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT artist_id FROM image WHERE image_id = "+ iID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("artist_id");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the detail id of the image with the given id
	public String getDetailIDOfImage(String iID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT detail_id FROM image WHERE image_id = "+ iID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("detail_id");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the year of the detail with the given id
	public String getYearOfDetail(String dID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT year FROM detail WHERE detail_id = "+ dID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("year");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the type of the detail with the given id
	public String getTypeOfDetail(String dID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT type FROM detail WHERE detail_id = "+ dID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("type");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}

	//returns the width of the detail with the given id
	public String getWidthOfDetail(String dID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT width FROM detail WHERE detail_id = "+ dID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("width");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the height of the detail with the given id
	public String getHeightOfDetail(String dID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT height FROM detail WHERE detail_id = "+ dID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("height");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the location of the detail with the given id
	public String getLocationOfDetail(String dID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT location FROM detail WHERE detail_id = "+ dID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("location");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the description of the detail with the given id
	public String getDescriptionOfDetail(String dID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT description FROM detail WHERE detail_id = "+ dID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("description");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the name of the artist with the given id
	public String getNameOfArtist(String aID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT name FROM artist WHERE artist_id = "+ aID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("name");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the birth year of the artist with the given id
	public String getBirthYearOfArtist(String aID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT birth_year FROM artist WHERE artist_id = "+ aID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("birth_year");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the country of the artist with the given id
	public String getCountryOfArtist(String aID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT country FROM artist WHERE artist_id = "+ aID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("country");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//returns the description of the artist with the given id
	public String getDescriptionOfArtist(String aID)
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT description FROM artist WHERE artist_id = "+ aID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("description");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
	//Modify name and description of the gallery with the given id
	public void editGalleryByID(String gID, String name, String description)
	{
		try {
			pstmt = con.prepareStatement("UPDATE gallery SET name=?, description=? WHERE gallery_id=?",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, name);
			pstmt.setString(2, description);
			pstmt.setString(3, gID);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
		}
		catch(Exception e) {
			System.out.println("Failed editing a gallery");
			System.out.println(e.toString());
		}
	}
	//Modify artist with the given id
	public void editArtistByID(String artistID, String artistName, String artistBirthYear, String artistCountry, String artistDescription)
	{
		try {
			pstmt = con.prepareStatement("UPDATE artist SET name=?, birth_year=?, country=?, description=? WHERE artist_id=?",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, artistName);
			pstmt.setString(2, artistBirthYear);
			pstmt.setString(3, artistCountry);
			pstmt.setString(4, artistDescription);
			pstmt.setString(5, artistID);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
		}
		catch(Exception e) {
			System.out.println("Failed editing an artist");
			System.out.println(e.toString());
		}	
	}

	//Delete the gallery with the given id
	public void deleteGalleryByID(String gID)
	{
		
		//delete the gallery
		try {
			pstmt = con.prepareStatement("DELETE FROM gallery WHERE gallery_id=?",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, gID);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
		}
		catch(Exception e) {
			System.out.println("Failed deleting galleries");
			System.out.println(e.toString());
		}
		
		//delete every image in the gallery
		try {
			stmt = con.createStatement();
			String sql = "SELECT image_id FROM image WHERE gallery_id="+ gID;
			ResultSet rs1 = stmt.executeQuery(sql);
			while(rs1.next())
			{
				System.out.println("need to delete image id " + rs1.getString("image_id") + "/n");
				deleteImageByID(rs1.getString(1));
			}
		}
		catch(Exception e) {
			System.out.println("Failed deleting gallery images");
			System.out.println(e.toString());
		}
	
	}
	
	//Delete the image with the given id
	public void deleteImageByID(String iID)
	{  	
		//delete the image
		try {
			pstmt = con.prepareStatement("DELETE FROM image WHERE image_id=?",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, iID);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
		}
		catch(Exception e) {
			System.out.println("Failed deleting image");
			System.out.println(e.toString());
		}
		
		//delete the details of the image
		try {
			pstmt = con.prepareStatement("DELETE FROM detail WHERE image_id=?",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, iID);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
		}
		catch(Exception e) {
			System.out.println("Failed deleting image");
			System.out.println(e.toString());
		}
	
	}
	
	//returns the link of the first image in this gallery that is found
	//returns null if none is found
	public String getFirstImageOfGallery( String gID )
	{
		try {
			stmt = con.createStatement();
			String sql = "SELECT link FROM image WHERE gallery_id = " + gID;
			rs = stmt.executeQuery(sql);
			if (rs.next())
			return rs.getString("link");
			else 
			return null;
		}
		catch(Exception e) {
			System.out.println("No image in gallery");
			System.out.println(e.toString());
			return null;
		}
	}
	
	
	//Adds a new gallery tuple
	public void addAGallery( String galleryName, String galleryDescription )
	{
		try {
			pstmt = con.prepareStatement("insert into gallery values (default,?,?)",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, galleryName);
			pstmt.setString(2, galleryDescription);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
			while (rs.next()) {
			System.out.println("Successfully added. Gallery_ID:"+rs.getInt(1));
			}
		}
		catch(Exception e) {
			System.out.println("Failed adding a gallery");
			System.out.println(e.toString());
		}
	}
	
	//adds an image tuple with null detail_id
	private String addImageTuple(String galleryID, String title, String link, String artistID)
	{
		//create the image
		String imageID = null;
		try {
			pstmt = con.prepareStatement("insert into image values (default,?,?,?,?,null)",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, title);
			pstmt.setString(2, link);
			pstmt.setString(3, galleryID);
			pstmt.setString(4, artistID);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
			
			//get the id for the image
			while (rs.next()) {
				System.out.println("Successfully added. Image_ID:"+rs.getInt(1));
				imageID = rs.getString(1);
			}
		}
		catch(Exception e) {
			System.out.println("Failed adding image to the gallery");
			System.out.println(e.toString());
		}
		finally{
			return imageID;
		}
	}
	
	//adds a detail tuple with null image_id
	private String addDetailTuple(String iYear,String iType,String iWidth,String iHeight,String iLocation,String iDescription){
			//create the details of the image
		String detailID = null;
		try {
			pstmt = con.prepareStatement("insert into detail values (default, null ,?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, iYear);
			pstmt.setString(2, iType);
			pstmt.setString(3, iWidth);
			pstmt.setString(4, iHeight);
			pstmt.setString(5, iLocation);
			pstmt.setString(6, iDescription);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
			while (rs.next()) {
				System.out.println("Successfully added. Detail_ID:"+rs.getInt(1));
				detailID = rs.getString(1);
			}
		}
		catch(Exception e) {
			System.out.println("Failed adding details to image");
			System.out.println(e.toString());
		}
		finally{
			return detailID;
		}
	}
	
	//update the detail_id of the image and the image_id of the detail
	private void linkDetailToImage(String imageID, String detailID)
	{
		try {
			pstmt = con.prepareStatement("UPDATE image SET detail_id=? WHERE image_id=?",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, detailID);
			pstmt.setString(2, imageID);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
		}
		catch(Exception e) {
			System.out.println("image not updated with detail id");
			System.out.println(e.toString());
		}
		
		try {
			pstmt = con.prepareStatement("UPDATE detail SET image_id=? WHERE detail_id=?",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, imageID);
			pstmt.setString(2, detailID);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
		}
		catch(Exception e) {
			System.out.println("detail not updated with image id");
			System.out.println(e.toString());
		}
		
		
	}
	//adds an image tuple and creates the details for the image
	public void addImageToGallery(String galleryID, String title, String link, String artistID, String iYear, String iType, String iWidth, String iHeight, String iLocation, String iDescription)
	{
		//create the image tuple
		String imageID = addImageTuple(galleryID, title, link, artistID);
		//create the details tuple
		String detailID = addDetailTuple(iYear,iType,iWidth,iHeight,iLocation,iDescription);
		//update the detail_id of the image and image_id of the detail
		linkDetailToImage(imageID,detailID);
		
	}
	
	//edits the image and details of the image with the new data
	public void editImageByID(String imageID,String title,String link, String artistID, String iYear, String iType, String iWidth, String iHeight, String iLocation, String iDescription)
	{
		try {
			pstmt = con.prepareStatement("UPDATE image SET title=?, link=?, artist_id=? WHERE image_id=?",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, title);
			pstmt.setString(2, link);
			pstmt.setString(3, artistID);
			pstmt.setString(4, imageID);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
		}
		catch(Exception e) {
			System.out.println("image editing failed");
			System.out.println(e.toString());
		}
		String detailID = getDetailIDOfImage(imageID);
		editDetailByID( detailID, iYear, iType, iWidth, iHeight, iLocation, iDescription);
	}
	
	//edits the image and details of the image with the new data
	private void editDetailByID(String detailID,String iYear, String iType, String iWidth, String iHeight, String iLocation, String iDescription)
	{
		try {
			pstmt = con.prepareStatement("UPDATE detail SET year=?, type=?, width=?, height=?, location=?, description=? WHERE detail_id=?",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, iYear);
			pstmt.setString(2, iType);
			pstmt.setString(3, iWidth);
			pstmt.setString(4, iHeight);
			pstmt.setString(5, iLocation);
			pstmt.setString(6, iDescription);
			pstmt.setString(7, detailID);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
		}
		catch(Exception e) {
			System.out.println("detail editing failed");
			System.out.println(e.toString());
		}
	}
	
	//Adds a new artist tuple
	public void addAnArtist( String artistName, String artistBirthYear, String artistCountry, String artistDescription )
	{
		try {
			pstmt = con.prepareStatement("insert into artist values (default,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, artistName);
			pstmt.setString(2, artistBirthYear);
			pstmt.setString(3, artistCountry);
			pstmt.setString(4, artistDescription);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
			while (rs.next()) {
			System.out.println("Successfully added. Artist_ID:"+rs.getInt(1));
			}
		}
		catch(Exception e) {
			System.out.println("Failed adding an artist");
			System.out.println(e.toString());
		}
	}
	
}
%>	
