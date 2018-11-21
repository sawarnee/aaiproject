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
public class TransferInitiative extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String airport_name = request.getParameter("airport_name");
        String initiative_name = request.getParameter("initiative_name");
        String initiative_about = request.getParameter("initiative_about");
        
        Part img1 = request.getPart("img1");
        Part img2 = request.getPart("img2");
        Part img3 = request.getPart("img3");
        Part img4 = request.getPart("img4");
        Part img5 = request.getPart("img5");
        
        InputStream is1 = img1.getInputStream();
        InputStream is2 = img2.getInputStream();
        InputStream is3 = img3.getInputStream();
        InputStream is4 = img4.getInputStream();
        InputStream is5 = img5.getInputStream();
        
//        out.println(airport_name+" "+initiative_name+" "+initiative_about);
        
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql?aai","root","kaka");
            PreparedStatement stmt = con.prepareStatement("INSERT INTO underdevelopment (`name`, airport, about, `date`, img1, img2, img3, img4, img5) VALUES (?,?,?,?,?,?,?,?,?)");
            stmt.setString(1, initiative_name);
            stmt.setString(2, airport_name);
            stmt.setString(3, initiative_about);
            java.sql.Date sqlDate = new java.sql.Date(new java.util.Date().getTime());
            stmt.setDate(4, sqlDate);
            
            stmt.setBlob(5, is1);
            stmt.setBlob(6, is2);
            stmt.setBlob(7, is3);
            stmt.setBlob(8, is4);
            stmt.setBlob(9, is5);
            
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
