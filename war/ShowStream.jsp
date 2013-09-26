<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="guestbook.Stream" %>
<%@ page import="guestbook.ConnexusImage" %>
<%@ page import="guestbook.OfyService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>

<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
  <body>
    
<%
		BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
//System.out.println("streamId = " + request.getParameter("streamId"));
		Long streamId = new Long(request.getParameter("streamId"));
//		System.out.println("streamId = " + streamId);
		String streamName = request.getParameter("streamName");
//		System.out.println("streamName = " + streamName);
		out.println(streamName);
		List<ConnexusImage> images = OfyService.ofy().load().type(ConnexusImage.class).list();
		System.out.println("ShowStream.jsp: images count = " + images.size());
		Collections.sort(images);
		for ( ConnexusImage img : images ) {
		    if ( img.streamId.equals(streamId) ) {
		    	
		    	
		    	out.println("<a href=\""+img.bkUrl+"\"><img src=\"" + img.bkUrl +"=s100\"></a>"); // better to not use println for html output, use templating instead
     		}
		    System.out.println("ShowStream.jsp: streamId = " + img.streamId + " ; " + streamId);
     	 }
%>

<!-- APT: note how we are adding additional parameters when we create the uploadurl - this way blobstore service
     can pass them on to the upload servlet, so upload knows which stream the image blob corresponds to -->

	<form action="<%= blobstoreService.createUploadUrl("/upload?streamId=" 
			+ streamId + "&streamName=" + streamName) %>" 
			method = "post" enctype="multipart/form-data">
	     <input type="file" name="myFile"><br> <input type="submit" value="Submit">
   </form>
   <h2>Add an image</h2>
		
  </body>
</html>