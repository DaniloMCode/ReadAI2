<%-- 
    Document   : cadastro
    Created on : 19 de mai. de 2025, 08:40:21
    Author     : morat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <title>Plataforma ReadAi</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../estilo/styleCadLog.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">

    </head>
    <body>
        <main>
            <!-- Conteúdo Principal -->

            <div class="text-center mb-4">

                <h2>Crie aqui sua conta ReadIA</h2>
            </div>
            <div id="container">
                <ul class="nav nav-tabs justify-content-center mb-4">
                    <li class="nav-item">
                        <a class="nav-link" id="login-tab" onclick="mostrarForm('login')">Entrar</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" id="cadastro-tab" onclick="mostrarForm('cadastro')">Criar conta</a>
                    </li>
                </ul>

                <form id="cadastro-form" class="active" action="/UsuarioServlet" method="post">
                    <div class="form-group mb-2">
                        <label for="cadastro-nome">Seu nome</label>
                        <input type="text" class="form-control" id="cadastro-nome" name="nome">
                    </div>
                    <div class="form-group mb-2">
                        <label for="cadastro-sobrenome">Seu sobrenome</label>
                        <input type="text" class="form-control" id="cadastro-sobrenome" name="sobrenome">
                    </div>
                    <div class="form-group mb-2">
                        <label for="cadastro-email">E-mail</label>
                        <input type="email" class="form-control" id="cadastro-email" name="email" required>
                    </div>
                    <div class="form-group mb-2">
                        <label for="cadastro-confirmarEmail">Confirmar e-mail</label>
                        <input type="email" class="form-control" id="cadastro-confirmarEmail" name="confirmarEmail" required>                    </div>
                    <div class="form-group mb-2">
                        <label for="cadastro-senha">Senha</label>
                        <input type="password" class="form-control" id="cadastro-senha" name="senha">
                    </div>
                    <div class="form-group mb-2">
                        <label for="cadastro-confirmarSenha">Confirmar senha</label>
                        <input type="password" class="form-control" id="cadastro-confirmarSenha" name="confirmarSenha">
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Criar conta</button>
                </form>

                <form id="login-form">
                    <div class="form-group mb-2">
                        <label for="login-email">E-mail</label>
                        <input type="email" class="form-control" id="login-email">
                    </div>
                    <div class="form-group mb-2">
                        <label for="login-senha">Senha</label>
                        <input type="password" class="form-control" id="login-senha">
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Entrar</button>
                </form>
            </div>
        </main>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">

        <script src="../Interatividade/interacaoLogCad.js"></script>
    </body>

</html>
