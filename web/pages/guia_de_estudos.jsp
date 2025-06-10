<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="IA.Gemini"%>

<%
    String studyPlan = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");
        String prova = request.getParameter("prova");
        String dataProva = request.getParameter("data_prova");
        String horasSemana = request.getParameter("horas_semana");
        String detalhesExtra = request.getParameter("detalhes_extra");

        try {
            // Criamos um prompt bem específico para a IA
            String promptForAI = String.format(
                "Aja como um mentor de estudos para vestibular. Crie um plano de estudos detalhado e estruturado para um aluno que vai prestar a prova '%s' na data de '%s'. " +
                "O aluno tem %s horas por semana para estudar. " +
                "Leve em consideração o seguinte detalhe importante: '%s'. " +
                "O plano deve ser organizado por semanas ou dias e deve sugerir matérias, tópicos específicos e momentos de revisão. " +
                "Use a formatação Markdown para organizar o plano, usando títulos, negrito e listas para facilitar a leitura.",
                prova, dataProva, horasSemana, detalhesExtra
            );

            String aiResponse = Gemini.getCompletion(promptForAI);

            // Formatamos a resposta Markdown da IA para HTML
            studyPlan = aiResponse
                .replaceAll("\\*\\*(.*?)\\*\\*", "<strong>$1</strong>") // Negrito
                .replaceAll("\\*(.*?)\\*", "<em>$1</em>")             // Itálico
                .replaceAll("^- (.*)", "<li>$1</li>")               // Itens de lista
                .replaceAll("\n", "<br>");                            // Parágrafos

        } catch (Exception ex) {
            studyPlan = "<strong>Ocorreu um erro ao gerar seu plano de estudos:</strong><br>" + ex.getMessage();
            ex.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guia de Estudos - READ AI</title>
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
                        <li><a href="AL_LicaoDiaria.jsp" class="nav-item">Quiz</a></li>
                        <li class="active"><a href="guia_de_estudos.jsp" class="nav-item">Guia de Estudos</a></li>
                        <li><a href="tela_ia.jsp" class="nav-item">Tutor</a></li>
                    </ul>
                </nav>
            </aside>

            <section class="chat-area" id="guideInterface">
                <%-- Se o plano ainda não foi gerado, mostra o formulário --%>
                <% if (studyPlan == null) { %>
                    <div class="config-form-container" style="padding: 40px;">
                        <h1>Gerador de Plano de Estudos</h1>
                        <p>Preencha os campos abaixo para que a IA crie um plano de estudos personalizado para você.</p>
                        
                        <form method="POST" action="guia_de_estudos.jsp" class="study-guide-form">
                            <div class="form-group">
                                <label for="prova">Prova do Vestibular:</label>
                                <select name="prova" id="prova" class="chat-input">
                                    <option value="ENEM">ENEM</option>
                                    <option value="FUVEST">FUVEST</option>
                                    <option value="UNICAMP">UNICAMP</option>
                                    <option value="Outro/Geral">Outro/Geral</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="data_prova">Data da Prova:</label>
                                <input type="date" name="data_prova" id="data_prova" class="chat-input" required>
                            </div>
                            <div class="form-group">
                                <label for="horas_semana">Horas de estudo por semana:</label>
                                <input type="number" name="horas_semana" id="horas_semana" class="chat-input" placeholder="Ex: 20" required>
                            </div>
                            <div class="form-group">
                                <label for="detalhes_extra">Detalhes ou Foco Principal (opcional):</label>
                                <textarea name="detalhes_extra" id="detalhes_extra" class="chat-input" rows="3" placeholder="Ex: Tenho mais dificuldade em matemática; Focar em biologia e química..."></textarea>
                            </div>
                            <button type="submit" class="restart-button">Gerar Plano de Estudos</button>
                        </form>
                    </div>
                <% } else { %>
                    <%-- Se o plano foi gerado, mostra o resultado --%>
                    <div class="study-plan-container">
                        <h1>Seu Plano de Estudos Personalizado</h1>
                        <div class="plan-content">
                            <%= studyPlan %>
                        </div>
                        <a href="guia_de_estudos.jsp" class="restart-button" style="margin-top: 20px;">Refazer Plano</a>
                    </div>
                <% } %>
            </section>
        </main>
    </div>
</body>
</html>
