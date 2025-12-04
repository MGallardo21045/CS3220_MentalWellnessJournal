package com.example.testprojectft;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Optional;

@Controller
public class HomeController {

    private final AuthController authController;
    private final JournalService journalService;
    private final AiService aiService;

    public HomeController(AuthController authController,
                          JournalService journalService,
                          AiService aiService) {
        this.authController = authController;
        this.journalService = journalService;
        this.aiService = aiService;
    }

    @GetMapping("/")
    public String home(HttpSession session, Model model) {
        Long uid = (Long) session.getAttribute("userId");

        if (uid != null) {
            authController.findById(uid).ifPresent(u -> model.addAttribute("username", u.getUsername()));
            return "homepage";
        } else {
            return "redirect:/login";
        }
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";

        Optional<User> userOpt = authController.findById(userId);
        if (userOpt.isEmpty()) return "redirect:/login";

        User user = userOpt.get();

        model.addAttribute("username", user.getUsername());

        JournalEntry lastEntry = journalService.getLatestEntryFor(user);

        double weeklyAverageRaw = journalService.getWeeklyAverageMoodFor(user);
        String weeklyAverage = String.format("%.1f", weeklyAverageRaw);

        String summary = (lastEntry != null && lastEntry.getMoodScale() != null)
                ? aiService.generateMoodSummary(lastEntry.getMoodScale(), List.of(lastEntry))
                : "No recent entry to analyze.";

        String suggestions = aiService.generateSuggestions(weeklyAverageRaw, List.of());

        model.addAttribute("lastEntry", lastEntry);
        model.addAttribute("weeklyAverage", weeklyAverageRaw);
        model.addAttribute("summary", summary);
        model.addAttribute("suggestions", suggestions);

        return "dashboard";
    }
}
