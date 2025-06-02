<%-- 
    Document   : index
    Created on : 26 de mai. de 2025, 12:28:52
    Author     : Nicholas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>POO_interface</title>
        <link rel="stylesheet" href="../WEB-INF/Addictions/style.css">
    </head>
    <body>
        <div>   
            <button class = "botao_imagem" onclick="ExibirBarraLateral()">
                <img src="../imagem/opcoes.png" alt="Ícone do botão" class = "icone">
            </button>
            <div class = "sidebar" id = "minha_sidebar">
                <div >
                
                    <a href="#" onclick = "">Menu Principal</a> <br>
                    <a href="#" onclick = "">Sobre</a> <br>
                    <a href="#" onclick = "">Serviços</a> <br>
                    <a href="#" onclick = "">Contato</a> <br>
                    <a href="#" onclick = "">Sobre nós</a> <br>
                
                </div>
            </div>
        </div> 
    <div id = "main" class = "main">
        <div id = "chatArea" class = "chat-area">
            <h1 id = "boasVindas" class = "cinza transparencia central centralizado">
                Bem-vindo(a) ao ReadAI!
            </h1>
            <div id = "chatarea"></div>
        </div>

        <div class = "container centralizado">
            <input type = "text" placeholder = "Olá, como posso te ajudar?" id = "Caixa_texto" class = "entrada_prompt">
            <button class = "botao" onclick = "enviarMensagem()">enviar</button>
        </div>
    </div>
    <script>

        function ExibirBarraLateral() {
            var barralateral = document.getElementById("minha_sidebar");
            var botao = document.querySelector(".botao_imagem");

            barralateral.classList.toggle("open");
            
            botao.classList.toggle("move");
        }

   
   
        function enviarMensagem() {
            var entrada = document.getElementById("Caixa_texto");
            var texto = entrada.value.trim();
            var BoasVindas = document.getElementById("boasVindas");
            var chatArea = document.getElementById("chatarea");
            
            if (texto != "") {
                if (BoasVindas) {
                    boasVindas.style.display = "none";
                }
                
                var novaMensagem = document.createElement("div");
                novaMensagem.classList.add("mensagem");
                novaMensagem.textContent = texto;
                
                //var container = document.querySelector(".container");
                //container.parentNode.insertBefore(novaMensagem, container);
                
                chatArea.appendChild(novaMensagem);
                entrada.value = "";
                
                chatArea.scrollTop = chatArea.scrollHeight;
            }
            

            
        }

    </script>

    </body>
</html>
