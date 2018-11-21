import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class TransferCompleted extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String airport_name = request.getParameter("airport_name");
        String underdevelopment_name = request.getParameter("underdevelopment_name");
        String underdevelopment_about = request.getParameter("underdevelopment_about");
        
        Part video = request.getPart("video");

        InputStream is = video.getInputStream();
        
//        out.println(airport_name+" "+underdevelopment_name+" "+underdevelopment_about+" ");
        
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql?aai","root","kaka");
            PreparedStatement stmt = con.prepareStatement("INSERT INTO completed (`name`, airport, about, `date`, video) VALUES (?,?,?,?,?)");
            stmt.setString(1, underdevelopment_name);
            stmt.setString(2, airport_name);
            stmt.setString(3, underdevelopment_about);
            java.sql.Date sqlDate = new java.sql.Date(new java.util.Date().getTime());
            stmt.setDate(4, sqlDate);
            
            stmt.setBlob(5, is);
            
            stmt.executeUpdate();
            
            response.sendRedirect("operator.jsp");
        }
        catch(Exception e)
        {
            out.println(e);
        }
    
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
