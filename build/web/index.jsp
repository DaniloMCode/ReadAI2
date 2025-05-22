<%-- 
    Document   : index
    Created on : 19 de mai. de 2025, 08:37:39
    Author     : morat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plataforma ReadAi</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="estilo/index.css">


    </head>
    <body>

        <!-- Cabeçalho -->
        <header class="bg-primary text-white py-3">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-3">
                        <a href="#" class="logo text-white text-decoration-none">
                            <h1>ReadAI</h1>
                        </a>
                    </div>

                    <div class="col-md-9 d-flex justify-content-end">
                        <nav class="navbar navbar-expand-md navbar-dark">
                            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                                <ul class="navbar-nav">
                                    <li class="nav-item">
                                        <a class="nav-link" href="#">Plano Escola</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#">Política de Privacidade</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#">Central de Ajuda</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#">Contato</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link btn btn-sm btn-info ml-md-2" href="pages/cadastro.jsp">Criar conta</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link btn btn-sm btn-info ml-md-2"href="pages/Login.jsp">Entrar</a>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
        </header>

        <main class="background-animated py-5">
            <div class="container">
                <section class="boas-vindas">
                    <!-- TEXTO -->
                    <div class="col-lg-6">
                        <div class="px-lg-4">
                            <h1 class="fw-bold mb-4 lh-base">
                                A plataforma feita para <span class="text-warning">Concursos</span> e <span class="text-warning">Vestibulares</span>
                            </h1>
                            <p class="fs-5">
                                Tenha acesso a conteúdos de qualidade, simulados inteligentes e dicas que vão turbinar seu desempenho.
                            </p>
                            <a href="#cadastro" class="btn btn-primary btn-lg mt-4 shadow-sm">
                                Comece Agora
                            </a>
                        </div>
                    </div>           
                </section>
            </div>
        </main>
        <footer class="bg-dark text-white py-3">
            <div class="container">
                <div class="row align-items-center">

                    <!-- Coluna esquerda -->
                    <div class="col-md-6 text-center text-md-start mb-2 mb-md-0">
                        <span class="footer-brand">&copy; ReadIA 2025</span> - Todos os direitos reservados. <br>
                        <a href="#" class="text-white-50 me-2">Política de privacidade</a> |
                        <a href="#" class="text-white-50 ms-2">Termos de uso</a>
                    </div>

                    <!-- Coluna direita -->
                    <div class="col-md-6 text-center text-md-end">
                        <nav class="footer-links d-inline-flex flex-wrap justify-content-center justify-content-md-end">
                            <a href="#" class="text-white-50">Diferenciais</a>
                            <a href="#" class="text-white-50">Benefícios</a>
                            <a href="#" class="text-white-50">Planos</a>
                            <a href="#" class="text-white-50">Contato</a>
                        </nav>
                        <div class="mt-1 small text-white-50">
                            Desenvolvido por <strong>Viptech - Smart Solutions</strong>
                        </div>
                    </div>

                </div>
            </div>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

    </body>
</html>
