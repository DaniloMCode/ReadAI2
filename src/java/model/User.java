/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.sql.*;
import webb.AppListene;

/**
 *
 * @author morat
 */
public class User {

    private long rowId;
    private String login;
    private String nome;
    private String sobrenome;
    private String email;
    private String passwordHash;

    public static String getCreateStatement() {
        return "CREATE TABLE IF NOT EXISTS usuario("
                + " login VARCHAR(100) UNIQUE NOT NULL,"
                + " nome VARCHAR(200) NOT NULL,"
                + " sobrenome VARCHAR(200),"
                + " email VARCHAR(100) NOT NULL,"
                + " password_hash TEXT NOT NULL"
                + ")";
    }
    
    
    

    public static ArrayList<User> getUsuarios() throws Exception {
        ArrayList<User> list = new ArrayList<>();
        Connection con = AppListene.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT rowid, * from usuario");
        while (rs.next()) {
            long rowId = rs.getLong("rowid");
            String login = rs.getString("login");
            String nome = rs.getString("nome");
            String sobrenome = rs.getString("sobrenome");
            String email = rs.getString("email");
            String passwordHash = rs.getString("password_hash");
            list.add(new User(rowId, login, nome, sobrenome, email, passwordHash));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }

    public static User getUsuario(String login, String password) throws Exception {
        User user = null;
        Connection con = AppListene.getConnection();
        String sql = "SELECT rowid, * FROM usuario WHERE login=? AND password_hash=?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, login);
        stmt.setString(2, AppListene.getMd5Hash(password));
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            long rowId = rs.getLong("rowid");
            String nome = rs.getString("nome");
            String sobrenome = rs.getString("sobrenome");
            String email = rs.getString("email");
            String passwordHash = rs.getString("password_hash");
            user = new User(rowId, login, nome, sobrenome, email, passwordHash);
        }
        rs.close();
        stmt.close();
        con.close();
        return user;
    }

    public static void insertUsuario(String login, String nome, String sobrenome, String email, String password) throws Exception {
        Connection con = AppListene.getConnection();
        String sql = "INSERT INTO usuario(login, nome, sobrenome, email, password_hash)"
                + "VALUES(?,?,?,?,?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, login);
        stmt.setString(2, nome);
        stmt.setString(3, sobrenome);
        stmt.setString(4, email);
        stmt.setString(5, AppListene.getMd5Hash(password));
        stmt.execute();
        stmt.close();
        con.close();
    }

    public static void updatetUsuario(String login, String nome, String sobrenome, String email, String password) throws Exception {
        Connection con = AppListene.getConnection();
        String sql = "UPDATE usuario SET  nome=?, sobrenome=?, email=?, password_hash=? WHERE login=?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, nome);
        stmt.setString(2, sobrenome);
        stmt.setString(3, email);
        stmt.setString(4, AppListene.getMd5Hash(password));
        stmt.setString(5, login);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public static void deletetUser(long rowId) throws Exception {
        Connection con = AppListene.getConnection();
        String sql = "DELETE FROM usuario WHERE rowid = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setLong(1, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public User(long rowId, String login, String nome, String sobrenome, String email, String passwordHash) {
        this.rowId = rowId;
        this.login = login;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.email = email;
        this.passwordHash = passwordHash;
    }

    public User(String nome, String sobrenome, String email, String passwordHash) {
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.email = email;
        this.passwordHash = passwordHash;
    }

    public long getRowId() {
        return rowId;
    }

    public void setRowId(long rowId) {
        this.rowId = rowId;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
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

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

}
