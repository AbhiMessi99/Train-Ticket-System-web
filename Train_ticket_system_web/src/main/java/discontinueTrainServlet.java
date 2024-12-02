import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class discontinueTrainServlet
 */
@WebServlet("/discontinueTrainServlet")
public class discontinueTrainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public discontinueTrainServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out= response.getWriter();
		String Tno=request.getParameter("selectedId");
		
		try
		{
			Class.forName("org.sqlite.JDBC");
			Connection con=DriverManager.getConnection("jdbc:sqlite:C:\\Users\\abhim\\MySQLiteDB");
			if(con==null)
			{
				out.print("Connection not established");
			}
			else
			{
				PreparedStatement ps = con.prepareStatement("delete from trains where train_number = ?");
				ps.setString(1, Tno);
				ps.executeUpdate();
				ps.close();
				
				ps = con.prepareStatement("delete from traintimetable where train_number = ?");
				ps.setString(1, Tno);
				ps.executeUpdate();
				ps.close();
				
				ps = con.prepareStatement("delete from train_fares where train_number = ?");
				ps.setString(1, Tno);
				ps.executeUpdate();
				ps.close();
				
				ps = con.prepareStatement("delete from firstac where train_number = ?");
				ps.setString(1, Tno);
				ps.executeUpdate();
				ps.close();
				
				ps = con.prepareStatement("delete from secondac where train_number = ?");
				ps.setString(1, Tno);
				ps.executeUpdate();
				ps.close();
				
				ps = con.prepareStatement("delete from thirdac where train_number = ?");
				ps.setString(1, Tno);
				ps.executeUpdate();
				ps.close();
				
				ps = con.prepareStatement("delete from sleeper where train_number = ?");
				ps.setString(1, Tno);
				ps.executeUpdate();
				ps.close();
				
				RequestDispatcher rd=getServletContext().getRequestDispatcher("/Traindiscontinued.html");
				rd.forward(request, response);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

}
