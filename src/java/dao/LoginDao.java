package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDao 
{
    public boolean check(String uname, String pass)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql?aai","root","kaka");
            PreparedStatement stmt = con.prepareStatement("select * from login where username=? and password=?");
            stmt.setString(1, uname);
            stmt.setString(2, pass);
            ResultSet rs = stmt.executeQuery();
            if(rs.next())
            {
                return true;
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return false;
    }
}
