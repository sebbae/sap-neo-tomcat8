package neo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet("/service/info")
public class Info extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final Logger LOG = LoggerFactory.getLogger(Info.class);
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		LOG.error("Sample error log entry " + LOG.getName());
		if (!LOG.isDebugEnabled()) {
			LOG.error("DEBUG NOT ENABLED " + LOG.getName());	
		}
		LOG.debug("Sample debug log entry");
		LOG.trace("Sample trace log entry");
		resp.getWriter().println("Hello World!");
	}
}
