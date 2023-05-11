import java.sql.*;
import java.util.*;


public class EmbeddedSQL {

    public static void main(String[] args) {
    	
    	
    	System.out.println("******************************************************");
		System.out.println("Welcome to Database design projecte 3:EmbededSql");
		System.out.println("*******************************************************");
        System.out.print("Enter Course code: ");
        Scanner sc = new Scanner(System.in);
        String CourseCode = sc.next();
        System.out.print("Enter ClO: ");
        String clo = sc.next();
   
     // database = project2_w23 username=root password="" ssl=true(For secure)
		// To make code secure, we use ssl.
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project2_w23?autoReconnect=true&useSSL=true","root","");
            String strQuery = "SELECT (SELECT COUNT(DISTINCT(q.AssessmentID)) FROM questions q JOIN learningoutcome l ON q.CLO=l.Clo WHERE q.CourseCode=? AND l.clo=?) / (SELECT COUNT(DISTINCT(AssessmentID)) FROM questions WHERE CourseCode=?) * 100 AS Mached_Percent;";
            PreparedStatement pstmt = con.prepareStatement(strQuery);
            pstmt.setString(1, CourseCode);
            pstmt.setString(2, clo);
            pstmt.setString(3, CourseCode);
            ResultSet results = pstmt.executeQuery();

            while (results.next())
                System.out.println("Percentage: "+results.getString(1));
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }

    }
}