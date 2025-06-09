<!-- montar_lista.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Montar Lista</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div id="app" class="container" style="max-width: 600px;">
    <div class="card shadow-sm">
        <div class="card-body">
            <h3 class="card-title mb-4 text-center">Montar Lista</h3>
            <form @submit.prevent="addItem" class="row g-2 mb-4">
                <div class="col-9">
                    <input type="text" v-model="newItem" class="form-control" placeholder="Digite um item..." required>
                </div>
                <div class="col-3 d-grid">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-plus-circle"></i> Adicionar
                    </button>
                </div>
            </form>
            <ul class="list-group mb-3" v-if="items.length">
                <li class="list-group-item d-flex justify-content-between align-items-center" v-for="(item, idx) in items" :key="idx">
                    {{ item }}
                    <button class="btn btn-sm btn-outline-danger" @click="removeItem(idx)">
                        <i class="bi bi-trash"></i>
                    </button>
                </li>
            </ul>
            <div v-else class="text-center text-muted mb-3">
                Nenhum item na lista.
            </div>
            <div class="d-grid">
                <button class="btn btn-success" :disabled="!items.length" @click="saveList">
                    <i class="bi bi-save"></i> Salvar Lista
                </button>
            </div>
            <div v-if="successMsg" class="alert alert-success mt-3 text-center">
                {{ successMsg }}
            </div>
        </div>
    </div>
</div>

<script>
// Código Vue 3
const app = Vue.createApp({
    data() {
        return {
            newItem: '',
            items: [],
            successMsg: ''
        };
    },
    methods: {
        addItem() {
            if (this.newItem.trim()) {
                this.items.push(this.newItem.trim());
                this.newItem = '';
                this.successMsg = ''; // Limpa mensagem de sucesso ao adicionar novo item
            }
        },
        removeItem(idx) {
            this.items.splice(idx, 1);
            this.successMsg = ''; // Limpa mensagem de sucesso ao remover item
        },
        saveList() {
            // Aqui você pode fazer um fetch/AJAX para salvar no backend se desejar
            // Exemplo (usando fetch, você precisaria de um endpoint no seu backend):
            /*
            fetch('/api/listas', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ items: this.items })
            })
            .then(response => response.json())
            .then(data => {
                this.successMsg = 'Lista salva com sucesso!';
                // Opcional: Limpar lista após salvar
                // this.items = [];
            })
            .catch(error => {
                console.error('Erro ao salvar a lista:', error);
                this.successMsg = 'Erro ao salvar a lista.';
            });
            */
            this.successMsg = 'Lista salva com sucesso!'; // Mensagem temporária
        }
    }
});

// Monta o aplicativo Vue no elemento com id="app"
app.mount('#app');
</script>

</body>
</html>




















<!--<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Montar Lista</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">ReadAI2</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a href="cadastro2.jsp" class="nav-link">Cadastro</a>
                </li>
                <li class="nav-item">
                    <a href="portal.jsp" class="nav-link">Portal</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div id="app" class="container" style="max-width: 600px;">
    <div class="card shadow-sm">
        <div class="card-body">
            <h3 class="card-title mb-4 text-center">Montar Lista</h3>
            <form @submit.prevent="addItem" class="row g-2 mb-4">
                <div class="col-9">
                    <input type="text" v-model="newItem" class="form-control" placeholder="Digite um item..." required>
                </div>
                <div class="col-3 d-grid">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-plus-circle"></i> Adicionar
                    </button>
                </div>
            </form>
            <ul class="list-group mb-3" v-if="items.length">
                <li class="list-group-item d-flex justify-content-between align-items-center" v-for="(item, idx) in items" :key="idx">
                    {{ item }}
                    <button class="btn btn-sm btn-outline-danger" @click="removeItem(idx)">
                        <i class="bi bi-trash"></i>
                    </button>
                </li>
            </ul>
            <div v-else class="text-center text-muted mb-3">
                Nenhum item na lista.
            </div>
            <div class="d-grid">
                <button class="btn btn-success" :disabled="!items.length" @click="saveList">
                    <i class="bi bi-save"></i> Salvar Lista
                </button>
            </div>
            <div v-if="successMsg" class="alert alert-success mt-3 text-center">
                {{ successMsg }}
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
<script>
new Vue({
    el: '#app',
    data: {
        newItem: '',
        items: [],
        successMsg: ''
    },
    methods: {
        addItem() {
            if (this.newItem.trim()) {
                this.items.push(this.newItem.trim());
                this.newItem = '';
                this.successMsg = '';
            }
        },
        removeItem(idx) {
            this.items.splice(idx, 1);
            this.successMsg = '';
        },
        saveList() {
            // Aqui você pode fazer um fetch/AJAX para salvar no backend se desejar
            this.successMsg = 'Lista salva com sucesso!';
        }
    }
});
</script>
</body>
</html>-->