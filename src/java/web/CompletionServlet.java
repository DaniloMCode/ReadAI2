package web; // Ajuste o pacote conforme sua estrutura

import IA.Gemini;
import chat.ChatMessage; // Importe ChatMessage do pacote 'chat'
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONObject;


@WebServlet(name = "CompletionServlet", urlPatterns = {"/completion"})
public class CompletionServlet extends HttpServlet {

    private static final String INSTRUCOES_TUTOR = "Atue como um tutor pessoal de vestibulandos. Ensina de forma progressiva, começando com o básico e progrida gradualmente. modele o ensino em níveis. crie exercícios curtos a cada aula, incluindo principalmente questões de peso II da matéria escolhida pelo aluno. faça correções claras e de dicas de memorização eficientes. lembre de ser um tutor amigável e compressivo com o aluno. Com base nessas instruções, responda à seguinte solicitação do aluno: ";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject(); // Objeto JSON para a resposta

        HttpSession session = request.getSession();
        // Obtém ou cria o histórico de chat na sessão
        List<ChatMessage> chatHistory = (List<ChatMessage>) session.getAttribute("chatHistory");
        if (chatHistory == null) {
            chatHistory = new ArrayList<>();
            // Adiciona a mensagem inicial do tutor APENAS SE o histórico for novo/sessão iniciada
            chatHistory.add(new ChatMessage("ai", "Olá! Sou seu tutor pessoal da READ AI. Como posso te ajudar hoje com seus estudos para o vestibular?"));
            session.setAttribute("chatHistory", chatHistory);
        }

        String promptDoUsuario = request.getParameter("prompt");

        if (promptDoUsuario != null && !promptDoUsuario.trim().isEmpty()) {
            // Adiciona a mensagem do usuário ao histórico ANTES de enviar para a IA
            chatHistory.add(new ChatMessage("user", promptDoUsuario));

            // Constrói o prompt completo para a IA, incluindo o histórico de conversa
            StringBuilder promptCompletoParaIA = new StringBuilder();
            promptCompletoParaIA.append(INSTRUCOES_TUTOR);

            for (ChatMessage msg : chatHistory) {
                promptCompletoParaIA.append("\n"); // Adiciona uma nova linha para cada turno
                if (msg.getSender().equals("user")) {
                    promptCompletoParaIA.append("Aluno: ").append(msg.getMessage());
                } else { // "ai"
                    promptCompletoParaIA.append("Tutor: ").append(msg.getMessage());
                }
            }

            try {
                // Chama a API Gemini com o prompt que contém todo o histórico
                String respostaDaIA = Gemini.getCompletion(promptCompletoParaIA.toString());

                // Adiciona a resposta da IA ao histórico
                chatHistory.add(new ChatMessage("ai", respostaDaIA));

                jsonResponse.put("status", "success");
                jsonResponse.put("response", respostaDaIA);
                // Você pode até retornar o histórico completo para o frontend se quiser, mas é mais pesado
                // jsonResponse.put("chatHistory", chatHistory);
            } catch (Exception ex) {
                // Se houver um erro, remova a última mensagem do usuário para não poluir o histórico com um turno sem resposta
                if (!chatHistory.isEmpty() && chatHistory.get(chatHistory.size() - 1).getSender().equals("user")) {
                    chatHistory.remove(chatHistory.size() - 1);
                }
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Ocorreu um erro ao processar sua solicitação: " + ex.getMessage());
                ex.printStackTrace(); // Loga o erro no console do servidor
            }
        } else {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "O prompt não pode ser vazio.");
        }

        // Garante que o histórico atualizado esteja na sessão
        session.setAttribute("chatHistory", chatHistory);

        out.print(jsonResponse.toString());
        out.flush(); // Garante que a resposta seja enviada imediatamente
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para processar requisições de chat com a IA Gemini e gerenciar histórico.";
    }
}
