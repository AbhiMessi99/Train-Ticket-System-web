

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
 * Servlet implementation class forgetPassword
 */
@WebServlet("/forgetPassword")
public class forgetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public forgetPassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		String temp=request.getParameter("checkdata");
		HttpSession hs=request.getSession(true);
		hs.setAttribute("check", temp);
		RequestDispatcher rd= null;
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
				PreparedStatement ps1 = con.prepareStatement("SELECT * from USERS WHERE MOBILE=? OR EMAIL=?");
				ps1.setString(1, temp);
				ps1.setString(2, temp);
				ResultSet rs = ps1.executeQuery();
				if(rs.next())
				{
					rd=getServletContext().getRequestDispatcher("/newPassword.html");
				}
				else
				{
					rd=getServletContext().getRequestDispatcher("/didnotFind.html");
				}
				rd.forward(request, response);	
			}
			rd.forward(request, response);
		}
		catch(Exception e) {out.print(e);}
		
	}

}
