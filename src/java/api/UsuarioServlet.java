/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package api;

import jakarta.servlet.ServletConfig;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import org.json.JSONArray;
import org.json.JSONObject;
import ClasseConsultaDB.Usuario;

/**
 *
 * @author morat
 */
@WebServlet(name = "UsuarioServlet", urlPatterns = {"/usuario"})
public class UsuarioServlet extends HttpServlet {

    private JSONObject getJSONBody(BufferedReader reader) throws Exception {
        StringBuilder buffer = new StringBuilder();
        String line = null;
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }
        return new JSONObject(buffer.toString());
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
        response.setContentType("application/json;charset=UTF-8");
        JSONObject file = new JSONObject();
        try {
            /*file.put("exception", new JSONArray(Usuario.list));*/
            file.put("list", new JSONArray(Usuario.list));

        } catch (Exception ex) {
            response.setStatus(500);
            file.put("error", ex.getLocalizedMessage());
        }
        response.getWriter().print(file.toString());
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

      JSONObject file = new JSONObject();

try {
    JSONObject body = getJSONBody(request.getReader());

    String nome = body.getString("nome");
    String sobrenome = body.getString("sobrenome");
    String email = body.getString("email");
    String confirmacaoEmail = body.getString("confirmacaoEmail");
    String senha = body.getString("senha");

    if (nome != null && sobrenome != null && email != null && confirmacaoEmail != null && senha != null) {
        Usuario u = new Usuario(nome, sobrenome, email, confirmacaoEmail, senha);
        Usuario.list.add(u); // Adiciona na lista
        Usuario.addUsuario(nome, sobrenome, email, confirmacaoEmail, senha); // Salva no banco
    }

    file.put("list", new JSONArray(Usuario.list));

} catch (Exception ex) {
    response.setStatus(500);
    file.put("error", ex.getLocalizedMessage());
}

response.getWriter().print(file.toString());
    }

    
    
    
    /**
     * Handles the HTTP <code>DELETE</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
        protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setContentType("application/json;charset=UTF-8");
            JSONObject file = new JSONObject();
            try {
    String nome = request.getParameter("nome");
    String sobrenome = request.getParameter("sobrenome");
    String email = request.getParameter("email");
    String confirmacaoEmail = request.getParameter("confirmacaoEmail");
    String senha = request.getParameter("senha");

    int i = -1;
    for (Usuario u : Usuario.list) {
        if (
            u.getNome().equals(nome) &&
            u.getSobrenome().equals(sobrenome) &&
            u.getEmail().equals(email) &&
            u.getConfirmacaoEmail().equals(confirmacaoEmail) &&
            u.getSenha().equals(senha)
        ) {
            i = Usuario.list.indexOf(u);
            break;
        }
    }

    if (i > -1) Usuario.list.remove(i);
    file.put("list", new JSONArray(Usuario.list));

} catch (Exception ex) {
    response.setStatus(500);
    file.put("error", ex.getLocalizedMessage());
}

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

    @Override
public void init(ServletConfig config) throws ServletException {
        super.init(config); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
        Usuario.createTable();
    }

}
