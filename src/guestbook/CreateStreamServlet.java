package guestbook;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import static com.googlecode.objectify.ObjectifyService.ofy;

// Backs up CreateStream.html form submission. Trivial since there's no image uploaded, just a URL
@SuppressWarnings("serial")
public class CreateStreamServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
	    UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    Long imageCount = new Long(0);
		Stream s = new Stream(req.getParameter("streamName"),
				req.getParameter("tags"), req.getParameter("url"), user.toString(), imageCount);
		// persist to datastore
		ofy().save().entity(s).now();
		resp.sendRedirect("/ViewAllStreams.jsp");
	}
}