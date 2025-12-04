package com.example.testprojectft;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "JournalEntryData")
public class JournalEntry {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id")
    private User user;

    private String title;

    @Column(columnDefinition = "TEXT")
    private String content;

    private String mood;

    @Column(name = "mood_scale")
    private Integer moodScale;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(columnDefinition = "TEXT")
    private String aiInsight;

    public JournalEntry() {
        this.createdAt = LocalDateTime.now();
    }

    public JournalEntry(User user, String title, String content, String mood, Integer moodScale) {
        this.user = user;
        this.title = title;
        this.content = content;
        this.mood = mood;
        this.moodScale = moodScale;
        this.createdAt = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getMood() { return mood; }
    public void setMood(String mood) { this.mood = mood; }

    public Integer getMoodScale() { return moodScale; }
    public void setMoodScale(Integer moodScale) { this.moodScale = moodScale; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public String getAiInsight() { return aiInsight; }
    public void setAiInsight(String aiInsight) { this.aiInsight = aiInsight; }
}
