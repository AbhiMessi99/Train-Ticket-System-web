

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
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
 * Servlet implementation class cancellationServlet
 */
@WebServlet("/cancellationServlet")
public class cancellationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cancellationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		HttpSession hs=request.getSession();
		int cancel_id=Integer.parseInt((String)hs.getAttribute("cancel_id"));
		RequestDispatcher rd=null;
		ServletContext sc=getServletContext();
		try
		{
			Class.forName("org.sqlite.JDBC");
        	Connection con=DriverManager.getConnection("jdbc:sqlite:C:\\Users\\abhim\\MySQLiteDB");
			if(con==null)
			{
				out.println("Connection error");
			}
			else
			{
				PreparedStatement ps = con.prepareStatement("select PASSENGERS, CLASS, NEW_DATE, TRAIN_NUMBER from bookingdetails where book_id = ?");
				ps.setInt(1, cancel_id);
				ResultSet rs = ps.executeQuery();
				
				
				ps = con.prepareStatement("DELETE FROM BOOKINGDETAILS where Book_id = ?");
				ps.setInt(1, cancel_id);
				ps.executeUpdate();
				
				
				ps = con.prepareStatement("DELETE FROM trainpassengerdetails where PNR = ?");
				ps.setInt(1, cancel_id);
				ps.executeUpdate();
				
				
				String updateSQL = "UPDATE " + rs.getString(2) + " SET "+rs.getString(3)+" = "+rs.getString(3)+" + ? WHERE train_number = ?";
                PreparedStatement psUpdate = con.prepareStatement(updateSQL);
                psUpdate.setInt(1, rs.getInt(1));
                psUpdate.setString(2, rs.getString(4));
                int x = psUpdate.executeUpdate();
				
				out.print(updateSQL+" ");
			    rd=sc.getRequestDispatcher("/cancelRedirect.html");
				rd.forward(request, response);
				con.close();
			}
		}
		catch(Exception e)
		{
			out.print(e);
		}
	}

}
