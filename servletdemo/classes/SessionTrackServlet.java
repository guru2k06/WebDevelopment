import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/sessionTrack")
public class SessionTrackServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        Date createTime = new Date(session.getCreationTime());
        Date lastAccess = new Date(session.getLastAccessedTime());

        String title = "Welcome Back";
        Integer visitCount = (Integer) session.getAttribute("visitCount");
        String userID = (String) session.getAttribute("userID");

        if (session.isNew()) {
            title = "Welcome";
            userID = "User123";
            visitCount = 1;
            session.setAttribute("userID", userID);
        } else {
            visitCount = (visitCount != null ? visitCount + 1 : 1);
        }
        session.setAttribute("visitCount", visitCount);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><head><title>" + title + "</title></head>");
        out.println("<body><h1>" + title + "</h1>");
        out.println("<table border='1'>");
        out.println("<tr><td>ID</td><td>" + session.getId() + "</td></tr>");
        out.println("<tr><td>Created</td><td>" + createTime + "</td></tr>");
        out.println("<tr><td>Last Access</td><td>" + lastAccess + "</td></tr>");
        out.println("<tr><td>User ID</td><td>" + userID + "</td></tr>");
        out.println("<tr><td>Visits</td><td>" + visitCount + "</td></tr>");
        out.println("</table></body></html>");
    }
}
