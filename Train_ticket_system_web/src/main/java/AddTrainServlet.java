

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
 * Servlet implementation class AddTrainServlet
 */
@WebServlet("/AddTrainServlet")
public class AddTrainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTrainServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		ServletContext sc=getServletContext();
		RequestDispatcher rd=null;
		String tno=request.getParameter("Train_number");
		String tname=request.getParameter("Train_Name");
		String source=request.getParameter("source");
		String destination=request.getParameter("destination");
		
		String departure=request.getParameter("departure");
		String landing=request.getParameter("arrival");
		String jtime=request.getParameter("duration");
		
		String sleeper=request.getParameter("sleeper");
		String ac3=request.getParameter("ac3tier");
		String ac2=request.getParameter("ac2tier");
		String ac1=request.getParameter("ac1tier");
		
		
		String sleeperSeats=request.getParameter("sleeperseat");
		String ac3Seats=request.getParameter("ac3tierseat");
		String ac2Seat=request.getParameter("ac2tierseat");
		String ac1Seat=request.getParameter("ac1tierseat");
		
		try
		{
			Class.forName("org.sqlite.JDBC");
        	Connection con=DriverManager.getConnection("jdbc:sqlite:C:\\Users\\abhim\\MySQLiteDB");
			if(con==null)
			{
				out.println("Connection not established");
			}	
			else
			{
				
				PreparedStatement ps=con.prepareStatement("SELECT * FROM TrainS where Train_NUMBER=?");
				ps.setString(1, tno.toUpperCase());
				ResultSet rs=ps.executeQuery();
				if(rs.next())
				{
					rd=sc.getRequestDispatcher("/cannotaddTrain.html");
					rd.forward(request, response);
				}
				else
				{
					ps=con.prepareStatement("INSERT INTO Trains VALUES(?,?,?,?)");
					ps.setString(1, tno.toUpperCase());
					ps.setString(2, tname);
					ps.setString(3, source.toUpperCase());
					ps.setString(4, destination.toUpperCase());
					int x=ps.executeUpdate();
					
					ps=con.prepareStatement("INSERT INTO Traintimetable VALUES(?,?,?,?)");
					ps.setString(1, tno.toUpperCase());
					ps.setString(2, departure);
					ps.setString(3, landing);
					ps.setString(4, jtime);
					x=ps.executeUpdate();
					
					ps=con.prepareStatement("INSERT INTO Train_fares VALUES(?,?,?,?,?)");
					ps.setString(1, tno.toUpperCase());
					ps.setString(2, sleeper);
					ps.setString(3, ac3);
					ps.setString(4, ac2);
					ps.setString(5, ac1);
					x=ps.executeUpdate();
					
					ps=con.prepareStatement("INSERT INTO sleeper VALUES(?,?,?,?,?,?,?,?,?,?,?)");
					ps.setString(1, tno.toUpperCase());
					ps.setString(2, sleeperSeats);
					ps.setString(3, sleeperSeats);
					ps.setString(4, sleeperSeats);
					ps.setString(5, sleeperSeats);
					ps.setString(6, sleeperSeats);
					ps.setString(7, sleeperSeats);
					ps.setString(8, sleeperSeats);
					ps.setString(9, sleeperSeats);
					ps.setString(10, sleeperSeats);
					ps.setString(11, sleeperSeats);
					x=ps.executeUpdate();
					
					ps=con.prepareStatement("INSERT INTO thirdac VALUES(?,?,?,?,?,?,?,?,?,?,?)");
					ps.setString(1, tno.toUpperCase());
					ps.setString(2, ac3Seats);
					ps.setString(3, ac3Seats);
					ps.setString(4, ac3Seats);
					ps.setString(5, ac3Seats);
					ps.setString(6, ac3Seats);
					ps.setString(7, ac3Seats);
					ps.setString(8, ac3Seats);
					ps.setString(9, ac3Seats);
					ps.setString(10, ac3Seats);
					ps.setString(11, ac3Seats);
					x=ps.executeUpdate();
					
					ps=con.prepareStatement("INSERT INTO secondac VALUES(?,?,?,?,?,?,?,?,?,?,?)");
					ps.setString(1, tno.toUpperCase());
					ps.setString(2, ac2Seat);
					ps.setString(3, ac2Seat);
					ps.setString(4, ac2Seat);
					ps.setString(5, ac2Seat);
					ps.setString(6, ac2Seat);
					ps.setString(7, ac2Seat);
					ps.setString(8, ac2Seat);
					ps.setString(9, ac2Seat);
					ps.setString(10, ac2Seat);
					ps.setString(11, ac2Seat);
					x=ps.executeUpdate();
					
					ps=con.prepareStatement("INSERT INTO firstac VALUES(?,?,?,?,?,?,?,?,?,?,?)");
					ps.setString(1, tno.toUpperCase());
					ps.setString(2, ac1Seat);
					ps.setString(3, ac1Seat);
					ps.setString(4, ac1Seat);
					ps.setString(5, ac1Seat);
					ps.setString(6, ac1Seat);
					ps.setString(7, ac1Seat);
					ps.setString(8, ac1Seat);
					ps.setString(9, ac1Seat);
					ps.setString(10, ac1Seat);
					ps.setString(11, ac1Seat);
					x=ps.executeUpdate();
					
					rd=sc.getRequestDispatcher("/added.html");
					rd.forward(request, response);
				}
			}
		}
		catch(Exception e) {e.printStackTrace();}
	}

}
