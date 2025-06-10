<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="chat.ChatMessage" %>
<%@ page import="IA.Gemini" %>

<%
    // 1. GERENCIAR HISTÓRICO DA CONVERSA
    List<ChatMessage> chatHistory = (List<ChatMessage>) session.getAttribute("chatHistory");
    if (chatHistory == null) {
        chatHistory = new ArrayList<>();
        // Mensagem inicial da IA
        chatHistory.add(new ChatMessage("ai", "Olá! Sou seu tutor pessoal da READ AI. Como posso te ajudar hoje?"));
        session.setAttribute("chatHistory", chatHistory);
    }

    // 2. PROCESSAR O ENVIO DO FORMULÁRIO
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String userPrompt = request.getParameter("prompt");

        if (userPrompt != null && !userPrompt.trim().isEmpty()) {
            // Adiciona a mensagem do usuário ao histórico
            chatHistory.add(new ChatMessage("user", userPrompt));

            // Constrói o prompt para a IA
            String tutorInstructions = "Atue como um tutor pessoal de vestibulandos. Ensina de forma progressiva, começando com o básico e progrida gradualmente. modele o ensino em níveis. lembre de ser um tutor amigável, compressivo e objetivo com o aluno. Com base nessas instruções, responda à seguinte solicitação do aluno de maneira simples e muito resumida: (não é necessario passar questões, apenas orientar) ";
            String fullPromptForAI = tutorInstructions + userPrompt;

            try {
            // Chama a API do Gemini
             String aiResponse = Gemini.getCompletion(fullPromptForAI);

              // ---- AQUI ESTÁ A MÁGICA DA FORMATAÇÃO ----
    // Traduz a sintaxe Markdown para tags HTML
    String formattedResponse = aiResponse
        // Primeiro, traduz o negrito com dois asteriscos
        .replaceAll("\\*\\*(.*?)\\*\\*", "<strong>$1</strong>")
        
        // Depois, traduz o itálico com um asterisco
        .replaceAll("\\*(.*?)\\*", "<em>$1</em>")
        
        // Por último, converte as quebras de linha
        .replaceAll("\n", "<br>");

    // Adiciona a resposta JÁ FORMATADA ao histórico
    chatHistory.add(new ChatMessage("ai", formattedResponse));
    } catch (Exception ex) {
                // Adiciona uma mensagem de erro ao histórico
                chatHistory.add(new ChatMessage("ai", "Desculpe, ocorreu um erro ao contatar a IA: " + ex.getMessage()));
                ex.printStackTrace(); // Para debug no log do servidor
            }
            
            // Salva o histórico atualizado na sessão e redireciona para evitar reenvio do formulário
            session.setAttribute("chatHistory", chatHistory);
            response.sendRedirect("index.jsp");
            return; // Importante para parar a execução da página aqui
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat READ AI</title>
    <link rel="stylesheet" href="I_Style.css">
</head>
<body>
    <div class="app-container">
        <header class="top-bar">
            <div class="logo-area">
                <span class="logo-text">READ AI</span>
            </div>
            <div class="user-profile">
                <div class="user-avatar-placeholder"></div>
            </div>
        </header>

        <main class="content-area">
            <aside class="sidebar">
                <nav class="navigation">
                    <ul>
                        <li><a href="AL_LicaoDiaria.jsp" class="nav-item">Quiz</a></li>
                        <li><a href="guia_de_estudos.jsp" class="nav-item">Guia de Estudos</a></li>
                        <li class="active"><a href="tela_ia.jsp" class="nav-item">Tutor</a></li>
                    </ul>
                </nav>
            </aside>

            <section class="chat-area" id="chatInterface">
                <div class="chat-messages" id="chatMessages">
                    <%-- 3. EXIBIR O HISTÓRICO DA CONVERSA --%>
                    <% for (ChatMessage message : chatHistory) { %>
                        <% if ("user".equals(message.getSender())) { %>
                            <div class="message outgoing">
                                <div class="message-bubble"><%= message.getMessage() %></div>
                                <div class="message-avatar-placeholder user-avatar"></div>
                            </div>
                        <% } else { %>
                            <div class="message incoming">
                                <div class="message-avatar-placeholder"></div>
                                <div class="message-bubble"><%= message.getMessage() %></div>
                            </div>
                        <% } %>
                    <% } %>
                </div>

                <div class="chat-input-area">
                    <form method="POST" action="index.jsp" class="chat-form">
                        <input type="text"
                               name="prompt"
                               id="Caixa_texto"
                               class="chat-input"
                               placeholder="Olá, como posso te ajudar?"
                               autocomplete="off" />
                        <button type="submit"
                                id="sendButton"
                                class="send-button-placeholder"></button>
                    </form>
                </div>
            </section>
        </main>
    </div>

    <script>
        // Rola a área de chat para a mensagem mais recente assim que a página carrega
        window.onload = function() {
            var chatMessages = document.getElementById('chatMessages');
            chatMessages.scrollTop = chatMessages.scrollHeight;
            
            // Foca na caixa de texto para digitação imediata
            var chatInput = document.getElementById('Caixa_texto');
            if (chatInput) {
                chatInput.focus();
            }
        };
    </script>
</body>
</html>
