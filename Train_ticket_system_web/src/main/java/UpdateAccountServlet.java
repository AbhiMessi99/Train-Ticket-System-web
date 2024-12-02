

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UpdateAccountServlet
 */
@WebServlet("/UpdateAccountServlet")
public class UpdateAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateAccountServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		RequestDispatcher rd=null;
		String fname=request.getParameter("fname");
		String lname=request.getParameter("Lname");
		String mob=request.getParameter("Mobile");
		String email=request.getParameter("email");
		String address=request.getParameter("address");
		HttpSession hs=request.getSession(true);
		String uid = (String)hs.getAttribute("Username");
		try
		{
			Class.forName("org.sqlite.JDBC");
			Connection con=DriverManager.getConnection("jdbc:sqlite:C:\\Users\\abhim\\MySQLiteDB");
			if(con==null)
			{
				out.println("Connection not built");
			}
			else
			{
				PreparedStatement ps = con.prepareStatement("UPDATE USERS SET FIRSTNAME = ?, LASTNAME = ?, ADDRESS =? where USERNAME = ?");
				ps.setString(1, fname);
				ps.setString(2, lname);
				ps.setString(3, address);
				ps.setString(4, uid);
				int x=ps.executeUpdate();
				rd=getServletContext().getRequestDispatcher("/accountUpdated.html");
			}
			rd.forward(request, response);	
			con.close();
		}
		catch(Exception e) {out.print(e);}		
	}
}
