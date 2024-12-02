

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class updatePassword
 */
@WebServlet("/updatePassword")
public class updatePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updatePassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out =  response.getWriter();
		String pass=request.getParameter("npword");
		RequestDispatcher rd=null;
		HttpSession hs=request.getSession(true);
		String temp=(String)hs.getAttribute("check");
		ServletContext sc=getServletContext();
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
				PreparedStatement ps = con.prepareStatement("update users set password = ? where mobile=? or email=?");
				ps.setString(1, pass);
				ps.setString(2, temp);
				ps.setString(3, temp);
				int x=ps.executeUpdate();
				if(x>0)
				{
					rd=getServletContext().getRequestDispatcher("/PasswordUpdated.html");
					rd.forward(request, response);
				}
			}
		}
		catch(Exception e) {out.print(e);}
	}
}