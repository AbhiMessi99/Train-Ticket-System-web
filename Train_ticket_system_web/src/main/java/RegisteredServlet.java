import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RegisteredServlet
 */
@WebServlet("/RegisteredServlet")
public class RegisteredServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisteredServlet() {
        super();
        // TODO Auto-generated constructor stub
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
		String uid=request.getParameter("RegUsername");
		String pass=request.getParameter("RegPassword");
		String mob=request.getParameter("Mobile");
		String email=request.getParameter("email");
		String address=request.getParameter("address");
		
		out.print(fname+lname+uid+pass+mob+email+address);
		HttpSession hs=request.getSession(true);
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
				PreparedStatement ps1 = con.prepareStatement("SELECT * from USERS WHERE USERNAME=? OR MOBILE=? OR EMAIL=?");
				ps1.setString(1, uid);
				ps1.setString(2, mob);
				ps1.setString(3, email);
				ResultSet rs = ps1.executeQuery();
				if(rs.next())
				{
					rd=getServletContext().getRequestDispatcher("/CannotRegister.html");
				}
				else
				{
					PreparedStatement ps = con.prepareStatement("INSERT INTO USERS VALUES(?,?,?,?,?,?,?)");
					ps.setString(1, uid);
					ps.setString(2, pass);
					ps.setString(3, fname);
					ps.setString(4, lname);
					ps.setString(5, mob);
					ps.setString(6, email);
					ps.setString(7, address);
					int x=ps.executeUpdate();
					rd=getServletContext().getRequestDispatcher("/Registerd.html");
				}
				rd.forward(request, response);	
			}
			con.close();
		}
		catch(Exception e) {out.print(e);}		
	}
}
