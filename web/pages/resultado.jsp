<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="web.LD_Questao"%>

<%
    // Lógica para reiniciar o quiz
    if ("restart".equals(request.getParameter("action"))) {
        session.removeAttribute("quizQuestoes");
        session.removeAttribute("questaoAtual");
        response.sendRedirect("AL_LicaoDiaria.jsp");
        return;
    }

    // Pega o resultado do quiz da sessão
    List<LD_Questao> quizQuestoes = (List<LD_Questao>) session.getAttribute("quizQuestoes");

    // Medida de segurança: se não há quiz, volta para o início.
    if (quizQuestoes == null) {
        response.sendRedirect("AL_LicaoDiaria.jsp");
        return;
    }

    // Calcula a pontuação
    int pontuacao = 0;
    for (LD_Questao q : quizQuestoes) {
        if (q.getRespostaCorreta() != null && q.getRespostaCorreta().equalsIgnoreCase(q.getRespostaDoUsuario())) {
            pontuacao++;
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado do Quiz - READ AI</title>
    <link rel="stylesheet" href="I_Style.css">
</head>
<body>
    <div class="app-container">
        <header class="top-bar">
            <div class="logo-area"><span class="logo-text">READ AI</span></div>
            <div class="user-profile"><div class="user-avatar-placeholder"></div></div>
        </header>
        <main class="content-area">
            <aside class="sidebar">
                <nav class="navigation">
                    <ul>
                        <li class="active"><a href="AL_LicaoDiaria.jsp" class="nav-item">Lição Diária</a></li>
                        <li><a href="guia_de_estudos.jsp" class="nav-item">Guia de Estudos</a></li>
                        <li><a href="tela_ia.jsp" class="nav-item">Tutor</a></li>
                    </ul>
                </nav>
            </aside>

<section class="chat-area" id="resultInterface" style="display: flex; flex-direction: column; padding: 20px;">
    <%-- O sumário e o botão ficam aqui, na parte de cima e fixos --%>
    <div class="result-summary" style="flex-shrink: 0;">
        <h1>Quiz Finalizado!</h1>
        <p class="score">Sua Pontuação: <strong><%= pontuacao %> de <%= quizQuestoes.size() %></strong></p>
        <a href="resultado.jsp?action=restart" class="restart-button">Fazer Novo Quiz</a>
    </div>

    <h2 style="margin-top: 40px; border-bottom: 2px solid #ddd; padding-bottom: 10px; flex-shrink: 0;">
        Gabarito Detalhado
    </h2>

    <%-- A NOVA CAIXA QUE TERÁ A BARRA DE ROLAGEM --%>
    <div class="results-list-container">
        <%-- Loop para mostrar cada questão e seu resultado --%>
        <% for (int i = 0; i < quizQuestoes.size(); i++) {
            LD_Questao q = quizQuestoes.get(i);
            boolean isCorrect = q.getRespostaCorreta().equalsIgnoreCase(q.getRespostaDoUsuario());
        %>
            <div class="result-item">
                <h4>Questão <%= i + 1 %>:</h4>
                <p class="result-question"><%= q.getEnunciado() %></p>
                
                <p><strong>Sua Resposta:</strong></p>
                <div class="user-answer <%= isCorrect ? "correct-answer" : "incorrect-answer" %>">
                    <% if (q.getRespostaDoUsuario() != null) { %>
                        <%= q.getRespostaDoUsuario() %>
                    <% } else { %>
                        <span style="font-style: italic;">Não respondida</span>
                    <% } %>
                </div>

                <% if (!isCorrect) { %>
                    <p><strong>Resposta Correta:</strong></p>
                    <div class="correct-answer-key"><%= q.getRespostaCorreta() %></div>
                <% } %>

                <p><strong>Justificativa:</strong></p>
                <div class="justification"><%= q.getJustificativa() %></div>
                 </div>
                <% } %>
            </section>
        </main>
    </div>
</body>
</html>
