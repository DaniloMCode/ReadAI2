<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="web.LD_Questao"%>

<%
    // --- O CÉREBRO DA PÁGINA ---

    // 1. Pega os dados do quiz da sessão.
    List<LD_Questao> quizQuestoes = (List<LD_Questao>) session.getAttribute("quizQuestoes");
    Integer questaoAtualIndex = (Integer) session.getAttribute("questaoAtual");

    // 2. Medida de segurança: se não há quiz na sessão, volta para o início.
    if (quizQuestoes == null || questaoAtualIndex == null) {
        response.sendRedirect("AL_LicaoDiaria.jsp");
        return;
    }

    // 3. Processa a resposta da questão anterior (se uma foi enviada).
    String respostaRecebida = request.getParameter("resposta");
    if (respostaRecebida != null) {
        // Pega a questão que FOI respondida (o índice antigo)
        int questaoRespondidaIndex = questaoAtualIndex - 1; 
        if(questaoRespondidaIndex >= 0){
             LD_Questao questaoRespondida = quizQuestoes.get(questaoRespondidaIndex);
             questaoRespondida.setRespostaDoUsuario(respostaRecebida);
        }
    }

    // 4. Verifica se o quiz terminou.
    if (questaoAtualIndex >= quizQuestoes.size()) {
        response.sendRedirect("resultado.jsp");
        return;
    }

    // 5. Prepara a questão ATUAL para ser exibida.
    LD_Questao questaoParaExibir = quizQuestoes.get(questaoAtualIndex);
    
    // 6. Incrementa o contador para a PRÓXIMA vez que a página carregar.
    session.setAttribute("questaoAtual", questaoAtualIndex + 1);
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz - Questão <%= questaoAtualIndex + 1 %></title>
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
                        <li class="active"><a href="AL_LicaoDiaria.jsp" class="nav-item">Quiz</a></li>
                        <li><a href="guia_de_estudos.jsp" class="nav-item">Guia de Estudos</a></li>
                        <li><a href="index.jsp" class="nav-item">Tutor</a></li>
                    </ul>
                </nav>
            </aside>

           <section class="quiz-container" id="quizInterface">
                <%-- Área para exibir a questão --%>
                <div class="quiz-question-area" style="padding: 20px;">
                    <h2 style="margin-bottom: 20px;">Questão <%= questaoAtualIndex + 1 %> de <%= quizQuestoes.size() %></h2>
                    <div class="quiz-question-box">
                    <%= questaoParaExibir.getEnunciado() %>
                        </div>
                    </div>
                </div>

                <%-- Área para exibir as alternativas como botões --%>
                <div class="quiz-options-area" style="padding: 20px;">
                    <%
                        char optionLabel = 'A';
                        for (String alternativa : questaoParaExibir.getAlternativas()) {
                    %>
                        <a href="quiz.jsp?resposta=<%= optionLabel %>" class="quiz-option">
                            <span class="option-letter"><%= optionLabel %></span>
                            <span class="option-text"><%= alternativa %></span>
                        </a>
                    <%
                            optionLabel++;
                        }
                    %>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
