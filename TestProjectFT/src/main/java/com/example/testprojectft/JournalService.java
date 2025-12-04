package com.example.testprojectft;

import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class JournalService {

    private final TestProjectFTRepository repo;

    public JournalService(TestProjectFTRepository repo) {
        this.repo = repo;
    }

    public List<JournalEntry> getEntriesFor(User user) {
        return repo.findByUserIdOrderByCreatedAtDesc(user.getId());
    }

    public Optional<JournalEntry> getById(Long id) {
        return repo.findById(id);
    }

    public void save(JournalEntry entry) {
        if (entry.getId() != null) {
            repo.findById(entry.getId()).ifPresent(existing -> {
                if (entry.getAiInsight() == null || entry.getAiInsight().isBlank()) {
                    if (existing.getContent().equals(entry.getContent())) {
                        entry.setAiInsight(existing.getAiInsight());
                    }
                }
            });
        }
        repo.save(entry);
    }


    public void delete(Long id) {
        repo.deleteById(id);
    }

    public double getAverageMoodFor(User user) {
        return getEntriesFor(user).stream()
                .map(JournalEntry::getMoodScale)
                .filter(value -> value != null && value >= 1 && value <= 10)
                .mapToInt(Integer::intValue)
                .average()
                .orElse(0);
    }

    public JournalEntry getLatestEntryFor(User user) {
        return repo.findTopByUserIdOrderByCreatedAtDesc(user.getId())
                .orElse(null);
    }

    public double getWeeklyAverageMoodFor(User user) {

        List<JournalEntry> recent = repo.findByUserIdAndCreatedAtAfterOrderByCreatedAtDesc(
                user.getId(),
                java.time.LocalDateTime.now().minusDays(7)
        );

        return recent.stream()
                .filter(e -> e.getMoodScale() != null)
                .mapToInt(JournalEntry::getMoodScale)
                .average()
                .orElse(0);
    }

}

