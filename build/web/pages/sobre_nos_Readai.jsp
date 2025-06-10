<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="model.User"%> 

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sobre Nós - READ IA</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="I_Style.css">
</head>
<body>
    <div class="app-container d-flex flex-column vh-100">
        <%-- Inclui o cabeçalho --%>
        <%@include file="../WEB-INF/jspf/header2.jspf"%>     

        <main class="d-flex flex-grow-1">
            <%-- Inclui a barra lateral --%>
            <%@include file="../WEB-INF/jspf/sider2.jspf"%>     

            <section class="chat-area flex-grow-1 p-4 overflow-auto">
                <div class="container py-5">
                    <div class="row justify-content-center">
                        <div class="col-lg-10 col-md-12">
                            <div class="card shadow-sm border-0">
                                <div class="card-body p-5">
                                    <h1 class="card-title text-center mb-4 text-primary">Sobre o READ IA: A Revolução do Estudo com Inteligência Artificial</h1>
                                    <p class="card-text lead text-center mb-5">
                                        No coração do READ IA, reside a visão de quatro estudantes apaixonados por tecnologia e educação da Fatec. Diante dos desafios que milhares de jovens e adultos enfrentam ao se preparar para vestibulares e concursos no Brasil, percebemos uma lacuna: a falta de ferramentas que combinassem acessibilidade, qualidade e personalização em larga escala.
                                    </p>
                                    <p class="card-text mb-4">
                                        Foi dessa percepção que nasceu o READ IA. Nosso projeto é mais do que uma plataforma de estudos; é um compromisso com a democratização do conhecimento. Acreditamos que a preparação para grandes desafios acadêmicos não precisa ser árdua ou exaustiva, mas sim inteligente, adaptável e, acima de tudo, eficaz.
                                    </p>

                                    <h2 class="h4 mt-5 mb-3 text-secondary">Nossa Missão:</h2>
                                    <p class="card-text mb-4">
                                        Capacitar estudantes de todo o Brasil a alcançarem seus objetivos acadêmicos, oferecendo uma experiência de estudo inovadora e de alta qualidade. Fazemos isso através da integração estratégica da Inteligência Artificial, que nos permite gerar conteúdo personalizado, identificar pontos fortes e fracos, e guiar cada usuário por um caminho de aprendizado otimizado.
                                    </p>

                                    <h2 class="h4 mt-5 mb-3 text-secondary">Por Que a Inteligência Artificial?</h2>
                                    <p class="card-text mb-2">A IA não é apenas uma ferramenta em nosso arsenal; é o motor que impulsiona a nossa inovação. Ela nos permite:</p>
                                    <ul class="list-unstyled mb-4">
                                        <li class="d-flex align-items-start mb-2">
                                            <i class="bi bi-check-circle-fill text-success me-2 mt-1"></i>
                                            <span>
                                                <strong>Personalizar o Conteúdo:</strong> Gerar questões e materiais de estudo sob medida para o nível e os interesses de cada usuário.
                                            </span>
                                        </li>
                                        <li class="d-flex align-items-start mb-2">
                                            <i class="bi bi-check-circle-fill text-success me-2 mt-1"></i>
                                            <span>
                                                <strong>Identificar Gaps de Conhecimento:</strong> Analisar o desempenho e sugerir áreas que precisam de mais atenção.
                                            </span>
                                        </li>
                                        <li class="d-flex align-items-start mb-2">
                                            <i class="bi bi-check-circle-fill text-success me-2 mt-1"></i>
                                            <span>
                                                <strong>Tornar o Estudo Acessível:</strong> Reduzir barreiras e oferecer um recurso de ponta a um público amplo.
                                            </span>
                                        </li>
                                        <li class="d-flex align-items-start mb-2">
                                            <i class="bi bi-check-circle-fill text-success me-2 mt-1"></i>
                                            <span>
                                                <strong>Garantir Qualidade e Relevância:</strong> Manter o conteúdo atualizado e alinhado com as exigências dos principais exames.
                                            </span>
                                        </li>
                                    </ul>
                                    <p class="card-text text-center mt-5 fs-5 fw-bold text-dark">
                                        No READ IA, transformamos a tecnologia em uma aliada do seu aprendizado. Somos movidos pela convicção de que, com as ferramentas certas, o caminho para o sucesso é mais claro e inspirador. Junte-se a nós e descubra como a IA pode revolucionar a sua jornada de estudos.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>

<%
    String userName = "Visitante"; // Valor padrão para não logado

    // Tenta recuperar o objeto User da sessão
    User currentUser = (User) session.getAttribute("loggedInUser");
    if (currentUser != null) {
        userName = currentUser.getNome(); // Assume que a classe User tem um método getName()
    }
    // Se você armazena apenas a String do nome na sessão (menos comum, mas possível):
    // String userNameFromSession = (String) session.getAttribute("userName");
    // if (userNameFromSession != null) {
    //     userName = userNameFromSession;
    // }
%>
<span class="nav-item text-white user-avatar-placeholder p-2 rounded-pill bg-secondary me-2">
                    <i class="bi bi-person-circle me-1"></i>Olá, <%= userName%>
                </span>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
