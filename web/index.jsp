<%-- 
    Document   : index
    Created on : 19 de mai. de 2025, 08:37:39
    Author     : morat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
       
        
        <!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ReadAI - A Plataforma para Concursos e Vestibulares</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        /* Estilos Customizados para o Index.jsp */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Fonte mais moderna */
            background-color: #f0f2f5; /* Um cinza bem claro para o fundo */
            color: #333; /* Cor de texto padrão mais escura */
        }

        .navbar-custom { /* Para uma barra de navegação com cor de destaque */
            background-color: #0d6efd; /* Azul primário do Bootstrap */
            box-shadow: 0 2px 4px rgba(0,0,0,0.1); /* Sombra suave */
            padding-top: 1rem;
            padding-bottom: 1rem;
        }
        .navbar-custom .navbar-brand,
        .navbar-custom .nav-link,
        .navbar-custom .navbar-text {
            color: white !important; /* Força o texto e links do navbar para branco */
            font-weight: 500;
        }
        .navbar-custom .nav-link:hover {
            color: rgba(255, 255, 255, 0.75) !important; /* Levemente mais escuro no hover */
        }
        .navbar-custom .navbar-toggler-icon {
            filter: invert(1); /* Deixa o ícone do toggler branco */
        }

        .main-hero-section { /* Seção principal de boas-vindas */
            background-color: #0d6efd; /* Fundo azul para a seção principal */
            color: white; /* Texto branco */
            padding-top: 6rem; /* Mais espaçamento no topo */
            padding-bottom: 6rem; /* Mais espaçamento na base */
            min-height: calc(100vh - 72px); /* Ajuste para preencher a tela, subtraindo altura do navbar */
            display: flex;
            align-items: center; /* Centraliza o conteúdo verticalmente */
            position: relative; /* Para posicionar elementos animados ou de fundo */
            overflow: hidden; /* Garante que nada saia do container */
        }
        .main-hero-section h1 {
            font-size: 3.5rem; /* Fonte maior para o título principal */
            line-height: 1.2;
            margin-bottom: 1.5rem;
        }
        .main-hero-section p {
            font-size: 1.25rem; /* Fonte maior para o parágrafo */
            opacity: 0.9; /* Levemente transparente */
        }
        .main-hero-section .btn-primary {
            background-color: #ffc107; /* Cor de destaque (amarelo warning) para o botão */
            border-color: #ffc107;
            color: #333; /* Texto escuro no botão amarelo */
            font-weight: bold;
            padding: 0.8rem 2.5rem;
            border-radius: 50px; /* Botão mais arredondado */
            transition: all 0.3s ease; /* Transição suave no hover */
        }
        .main-hero-section .btn-primary:hover {
            background-color: #e0a800; /* Escurece no hover */
            border-color: #e0a800;
            transform: translateY(-2px); /* Efeito de leve levantamento */
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
        }

        /* Estilo para a imagem/gif na seção principal */
        .main-hero-image-container {
            display: flex;
            justify-content: center; /* Centraliza a imagem horizontalmente */
            align-items: center; /* Centraliza a imagem verticalmente */
            padding: 2rem; /* Espaçamento interno */
        }
        .main-hero-image-container img {
            max-width: 100%; /* Garante que a imagem não transborde */
            height: auto;
            border-radius: 15px; /* Bordas arredondadas */
            box-shadow: 0 8px 16px rgba(0,0,0,0.3); /* Sombra mais pronunciada */
            transition: transform 0.3s ease;
        }
        .main-hero-image-container img:hover {
            transform: scale(1.02); /* Leve zoom no hover */
        }

        /* Animação de fundo, se você for manter a 'background-animated' */
        /* Exemplo simples de animação, adapte ao seu 'background-animated' */
        /*
        .background-animated {
            // Estilos para o fundo animado
        }
        */

        /* Estilo para a seção "Features" (se for adicionar mais seções) */
        .features-section {
            padding: 4rem 0;
            background-color: white;
            box-shadow: inset 0 5px 10px rgba(0,0,0,0.05); /* Sombra interna sutil */
        }
        .features-section .feature-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s ease;
            text-align: center;
            padding: 1.5rem;
        }
        .features-section .feature-card:hover {
            transform: translateY(-5px);
        }
        .features-section .feature-icon {
            font-size: 3rem;
            color: #0d6efd; /* Cor primária do Bootstrap */
            margin-bottom: 1rem;
        }

        /* Estilo para o footer */
        .footer-custom {
            background-color: #343a40; /* Cinza escuro */
            color: white;
            padding: 2rem 0;
            text-align: center;
        }
        .footer-custom a {
            color: #ffc107; /* Links em amarelo */
            text-decoration: none;
        }
        .footer-custom a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <%@include file="WEB-INF/jspf/header.jspf"%>     
    <%@include file="WEB-INF/jspf/main.jspf"%>     
    <%@include file="WEB-INF/jspf/footer.jspf"%>     

    
   
</body>
</html>
