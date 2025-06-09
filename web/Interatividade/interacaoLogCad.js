/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


/*function mostrarForm(formId) {
            const cadastroForm = document.getElementById('cadastro-form');
            const loginForm = document.getElementById('login-form');
            const cadastroTab = document.getElementById('cadastro-tab');
            const loginTab = document.getElementById('login-tab');
            const formTitle = document.querySelector('.text-center h2'); // Seleciona o título h2

            cadastroForm.classList.remove('active');
            loginForm.classList.remove('active');
            cadastroTab.classList.remove('active');
            loginTab.classList.remove('active');

            if (formId === 'cadastro') {
                cadastroForm.classList.add('active');
                cadastroTab.classList.add('active');
                formTitle.textContent = 'Crie aqui sua conta ReadIA'; // Atualiza o título
            } else if (formId === 'login') {
                loginForm.classList.add('active');
                loginTab.classList.add('active');
                formTitle.textContent = 'Entre na sua conta ReadIA'; // Atualiza o título
            }
        }

        // Inicialmente mostrar o formulário de cadastro
        mostrarForm('cadastro');
        
        
        
      // Item do menu clicado na sidebar fica visualmente destacado.  
        
        
        
   /*    document.addEventListener('DOMContentLoaded', function() {
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
});*/




const shared = Vue.reactive({session: null});
const sessionApp = Vue.createApp({
    data() {
        return {
            shared: shared,
            // Variável para controlar qual formulário está visível
            showLoginForm: true, // true: mostra login; false: mostra cadastro
            loaded: false, // Inicialmente false para não mostrar nada até verificar a sessão
            error: null, // Mensagem de erro para login ou cadastro
            message: null, // Mensagem de sucesso para login ou cadastro

            // Variáveis para o formulário de LOGIN
            loginUsername: '',
            loginPassword: '',
            data: null, // Dados da sessão do usuário logado

            // Variáveis para o formulário de CADASTRO (prefixo 'register' para evitar conflito)
            registerLogin: '',
            registerName: '',
            registerSobrenome: '',
            registerEmail: '',
            registerPassword: '',
            registerConfirmPassword: ''
        };
    },
    methods: {
        // Método para limpar mensagens de erro/sucesso ao trocar de formulário
        clearMessages() {
            this.error = null;
            this.message = null;
        },
        // Método genérico para requisições à API
        async request(url, method, data = null) {
            try {
                const options = {
                    method: method,
                    headers: {"Content-Type": "application/json"}
                };
                if (data) {
                    options.body = JSON.stringify(data);
                }
                const response = await fetch(url, options);
                const responseData = await response.json().catch(() => ({}));
                if (response.ok) {
                    return responseData;
                } else {
                    this.error = responseData.error || `Erro: ${response.status} ${response.statusText}`;
                    return null;
                }
            } catch (e) {
                this.error = "Erro de rede ou servidor: " + e.message;
                console.error("Erro na requisição:", e);
                return null;
        }
        },
        // --- Lógica de Sessão (Login/Logout) ---
        async loadSession() {
            const data = await this.request("/ReadAI2/api/session", "GET");
            if (data) {
                this.data = data; // Se houver sessão, armazena os dados do usuário
                this.error = null; // Limpa erros se a sessão for carregada com sucesso
                this.shared.session = this.data; // Atualiza o estado compartilhado
            } else {
                this.data = null; // Nenhuma sessão ativa
                this.shared.session = null;
                // Se o erro for "Não autorizado: nenhuma sessão ativa." (esperado), não exibe a mensagem de erro
                if (this.error === "Não autorizado: nenhuma sessão ativa." || this.error === "Unauthorized: no session") {
                    this.error = null;
                }
            }
            this.loaded = true; // Define loaded como true APÓS a verificação da sessão
        },
        async login() {
            this.clearMessages(); // Limpa mensagens ao tentar login
            if (!this.loginUsername || !this.loginPassword) {
                this.error = "Login e senha são obrigatórios.";
                return;
            }

            const data = await this.request(
                    "/ReadAI2/api/session",
                    "POST",
                    {"login": this.loginUsername, "password": this.loginPassword}
            );
            if (data) {
                this.data = data;
                this.error = null;
                this.message = "Login realizado com sucesso!";
                this.shared.session = this.data;
                // Limpar campos de login após sucesso
                this.loginUsername = '';
                this.loginPassword = '';
            } else {
                this.data = null;
                this.shared.session = null;
            }
        },
        async logout() {
            const data = await this.request("/ReadAI2/api/session", "DELETE");
            if (data) {
                this.data = null;
                this.error = null;
                this.message = "Logout realizado com sucesso!";
                this.shared.session = null;
            }
        },
        // --- Lógica de Cadastro (POST /api/users) ---
        async registerUser() {
            this.clearMessages(); // Limpa mensagens ao tentar cadastro

            // Validações no frontend
            if (!this.registerLogin || !this.registerName || !this.registerEmail || !this.registerPassword || !this.registerConfirmPassword) {
                this.error = "Todos os campos marcados são obrigatórios.";
                return;
            }
            if (this.registerPassword.length < 6) {
                this.error = "A senha deve ter pelo menos 6 caracteres.";
                return;
            }
            if (this.registerPassword !== this.registerConfirmPassword) {
                this.error = "As senhas não coincidem.";
                return;
            }

            const userData = {
                login: this.registerLogin,
                nome: this.registerName,
                sobrenome: this.registerSobrenome,
                email: this.registerEmail,
                password: this.registerPassword
            };
            const data = await this.request(
                    "/ReadAI2/api/users", // Endpoint correto para cadastro
                    "POST", // Método HTTP correto para cadastro
                    userData
                    );
            if (data) {
                this.message = data.message || "Usuário cadastrado com sucesso! Você pode fazer login agora.";
                this.error = null;
                // Limpar formulário de cadastro após sucesso
                this.registerLogin = '';
                this.registerName = '';
                this.registerSobrenome = '';
                this.registerEmail = '';
                this.registerPassword = '';
                this.registerConfirmPassword = '';
                // Opcional: Alternar para o formulário de login após o cadastro
                this.showLoginForm = true;
            } else {
                // O erro já é setado pelo método 'request'
            }
        }
    },
    mounted() {
        this.loadSession(); // Ao carregar a página, verifica se já há uma sessão
    }
});
sessionApp.mount('#session');
    





