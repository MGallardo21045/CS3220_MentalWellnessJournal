package com.example.testprojectft;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.time.LocalDateTime;
import java.util.Optional;

@Controller
@RequestMapping("/entries")
public class JournalController {

    private final AuthController authController;
    private final AiService aiService;
    private final TestProjectFTRepository repo;

    public JournalController(AuthController authController,
                             AiService aiService,
                             TestProjectFTRepository repo) {
        this.authController = authController;
        this.aiService = aiService;
        this.repo = repo;
    }

    @ModelAttribute
    public void addUsernameToModel(HttpSession session, Model model) {
        currentUser(session).ifPresent(user -> model.addAttribute("username", user.getUsername()));
    }

    private Optional<User> currentUser(HttpSession session) {
        Long uid = (Long) session.getAttribute("userId");
        if (uid == null) return Optional.empty();
        return authController.findById(uid);
    }

    @GetMapping
    public String list(Model model, HttpSession session) {
        Optional<User> u = currentUser(session);
        if (u.isEmpty()) return "redirect:/login";

        model.addAttribute("entries", repo.findByUserIdOrderByCreatedAtDesc(u.get().getId()));
        return "journalentries";
    }

    @GetMapping("/new")
    public String newEntry(HttpSession session) {
        if (currentUser(session).isEmpty()) return "redirect:/login";
        return "newentry";
    }

    @PostMapping("/new")
    public String create(@RequestParam String title,
                         @RequestParam String content,
                         @RequestParam(required = false) String mood,
                         @RequestParam(required = false) Integer moodScale,
                         HttpSession session, Model model) {

        Optional<User> u = currentUser(session);
        if (u.isEmpty()) return "redirect:/login";

        JournalEntry entry = new JournalEntry();
        entry.setUser(u.get());
        entry.setTitle(title);
        entry.setContent(content);
        entry.setMood(mood);
        entry.setMoodScale(moodScale);
        entry.setCreatedAt(LocalDateTime.now());

        try {
            aiService.analyze(entry);
            repo.save(entry);
            model.addAttribute("success", "Journal entry created successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "There was an issue saving the journal entry. Please try again.");
            return "newentry";
        }

        return "redirect:/entries/" + entry.getId();
    }

    @GetMapping("/{id}")
    public String view(@PathVariable Long id, HttpSession session, Model model) {
        Optional<User> u = currentUser(session);
        if (u.isEmpty()) return "redirect:/login";

        return repo.findById(id)
                .filter(e -> e.getUser().getId().equals(u.get().getId()))
                .map(e -> {
                    model.addAttribute("entry", e);
                    return "viewentry";
                })
                .orElse("redirect:/entries");
    }

    @GetMapping("/{id}/edit")
    public String editPage(@PathVariable Long id, HttpSession session, Model model) {
        Optional<User> u = currentUser(session);
        if (u.isEmpty()) return "redirect:/login";

        return repo.findById(id)
                .filter(e -> e.getUser().getId().equals(u.get().getId()))
                .map(e -> {
                    model.addAttribute("entry", e);
                    return "editentry";
                })
                .orElse("redirect:/entries");
    }

    @PostMapping("/{id}/edit")
    public String edit(@PathVariable Long id,
                       @RequestParam String title,
                       @RequestParam String content,
                       @RequestParam(required = false) String mood,
                       @RequestParam(required = false) Integer moodScale,
                       HttpSession session, Model model) {

        Optional<User> u = currentUser(session);
        if (u.isEmpty()) return "redirect:/login";

        return repo.findById(id)
                .filter(e -> e.getUser().getId().equals(u.get().getId()))
                .map(e -> {

                    e.setTitle(title);
                    e.setContent(content);
                    e.setMood(mood);
                    e.setMoodScale(moodScale);

                    aiService.analyze(e);

                    try {
                        repo.save(e);
                        model.addAttribute("success", "Journal entry updated successfully!");
                    } catch (Exception ex) {
                        model.addAttribute("error", "There was an issue updating the journal entry. Please try again.");
                        return "editentry";
                    }
                    return "redirect:/entries/" + e.getId();
                })
                .orElse("redirect:/entries");
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, HttpSession session) {
        Optional<User> u = currentUser(session);
        if (u.isEmpty()) return "redirect:/login";

        return repo.findById(id)
                .filter(e -> e.getUser().getId().equals(u.get().getId()))
                .map(e -> {
                    repo.delete(e);
                    return "redirect:/entries";
                })
                .orElse("redirect:/entries");
    }
}
