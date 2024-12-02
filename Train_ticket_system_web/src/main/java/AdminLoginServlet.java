

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
 * Servlet implementation class AdminLoginServlet
 */
@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out =  response.getWriter();
		response.setContentType("Text/html");
		String uid=request.getParameter("t1");
		String pass=request.getParameter("t2");
		RequestDispatcher rd=null;
		ServletContext sc=getServletContext();
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
				PreparedStatement ps = con.prepareStatement("SELECT * FROM ADMIN WHERE USERNAME=? AND PASSWORD=?");
				ps.setString(1, uid);
				ps.setString(2, pass);
				ResultSet rs=ps.executeQuery();
				if(rs.next())
				{
					rd=sc.getRequestDispatcher("/AdminOption.jsp");
					hs.setAttribute("Username",uid);
					hs.setAttribute("password",pass);
					
				}
				else
				{
					rd=sc.getRequestDispatcher("/wrongAdminSignIn.html");
					
				}
				rd.forward(request, response);
			}
			con.close();
		}
		catch(Exception e) {out.print(e);}
	}

}
