<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="guestbook.Stream" %>
<%@ page import="guestbook.OfyService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>

<%@ page import="guestbook.OfyService" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
  <body>
    <table>
<%
		List<Stream> th = OfyService.ofy().load().type(Stream.class).list();
		Collections.sort(th);
		if (th.size() == 0) {
			%>
			<p> You are the First person to try this app.</p>
			<p> Thank you.</p>
			<p> You need to start by creating a stream.</p>
			<p><a href="/CreateStream.html" > Click here to get started. </a></p>
			<%
		} else {
//		System.out.println("ViewAllStreams.jsp: th count = " + th.size());
		for (Stream s : th ) {
		  // APT: calls to System.out.println go to the console,
		  //  calls to out.println go to the html returned to browser
		  // the line below is useful when debugging (jsp or servlet)
		  //System.out.println("ViewAllStreams.jsp: s = " + s);
    %>
		  <tr><td> <img width="100" height="100" src="<%= s.coverImageUrl %>"> </td> 
		  <td><a href="ShowStream.jsp?streamId=<%= s.id %>&streamName=<%= s.name %>"><%= s.name %></a>
		      <p> Started by <%= s.owner %> </p>
		      <p> on <%= s.createDate %>. </p>
		      <p> Has <%=s.imageCount %> pictures <!-- in <%=s.name %> stream. --> </p>
		      </td><tr>

<% }
		}%>
		

    </table>
  </body>
</html>