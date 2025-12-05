package com.military.backend;

import org.springframework.web.bind.annotation.*;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class MessageController {

    @PostMapping("/login")
    public Map<String, String> login(@RequestParam String username,
                                     @RequestParam String password) {
        Map<String, String> res = new HashMap<>();
        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                "SELECT role FROM users WHERE username=? AND password=?");

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                res.put("status", "ok");
                res.put("role", rs.getString("role"));
            } else {
                res.put("status", "error");
                res.put("message", "Invalid credentials");
            }

        } catch (Exception e) {
            res.put("status", "error");
            res.put("message", "Server error");
        }
        return res;
    }

    @PostMapping("/send")
    public Map<String, String> send(@RequestParam String message) {
        Map<String, String> res = new HashMap<>();
        try (Connection con = DBConnection.getConnection()) {

            String encrypted = AESUtil.encrypt(message);

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO messages(content) VALUES (?)");

            ps.setString(1, encrypted);
            ps.executeUpdate();

            res.put("status", "ok");
            res.put("message", "Message stored securely");

        } catch (Exception e) {
            res.put("status", "error");
            res.put("message", "DB error");
        }
        return res;
    }

    @GetMapping("/message/latest")
    public Map<String, String> latest() {
        Map<String, String> res = new HashMap<>();
        try (Connection con = DBConnection.getConnection()) {

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(
                "SELECT content FROM messages ORDER BY id DESC LIMIT 1");

            if (rs.next()) {
                String enc = rs.getString("content");
                String dec = AESUtil.decrypt(enc);
                res.put("status", "ok");
                res.put("message", dec);
            } else {
                res.put("status", "error");
                res.put("message", "No messages found");
            }

        } catch (Exception e) {
            res.put("status", "error");
            res.put("message", "Server error");
        }
        return res;
    }
}
