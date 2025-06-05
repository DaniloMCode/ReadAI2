<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="IA.Gemini" %> 

<%
    // Lógica de processamento do prompt
    // Isso será executado no servidor ANTES da página HTML ser enviada ao navegador.
    String completionResult = null;
    String errorResult = null;
    String currentPrompt = null;
    
    // ADICIONADO: Suas instruções fixas para o tutor
    String tutorInstructions = "Atue como um tutor pessoal de vestibulandos. Ensina de forma progressiva, começando com o básico e progrida gradualmente. modele o ensino em níveis. crie exercícios curtos a cada aula, incluindo principalmente questões de peso II da matéria escolhida pelo aluno. faça correções claras e de dicas de memorização eficientes. lembre de ser um tutor amigável e compressivo com o aluno. Com base nessas instruções, responda à seguinte solicitação do aluno: ";

    if(request.getParameter("invoke") != null) { // Verifica se o formulário foi submetido
        currentPrompt = request.getParameter("prompt");
        if (currentPrompt != null && !currentPrompt.trim().isEmpty()) {
            try {
                // Chamada ao método da sua classe DevOpenAI
                completionResult = Gemini.getCompletion(currentPrompt);
                request.setAttribute("completion", completionResult);
                request.setAttribute("submitted_prompt", currentPrompt);
            } catch(Exception ex) {
                errorResult = ex.getMessage();
                request.setAttribute("error", errorResult);
                request.setAttribute("submitted_prompt", currentPrompt);
                ex.printStackTrace(); // Bom para debug no console do servidor
            }
        } else {
            errorResult = "O prompt não pode ser vazio.";
            request.setAttribute("error", errorResult);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>POO_interface com ReadAI (JSP Direct)</title>
    <link rel="stylesheet" href="ICR_Style.css"> <%-- Mantenha seu CSS --%>
</head>
<body>
    <div>
        <button class="botao_imagem" onclick="ExibirBarraLateral()">
            <img src="../imagem/opcoes.png" alt="Ícone do botão" class="icone"> <%-- Verifique o caminho da imagem --%>
        </button>
        <div class="sidebar" id="minha_sidebar">
            <div>
                <a href="#">Menu Principal</a> <br>
                <a href="#">Sobre</a> <br>
                <a href="#">Serviços</a> <br>
                <a href="#">Contato</a> <br>
                <a href="#">Sobre nós</a> <br>
            </div>
        </div>
    </div>

    <div id="main" class="main">
        <div id="chatInterface" class="chat-area"> 
            <%-- Área onde o resultado do prompt/completion ou erro será exibido --%>
            <% if(request.getAttribute("error") != null) { %>
                <div class="mensagem-erro-bloco">
                    <strong>Prompt Enviado:</strong> <%= request.getAttribute("submitted_prompt") %><br/>
                    <strong>ERRO:</strong> <%= request.getAttribute("error") %>
                </div>
            <% } else if(request.getAttribute("completion") != null) { %>
                <div class="mensagem-prompt">
                    <strong>Você perguntou:</strong>
                    <div><%= request.getAttribute("submitted_prompt") %></div>
                </div>
                <div class="mensagem-completion">
                    <strong>ReadAI respondeu:</strong>
                    <div><%= request.getAttribute("completion") %></div>
                </div>
            <% } else { %>
                <%-- Mensagem inicial antes de qualquer submissão --%>
                <h1 id="boasVindas" class="cinza transparencia central centralizado">
                    Bem-vindo(a) ao ReadAI! Faça sua pergunta abaixo.
                </h1>
            <% } %>
        </div>

        <%-- Formulário para enviar o prompt --%>
        <div class="container centralizado">
            <form method="POST"> 
                <input type="text" 
                       name="prompt" 
                       id="Caixa_texto" 
                       class="entrada_prompt" 
                       placeholder="Olá, como posso te ajudar?" 
                       size="100" 
                       value="<%= (request.getParameter("invoke") != null && request.getParameter("prompt")!=null ? request.getParameter("prompt") : "") %>" /> 
                <input type="submit" 
                       name="invoke" 
                       value="Enviar" 
                       class="botao"/>
            </form>
        </div>
    </div>

    <script>
        // JavaScript para a barra lateral
        function ExibirBarraLateral() {
            var barralateral = document.getElementById("minha_sidebar");
            var botao = document.querySelector(".botao_imagem");
            barralateral.classList.toggle("open");
            botao.classList.toggle("move");
        }
    </script>
</body>
</html> 