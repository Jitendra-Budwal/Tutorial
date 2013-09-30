<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="guestbook.Stream" %>
<%@ page import="guestbook.Transactions" %>
<%@ page import="guestbook.ConnexusImage" %>
<%@ page import="guestbook.OfyService" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Collections" %>

<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
  <body>
  <%@ include file="/header.html" %>
    <table>
<%
		List<Stream> th = OfyService.ofy().load().type(Stream.class).list();

		if (th.size() == 0) {
			%>
			<p> You are the First person to try this app.</p>
			<p> Thank you.</p>
			<p> You need to start by creating a stream.</p>
			<p><a href="/CreateStream.html" > Click here to get started. </a></p>
			<%
		} else {
		for (Stream s : th ) {
   
   	Calendar cal = Calendar.getInstance();
	cal.setTime(new Date());
		
	cal.add(Calendar.SECOND, -900);
	Date timeWindow = cal.getTime();
    long views = OfyService.ofy().load().type(Transactions.class).filter("stream ==", s.getKey()).filter("transactionTime >=", timeWindow).count();
    %>
		  <tr><td> <img width="100" height="100" src="<%= s.coverImageUrl %>"> </td> 
		  <td><a href="ShowStream.jsp?streamId=<%= s.id %>&streamName=<%= s.name %>"><%= s.name %></a>
		      <p> Started by <b><%= s.owner %></b> </p>
		      <p> Viewed <%= views %> times in last 15 mins.</p>
		      </td><tr>

<% }
		}%>
		

    </table>
  </body>
</html>