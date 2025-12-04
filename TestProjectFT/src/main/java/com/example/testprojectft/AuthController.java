package com.example.testprojectft;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        if (session.getAttribute("userId") != null) {
            return "redirect:/dashboard";
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {

        Optional<User> userOpt = userService.validateLogin(username, password);

        if (userOpt.isPresent()) {
            User u = userOpt.get();

            session.setAttribute("userId", u.getId());
            session.setAttribute("username", u.getUsername());
            session.setAttribute("fullName", u.getFullName());

            return "redirect:/dashboard";
        }

        model.addAttribute("error", "Invalid username or password");
        model.addAttribute("username", username);
        return "login";
    }

    @GetMapping("/register")
    public String registerPage(HttpSession session) {
        if (session.getAttribute("userId") != null) {
            return "redirect:/dashboard";
        }
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String fullName,
                           @RequestParam String username,
                           @RequestParam String password,
                           @RequestParam String confirmPassword,
                           HttpSession session,
                           Model model) {

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            model.addAttribute("fullName", fullName);
            model.addAttribute("username", username);
            return "register";
        }

        boolean success = userService.register(fullName, username, password);

        if (!success) {
            model.addAttribute("error", "Username already exists");
            model.addAttribute("fullName", fullName);
            model.addAttribute("username", username);
            return "register";
        }

        // Login immediately after successful registration
        Optional<User> userOpt = userService.validateLogin(username, password);
        userOpt.ifPresent(u -> {
            session.setAttribute("userId", u.getId());
            session.setAttribute("username", u.getUsername());
            session.setAttribute("fullName", u.getFullName());
        });

        return "redirect:/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    public Optional<User> findById(Long id) {
        return userService.findById(id);
    }
}
