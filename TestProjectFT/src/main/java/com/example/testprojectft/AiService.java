package com.example.testprojectft;

import org.springframework.ai.openai.OpenAiChatModel;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AiService {

    private final OpenAiChatModel chatModel;

    public AiService(OpenAiChatModel chatModel) {
        this.chatModel = chatModel;
    }

    public void analyze(JournalEntry entry) {
        try {
            String prompt = """
                Analyze the mood of the following journal entry and provide a short, friendly insight.

                RULES:
                - Output plain text only.
                - Do NOT use Markdown.
                - Do NOT use asterisks (*).
                - Emojis ARE allowed.
                - Keep the insight warm, supportive, and brief.

                Journal Entry:
                %s

                Insight:
            """.formatted(entry.getContent());

            String aiResult = chatModel.call(prompt).trim();
            entry.setAiInsight(aiResult);

        } catch (Exception e) {
            e.printStackTrace();
            entry.setAiInsight("Unable to analyze at this time.");
        }
    }

    public String generateMoodSummary(double avgMood, List<JournalEntry> entries) {
        try {
            String entrySample = String.join("\n",
                    entries.stream()
                            .limit(3)
                            .map(e -> "- " + e.getContent())
                            .toList()
            );

            String prompt = """
                Based on the journal mood data below, write a short, friendly mental health suggestion (maximum 2 sentences).

                RULES:
                - Output plain text only.
                - No Markdown.
                - No asterisks (*).
                - Emojis are allowed.
                - Keep it encouraging and supportive.
                - Avoid medical or therapeutic claims.

                Average Mood Score: %s

                Recent Journal Highlights:
                %s

                Summary:
            """.formatted(avgMood, entrySample);

            return chatModel.call(prompt).trim();

        } catch (Exception e) {
            return "Unable to analyze at this time.";
        }
    }

    public String generateSuggestions(double averageMood, List<JournalEntry> entries) {

        String recentEntries = String.join("\n",
                entries.stream()
                        .limit(3)
                        .map(e -> "- " + e.getContent())
                        .toList()
        );

        String prompt = """
            Provide three short wellness suggestions based on the user's average mood and recent journal entries.

            RULES:
            - Plain text only.
            - Do NOT use asterisks (*) for bullets or formatting.
            - Do NOT use Markdown.
            - Emojis ARE allowed.
            - Use ONLY emoji bullets such as "💡", "✨", "•", "→", or "-".
            - Each suggestion must be on its own line.
            - Keep the tone friendly, supportive, and warm.
            - Avoid medical or therapeutic advice.

            Average Mood: %s

            Recent Entries:
            %s

            Suggestions:
        """.formatted(averageMood, recentEntries);

        try {
            return chatModel.call(prompt).trim();
        } catch (Exception e) {
            return "Unable to generate suggestions at this time.";
        }
    }
}
