import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ExtractDetails for Train Details
 */
@WebServlet("/ExtractDetails")
public class ExtractDetails extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExtractDetails() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        String selectedId = request.getParameter("selectedId");
        RequestDispatcher rd = null;
        ServletContext sc = getServletContext();
        HttpSession hs = request.getSession(true);
        
        try {
        	Class.forName("org.sqlite.JDBC");
        	Connection con=DriverManager.getConnection("jdbc:sqlite:C:\\Users\\abhim\\MySQLiteDB");
            if (con == null) {
                out.println("Connection not built");
            } else {
                
                PreparedStatement ps = con.prepareStatement("SELECT * FROM trains WHERE train_number = ?");
                
                PreparedStatement ps1 = con.prepareStatement("SELECT * FROM traintimetable WHERE train_number = ?");
                // Query to fetch fare details from the "train_fares" table
                PreparedStatement ps2 = con.prepareStatement("SELECT * FROM train_fares WHERE train_number = ?");
                // Query to fetch specific class fare from the appropriate class table (e.g., SLEEPER, THIRDAC, etc.)

                ps.setString(1, selectedId);
                ps1.setString(1, selectedId);
                ps2.setString(1, selectedId);
                
                
                ResultSet rs = ps.executeQuery();
                ResultSet rs1 = ps1.executeQuery();
                ResultSet rs2 = ps2.executeQuery();
              
                
                String CLASS = (String) hs.getAttribute("cl");
                
                
                if (rs.next()) {
                    hs.setAttribute("trainNumber", selectedId);                    
                    hs.setAttribute("trainName", rs.getString("train_name"));
                    hs.setAttribute("source", rs.getString("source"));
                    hs.setAttribute("destination", rs.getString("destination"));
                }
                if (rs1.next()) {
                    hs.setAttribute("departure", rs1.getString("arrival_time"));
                    hs.setAttribute("arrival", rs1.getString("departure_time"));
                    hs.setAttribute("journeyTime", rs1.getString("journey_time"));
                }
                if (rs2.next()) {
                    hs.setAttribute("fare", rs2.getString(CLASS)); 
                }
                out.print(rs2.getString(CLASS));
                out.print((String)hs.getAttribute("fareType"));
                con.close();
                rd = sc.getRequestDispatcher("/TrainDetails.jsp");
                rd.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
