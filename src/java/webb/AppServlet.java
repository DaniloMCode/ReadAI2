package webb;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import org.json.JSONObject;
import model.User;
import org.json.JSONArray;

@WebServlet(name = "AppServlet", urlPatterns = {"/api/*"})
public class AppServlet extends HttpServlet {

    private JSONObject getJSONObject(BufferedReader reader) throws IOException {
        StringBuilder buffer = new StringBuilder();
        String line = null;
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }
        return new JSONObject(buffer.toString());
    }

        protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setContentType("application/json;charset=UTF-8");
            JSONObject file = new JSONObject();
            try {
                if (request.getRequestURI().endsWith("/api/session")) {
                    processSession(file, request, response);
                } else if (request.getRequestURI().endsWith("api/users")) {
                    processUsuarios(file, request, response);
                } else {
                    response.sendError(400, "Invalid URL");
                    file.put("error", "Invalid URL");
                }

            } catch (Exception ex) {
                response.sendError(500, "Internal error: " + ex.getLocalizedMessage());

            }
            response.getWriter().print(file.toString());
        }

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            processRequest(request, response);
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            processRequest(request, response);
        }

        @Override
        protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            processRequest(request, response);
        }

        @Override
        protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            processRequest(request, response);

        }

        @Override
        public String getServletInfo() {
            return "Short description";
        }// </editor-fold>

        // AppServlet.java

    private void processSession(JSONObject jsonResponse, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String method = request.getMethod().toLowerCase();
        User loggedInUser = (User) request.getSession().getAttribute("user"); // Pega o usuário da sessão, se houver

        if ("post".equals(method)) { // --- Lógica para LOGIN (POST) ---
            try {
                JSONObject body = getJSONObject(request.getReader());
                String login = body.getString("login");
                String password = body.getString("password");

                User userAttempt = User.getUsuario(login, password); // Tenta buscar o usuário no BD

                if (userAttempt == null) {
                    // Login ou senha incorretos
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized é mais apropriado aqui
                    jsonResponse.put("error", "Login ou senha incorretos.");
                } else {
                    // Login bem-sucedido
                    request.getSession().setAttribute("user", userAttempt); // Armazena o usuário na sessão
                    response.setStatus(HttpServletResponse.SC_OK); // 200 OK

                    jsonResponse.put("id", userAttempt.getRowId());
                    jsonResponse.put("login", userAttempt.getLogin());
                    jsonResponse.put("name", userAttempt.getNome()); // Corrigi para "name" para o frontend (seu v-if="data.name")
                    jsonResponse.put("sobrenome", userAttempt.getSobrenome());
                    jsonResponse.put("email", userAttempt.getEmail());
                    jsonResponse.put("message", "Login realizado com sucesso!");
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jsonResponse.put("error", "Erro interno do servidor ao tentar login: " + e.getMessage());
                System.err.println("Erro no POST /api/session (login): " + e.getMessage());
                e.printStackTrace();
            }

        } else if ("delete".equals(method)) { // --- Lógica para LOGOUT (DELETE) ---
            if (loggedInUser != null) {
                request.getSession().removeAttribute("user"); // Remove o atributo da sessão
                response.setStatus(HttpServletResponse.SC_OK); // 200 OK
                jsonResponse.put("message", "Logout realizado com sucesso.");
            } else {
                response.setStatus(HttpServletResponse.SC_NO_CONTENT); // 204 No Content - Não há sessão para deslogar
                jsonResponse.put("message", "Nenhuma sessão ativa para logout.");
            }

        } else if ("get".equals(method)) { // --- Lógica para VERIFICAR SESSÃO (GET) ---
            if (loggedInUser == null) {
                // Nenhuma sessão ativa. Retorna 401.
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
                jsonResponse.put("error", "Não autorizado: nenhuma sessão ativa.");
                // Não precisa retornar JSON com dados do usuário se não há sessão
            } else {
                // Há uma sessão ativa. Retorna os dados do usuário logado.
                response.setStatus(HttpServletResponse.SC_OK); // 200 OK
                jsonResponse.put("id", loggedInUser.getRowId());
                jsonResponse.put("login", loggedInUser.getLogin());
                jsonResponse.put("name", loggedInUser.getNome()); // Mapeado para 'name' para o frontend
                jsonResponse.put("sobrenome", loggedInUser.getSobrenome());
                jsonResponse.put("email", loggedInUser.getEmail());
                //jsonResponse.put("role", loggedInUser.getRole()); // Inclua se você tem um campo 'role'
                jsonResponse.put("message", "Sessão ativa.");
            }

        } else { // --- Outros Métodos HTTP (Não Permitidos) ---
            response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED); // 405 Method Not Allowed
            jsonResponse.put("error", "Método HTTP não permitido para /api/session.");
        }
    }
        private void processUsuarios(JSONObject file, HttpServletRequest request, HttpServletResponse response) throws Exception {
            if(request.getMethod().toLowerCase().equals("get")){
                file.put("list", new JSONArray(User.getUsuarios()));
            }else if(request.getMethod().toLowerCase().equals("post")){
                JSONObject body = getJSONObject(request.getReader());
                String login = body.getString("login");
                String name = body.getString("nome");
                String sobrenome = body.getString("sobrenome");
                String email = body.getString("email");
                String password = body.getString("password");
                User.insertUsuario(login, name, sobrenome, email, password);
            }else if(request.getMethod().toLowerCase().equals("put")){
                JSONObject body = getJSONObject(request.getReader());
                String login = body.getString("login");
                String name = body.getString("nome");
                String sobrenome = body.getString("sobrenome");
                String email = body.getString("email");
                String password = body.getString("password");
                User.updatetUsuario(login, name, sobrenome, email, password);

            }else if(request.getMethod().toLowerCase().equals("delete")){
                long id = Long.parseLong(request.getParameter("id"));
                User.deletetUser(id);
            }else{
                response.sendError(405, "Method not allowed");
            }



        }

}
