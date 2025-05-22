package ClasseConsultaDB;

import java.sql.*;
import java.util.ArrayList;

public class Usuario {

    public static final String CLASS_NAME = "org.sqlite.JDBC";
    public static final String URL = "jdbc:sqlite:usuario.db";

    public static void createTable() {
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();
            stmt.execute("create table if not exists usuario(nome varchar not null, sobrenome varchar, email varchar not null, confirmacaoEmail varchar"
                    + ", senha varchar not null)");
            stmt.close();
            con.close();
        } catch (Exception ex) {
            Exception exception = ex;
        }
    }

    public static Connection getConnection() throws Exception {
        Class.forName(CLASS_NAME);
        return DriverManager.getConnection(URL);

    }

    public static ArrayList<Usuario> getList() throws Exception {
        ArrayList<Usuario> list = new ArrayList<>();
        Connection con = getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from usuario");
        while (rs.next()) {
            String nome = rs.getString("nome");
            String sobrenome = rs.getString("sobrenome");
            String email = rs.getString("email");
            String confirmacaoEmail = rs.getString("confirmacaoEmail");
            String senha = rs.getString("senha");
            Usuario u = new Usuario(nome, sobrenome, email, confirmacaoEmail, senha);
            list.add(u);

        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }

    public static void addUsuario(String nome, String sobrenome, String email, String confirmacaoEmail, String senha) throws Exception {

        Connection con = getConnection();

        String sql = "INSERT INTO usuario (nome, sobrenome, email, confirmacaoEmail, senha) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = con.prepareStatement(sql);

        stmt.setString(1, nome);
        stmt.setString(2, sobrenome);
        stmt.setString(3, email);
        stmt.setString(4, confirmacaoEmail);
        stmt.setString(5, senha);

        stmt.executeUpdate();

        stmt.close();
        con.close();
    }
    
        public static ArrayList<Usuario> list = new ArrayList<>();

    private String nome;
    private String sobrenome;
    private String email;
    private String confirmacaoEmail;
    private String senha;

    public Usuario(String nome, String sobrenome, String email, String confirmacaoEmail, String senha) {
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.email = email;
        this.confirmacaoEmail = confirmacaoEmail;
        this.senha = senha;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSobrenome() {
        return sobrenome;
    }

    public void setSobrenome(String sobrenome) {
        this.sobrenome = sobrenome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getConfirmacaoEmail() {
        return confirmacaoEmail;
    }

    public void setConfirmacaoEmail(String confirmacaoEmail) {
        this.confirmacaoEmail = confirmacaoEmail;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

}
