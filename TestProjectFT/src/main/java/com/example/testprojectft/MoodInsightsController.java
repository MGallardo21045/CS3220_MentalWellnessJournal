package com.example.testprojectft;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Optional;

@Controller
public class MoodInsightsController {

    private final JournalService journalService;
    private final AuthController authController;
    private final AiService aiService;

    public MoodInsightsController(JournalService journalService,
                                  AuthController authController,
                                  AiService aiService) {
        this.journalService = journalService;
        this.authController = authController;
        this.aiService = aiService;
    }

    @GetMapping("/moodinsights")
    public String insights(HttpSession session, Model model) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";

        Optional<User> userOpt = authController.findById(userId);
        if (userOpt.isEmpty()) return "redirect:/login";

        User user = userOpt.get();

        List<JournalEntry> entries = journalService.getEntriesFor(user);

        for (JournalEntry entry : entries) {
            if (entry.getAiInsight() == null || entry.getAiInsight().isBlank()) {
                try {
                    aiService.analyze(entry);
                    journalService.save(entry);
                } catch (Exception ignored) {}
            }
        }

        double averageMoodRaw = journalService.getAverageMoodFor(user);
        String averageMood = String.format("%.1f", averageMoodRaw);

        String summary = aiService.generateMoodSummary(averageMoodRaw, entries);
        String suggestions = aiService.generateSuggestions(averageMoodRaw, entries);

        model.addAttribute("entries", entries);
        model.addAttribute("averageMood", averageMoodRaw);
        model.addAttribute("summary", summary);
        model.addAttribute("suggestions", suggestions);

        return "moodinsights";
    }

}
