<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="IA.Gemini"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="web.LD_Questao"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>

<%
    // Lógica para iniciar o quiz com VALIDAÇÃO
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");
        String vestibular = request.getParameter("vestibular");
        String materia = request.getParameter("materia");
        String dificuldade = request.getParameter("dificuldade");

        // Limpa qualquer quiz antigo da sessão para garantir um novo começo
        session.removeAttribute("quizQuestoes");
        session.removeAttribute("questaoAtual");

        if (materia != null && !materia.trim().isEmpty()) {
            
            // -----------------------------------------
            // PASSO 1: VALIDAÇÃO DO TÓPICO COM A IA
            // -----------------------------------------
            boolean isTopicValid = false;
            try {
                String validationPrompt = "O tópico a seguir é uma matéria ou disciplina acadêmica geralmente estudada para vestibulares no Brasil? Responda APENAS com 'sim' ou 'não'. Tópico: '" + materia + "'";
                String validationResponse = Gemini.getCompletion(validationPrompt);
                
                // Verificamos se a resposta da IA foi um "sim" claro.
                if (validationResponse.trim().equalsIgnoreCase("sim")) {
                    isTopicValid = true;
                }

            } catch (Exception e) {
                // Se a validação falhar por qualquer motivo, consideramos o tópico inválido por segurança.
                e.printStackTrace();
            }

            // -----------------------------------------
            // PASSO 2: GERAR O QUIZ OU MOSTRAR ERRO
            // -----------------------------------------
            if (isTopicValid) {
                // Se o tópico for válido, continuamos com a lógica que você já tem.
                try {
                    String promptForAI = String.format(
                        "Para a matéria '%s', nível '%s', para o vestibular '%s', gere um quiz com 5 questões. " +
                        "Sua resposta DEVE ser um array JSON e NADA MAIS. Não inclua texto explicativo antes ou depois do JSON. " +
                        "Cada objeto no array deve conter EXATAMENTE as seguintes chaves: " +
                        "'enunciado' (string com o texto da pergunta), " +
                        "'alternativas' (um array com EXATAMENTE 5 strings, contendo apenas o texto de cada alternativa, sem as letras 'A)', 'B)', etc.), " +
                        "'respostaCorreta' (string, contendo apenas a letra maiúscula da alternativa correta, por exemplo: 'C'), " +
                        "'justificativa' (string com a explicação da resposta).",
                        materia, dificuldade, vestibular
                    );

                    String jsonResponse = Gemini.getCompletion(promptForAI);
                    jsonResponse = jsonResponse.trim().replace("```json", "").replace("```", "").trim();

                    // ... (resto do seu código que parseia o JSON e cria a lista de questões) ...
                    // Este trecho continua igual.
                    JSONArray questoesJSON = new JSONArray(jsonResponse);
                    List<LD_Questao> quizQuestoes = new ArrayList<>();
                    for (int i = 0; i < questoesJSON.length(); i++) {
                        JSONObject qJson = questoesJSON.getJSONObject(i);
                        LD_Questao q = new LD_Questao();
                        q.setEnunciado(qJson.getString("enunciado"));
                        q.setRespostaCorreta(qJson.getString("respostaCorreta"));
                        q.setJustificativa(qJson.getString("justificativa"));
                        JSONArray alternativasJson = qJson.getJSONArray("alternativas");
                        List<String> alternativasList = new ArrayList<>();
                        for (int j = 0; j < alternativasJson.length(); j++) {
                            alternativasList.add(alternativasJson.getString(j));
                        }
                        q.setAlternativas(alternativasList);
                        quizQuestoes.add(q);
                    }

                    session.setAttribute("quizQuestoes", quizQuestoes);
                    session.setAttribute("questaoAtual", 0);
                    response.sendRedirect("quiz.jsp");
                    return;

                } catch (Exception ex) {
                    request.setAttribute("error", "O tópico é válido, mas ocorreu um erro ao gerar o quiz: " + ex.getMessage());
                    ex.printStackTrace();
                }

            } else {
                // Se o tópico NÃO for válido, preparamos uma mensagem de erro para o usuário.
                request.setAttribute("error", "Por favor, insira uma matéria de estudos válida. Tópicos como '" + materia + "' não são permitidos.");
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Configurar Quiz - READ AI</title>
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
                        <li><a href="#" class="nav-item">Perfil</a></li>
                        <li class="active"><a href="AL_LicaoDiaria.jsp" class="nav-item">Lição Diária</a></li>
                        <li><a href="guia_de_estudos.jsp" class="nav-item">Guia de Estudos</a></li>
                        <li><a href="index.jsp" class="nav-item">Tutor</a></li>
                    </ul>
                </nav>
            </aside>
            <section class="chat-area" id="configInterface">
                <div class="config-form-container" style="padding: 40px; text-align: center;">
                    <h1>Monte seu Quiz</h1>
                    <p>Selecione os parâmetros abaixo para gerar seu quiz personalizado.</p>
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <p style="color: red; background: #ffebee; padding: 10px; border-radius: 5px;"><%= request.getAttribute("error") %></p>
                    <% } %>

                    <form method="POST" action="AL_LicaoDiaria.jsp" style="margin-top: 20px;">
                        <div style="margin-bottom: 15px;">
                            <label for="vestibular" style="display: block; margin-bottom: 5px;">Vestibular:</label>
                            <select name="vestibular" id="vestibular" class="chat-input" style="width: 50%;">
                                <option value="ENEM">ENEM</option>
                                <option value="FUVEST">FUVEST</option>
                                <option value="UNICAMP">UNICAMP</option>
                                <option value="Geral">Geral</option>
                            </select>
                        </div>
                        <div style="margin-bottom: 15px;">
                            <label for="materia" style="display: block; margin-bottom: 5px;">Matéria:</label>
                            <input type="text" name="materia" id="materia" class="chat-input" style="width: 50%;" placeholder="Ex: Biologia Celular, História do Brasil" required>
                        </div>
                        <div style="margin-bottom: 25px;">
                            <label for="dificuldade" style="display: block; margin-bottom: 5px;">Dificuldade:</label>
                            <select name="dificuldade" id="dificuldade" class="chat-input" style="width: 50%;">
                                <option value="Fácil">Fácil</option>
                                <option value="Média">Média</option>
                                <option value="Difícil">Difícil</option>
                            </select>
                        </div>
                        <button type="submit" class="send-button-placeholder" style="width: 200px; height: 50px; border-radius: 25px; cursor: pointer; background-color: #2b6cb0; color: white; font-size: 1.1em; border: none;">
                            Iniciar Quiz
                        </button>
                    </form>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
