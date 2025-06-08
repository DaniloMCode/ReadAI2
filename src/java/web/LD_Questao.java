package web;

import java.util.List;

public class LD_Questao {
    private String enunciado;
    private List<String> alternativas;
    private String respostaCorreta;
    private String justificativa;
    private String respostaDoUsuario; // Para guardar o que o usuário escolheu

    // Getters e Setters (pode ser gerado pela IDE)
    public String getEnunciado() { return enunciado; }
    public void setEnunciado(String enunciado) { this.enunciado = enunciado; }
    public List<String> getAlternativas() { return alternativas; }
    public void setAlternativas(List<String> alternativas) { this.alternativas = alternativas; }
    public String getRespostaCorreta() { return respostaCorreta; }
    public void setRespostaCorreta(String respostaCorreta) { this.respostaCorreta = respostaCorreta; }
    public String getJustificativa() { return justificativa; }
    public void setJustificativa(String justificativa) { this.justificativa = justificativa; }
    public String getRespostaDoUsuario() { return respostaDoUsuario; }
    public void setRespostaDoUsuario(String respostaDoUsuario) { this.respostaDoUsuario = respostaDoUsuario; }
}