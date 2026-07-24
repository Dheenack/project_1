import java.sql.*;

public class DataBaseConnection {
    // Correct driver string for Connector/J 8.0
    private static final String DRIVER_CLASS = "com.mysql.cj.jdbc.Driver"; 
    
    // Replace 'mydatabase' with your actual target database name
    
	private static final String URL = "jdbc:mysql://localhost:3306/world"; 
    private static final String USER = "root";
    private static final String PASSWORD = "csc123";

    public static void main(String[] args) {
       
        try {
           
            Class.forName(DRIVER_CLASS);
            
            try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
                 Statement st = connection.createStatement()) {
                
                System.out.println("Successfully connected to the database!");
    
                try (ResultSet rs = st.executeQuery("SELECT * FROM countrylanguage")) {
                  while (rs.next()) {
                        System.out.println(rs.getString("CountryCode")+" " + rs.getString("language"));
                    }
	
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
