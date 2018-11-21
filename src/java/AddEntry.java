import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddEntry extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
//        RequestDispatcher disp = request.getRequestDispatcher("operator.jsp");
        
        String airport_name = request.getParameter("airport_name");
        String project_name = request.getParameter("project_name");
        String project_desc = request.getParameter("project_desc");
        String project_category = request.getParameter("project_category");
        
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql?aai","root","kaka");
            PreparedStatement stmt = null;
            if(project_category.equals("Initiative"))
            {
                stmt = con.prepareStatement("insert into initiative(name, airport, about, date) values (?,?,?,?)");
                stmt.setString(1, project_name);
                stmt.setString(2, airport_name);
                stmt.setString(3, project_desc);
                java.sql.Date sqlDate = new java.sql.Date(new java.util.Date().getTime());
                stmt.setDate(4, sqlDate);
                stmt.executeUpdate();
                out.println("Entry added successfully");
            }
            else if(project_category.equals("Under Development"))
            {
                stmt = con.prepareStatement("insert into underdevelopment(name, airport, about, date) values (?,?,?,?)");
                stmt.setString(1, project_name);
                stmt.setString(2, airport_name);
                stmt.setString(3, project_desc);
                java.sql.Date sqlDate = new java.sql.Date(new java.util.Date().getTime());
                stmt.setDate(4, sqlDate);
                stmt.executeUpdate();
                out.println("Entry added successfully");
            }
            else if(project_category.equals("Completed"))
            {
                stmt = con.prepareStatement("insert into completed(name, airport, about, date) values (?,?,?,?)");
                stmt.setString(1, project_name);
                stmt.setString(2, airport_name);
                stmt.setString(3, project_desc);
                java.sql.Date sqlDate = new java.sql.Date(new java.util.Date().getTime());
                stmt.setDate(4, sqlDate);
                stmt.executeUpdate();
                out.println("Entry added successfully");
            }
        }
        catch(Exception e)
        {
            out.println(e);
        }
        finally
        {
            response.sendRedirect("operator.jsp");
//            disp.include(request, response);
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
