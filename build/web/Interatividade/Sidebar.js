/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


// Item do menu clicado na sidebar fica visualmente destacado.  
        
        
        
      document.addEventListener('DOMContentLoaded', function() {
    const sidebarNav = document.getElementById('login-tab');
    const navLinks = sidebarNav.querySelectorAll('nav-link');

    navLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            // Remover a classe 'active' de todos os itens da lista
            sidebarNav.querySelectorAll('.nav-item').forEach(item => {
                item.classList.remove('active');
            });

            // Adicionar a classe 'active' ao item da lista pai do link clicado
            this.parentNode.classList.add('active');

            // O navegador seguirá o href do link para a nova página
        });

        // Opcional: Adicionar a classe 'active' ao item correspondente à página atual ao carregar
        const currentPage = window.location.pathname.split('/').pop(); // Obtém o nome do arquivo da URL
        if (link.getAttribute('href') === currentPage) {
            link.parentNode.classList.add('active');
        }
    });
});





