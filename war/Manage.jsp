<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="guestbook.Stream" %>
<%@ page import="guestbook.OfyService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>

<%@ page import="guestbook.OfyService" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
  <body>
  <%@ include file="/header.html" %>
    <table>
<%
		List<Stream> th = OfyService.ofy().load().type(Stream.class).list();
		Collections.sort(th);
//		System.out.println("ViewAllStreams.jsp: th count = " + th.size());
		if (th.size() == 0) {
			%>
			<p> You are the First person to try this app.</p>
			<p> Thank you.</p>
			<p> You need to start by creating a stream.</p>
			<p><a href="/CreateStream.html" > Click here to get started. </a></p>
			<%
		} else {
		for (Stream s : th ) {
		  // APT: calls to System.out.println go to the console,
		  //  calls to out.println go to the html returned to browser
		  // the line below is useful when debugging (jsp or servlet)
		  //System.out.println("ViewAllStreams.jsp: s = " + s);
    %>
		  <tr><td> <img width="100" height="100" src="<%= s.coverImageUrl %>"> </td> 
		  <td><a href="ShowStream.jsp?streamId=<%= s.id %>&streamName=<%= s.name %>"><%= s.name %></a>
		      <p> Started by <b><%= s.owner %></b> </p>
		      <p> on <i><%=s.createDate%></i>, </p>
		      <p> last update <i><%=s.changeDate %>. </i></p>
		      <p> Has <%=s.imageCount %> pictures, viewed <%= s.viewCount %> </p>
		      </td><tr>

<% }
		}%>
		

    </table>
  </body>
</html>