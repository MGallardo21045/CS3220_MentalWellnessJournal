package com.example.testprojectft;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.CrudRepository;

public interface TestProjectFTRepository extends CrudRepository<JournalEntry, Long> {
    List<JournalEntry> findByUserIdOrderByCreatedAtDesc(Long userId);

    Optional<JournalEntry> findTopByUserIdOrderByCreatedAtDesc(Long userId);

    List<JournalEntry> findByUserIdAndCreatedAtAfterOrderByCreatedAtDesc(Long userId, LocalDateTime createdAfter);
}