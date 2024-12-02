import java.sql.Statement;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class BookingServlet
 */
@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookingServlet() {
        super();
    }

    /**
     * Handles POST request for booking train tickets
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        ServletContext sc = getServletContext();

        try {
            // Load JDBC driver and establish connection
        	Class.forName("org.sqlite.JDBC");
        	Connection con=DriverManager.getConnection("jdbc:sqlite:C:\\Users\\abhim\\MySQLiteDB");
        	
            if (con == null) {
                out.println("Connection not established.");
            } else {
                // Fetch session attributes
                String username = (String) session.getAttribute("Username");
                int passengerNum = (Integer) session.getAttribute("pass_num");
                String trainNumber = (String) session.getAttribute("trainNumber");
                String trainName = (String) session.getAttribute("trainName");
                String source = (String) session.getAttribute("source");
                String destination = (String) session.getAttribute("destination");
                String travelClass = (String) session.getAttribute("cl");
                String departureTime = (String) session.getAttribute("arrival");
                String originalDate = (String) session.getAttribute("yyyy_mm_dd");
                String newDate = (String) session.getAttribute("date");
                String paymentMethod = request.getParameter("paymentMethod");
                String fareType = (String) session.getAttribute("fareType");
                
                int totalAmount = (Integer) session.getAttribute("paid");

                
                String sql = "INSERT INTO BookingDetails (USERNAME, PASSENGERS, TRAIN_NUMBER, TRAIN_NAME, CLASS, " +
                        "SOURCE, DESTINATION, BOARDINGTIME, JOURNEY_DATE, NEW_DATE, AMOUNT, METHOD, FARETYPE) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                
                PreparedStatement ps = con.prepareStatement(sql);
                
                ps.setString(1, "Messi");
                ps.setInt(2, passengerNum);
                ps.setString(3, trainNumber);
                ps.setString(4, trainName);
                ps.setString(5, travelClass);
                ps.setString(6, source);
                ps.setString(7, destination);
                ps.setString(8, departureTime);
                ps.setString(9, originalDate);
                ps.setString(10, newDate);
                ps.setInt(11, totalAmount);
                ps.setString(12, paymentMethod);
                ps.setString(13, fareType);
                ps.executeUpdate();
                
                String getIdSQL = "SELECT last_insert_rowid()";
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(getIdSQL);

                // Fetch the BOOK_ID
                int bookId = -1;
                if (rs.next()) {
                    bookId = rs.getInt(1); // last_insert_rowid() will return the last inserted BOOK_ID
                }
                session.setAttribute("book_id", String.valueOf(bookId));
                // Insert passenger details
                for (int i = 1; i <= passengerNum; i++) {
                    String passengerName = (String) session.getAttribute("name_" + i);
                    String passengerAge = (String) session.getAttribute("age_" + i);
                    String gender = (String) session.getAttribute("gender_" + i);

                    // Insert passenger details into the database
                    ps = con.prepareStatement("INSERT INTO TrainPassengerDetails (pnr, passenger_name, age, gender) VALUES (?, ?, ?, ?)");
                    ps.setInt(1, bookId);
                    ps.setString(2, passengerName);
                    ps.setString(3, passengerAge);
                    ps.setString(4, gender);
                    ps.executeUpdate();
                    ps.close();
                }
                
                String updateSQL = "UPDATE " + travelClass + " SET "+newDate+" = "+newDate+" - ? WHERE train_number = ?";
                PreparedStatement psUpdate = con.prepareStatement(updateSQL);
                psUpdate.setInt(1, passengerNum);
                psUpdate.setString(2, trainNumber);
                psUpdate.executeUpdate();
                
                con.close();
                // Redirect to confirmation page
                RequestDispatcher rd = sc.getRequestDispatcher("/redirect.html");
                rd.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
