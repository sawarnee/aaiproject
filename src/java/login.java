import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
            String  unm = request.getParameter("username");
            String  pwd = request.getParameter("password");
//            RequestDispatcher disp = null;
            
            HttpSession session = request.getSession();
            
            try
            {
                
                if(unm.equals("admin") && pwd.equals("admin"))
                {
                    session.setAttribute("username", "admin");
                    response.sendRedirect("admin.jsp");
                }
                else
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql?aai","root","kaka");
                    PreparedStatement stmt = con.prepareStatement("select * from login where username=?");
                    stmt.setString(1, unm);
                    ResultSet rs = stmt.executeQuery();
                    if(rs.next())
                    {
                        String username = rs.getString(1);
                        String password = rs.getString(2);
                        String name = rs.getString(3);
                        String airport = rs.getString(4);
                        if(username.equals(unm) && password.equals(pwd))
                        {
                            session.setAttribute("username", unm);

    //                        request.setAttribute("name", name);
    //                        request.setAttribute("airport", airport);

                            ServletContext context = request.getServletContext();
                            context.setAttribute("name", name);
                            context.setAttribute("airport", airport);

                            response.sendRedirect("operator.jsp");

    //                        disp = request.getRequestDispatcher("operator.jsp");
    //                        out.println(name + " " + airport);
    //                        disp.include(request, response);

                        }
                        else
                        {
                            out.println("<br><center><h1>wrong username or password</h1></center>");
                        }                    
                    }
                    else
                    {
                        out.println("<br><center><h1>wrong username or password</h1></center>");
                    }
                }
                
            }
            catch(Exception e){}
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
