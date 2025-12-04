@param String username
@param com.example.testprojectft.JournalEntry lastEntry
@param double weeklyAverage
@param String summary
@param String suggestions

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - AI Wellness Journal</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/NightTheme.css">
</head>
<body>

<nav class="navbar navbar-dark bg-dark px-3">
    <a class="navbar-brand d-flex align-items-center" href="/dashboard">
        <img src="/WJ_Logo.jpg" alt="AI Wellness Logo"
             style="height:36px; width:auto; margin-right:12px;
                border-radius:6px; object-fit:contain;">
        <span style="font-size:1.25rem; font-weight:600;">AI Wellness Journal</span>
    </a>

    <div>
        <a href="/entries" class="btn btn-outline-light me-2">Entries</a>
        <a href="/moodinsights" class="btn btn-outline-light me-2">Mood Insights</a>
        <a href="/logout" class="btn btn-danger">Logout</a>
    </div>
</nav>

<div class="container text-center mt-5 p-4 shadow rounded theme-card">
    <h1 class="fw-bold mb-3">Welcome back, ${username}!</h1>

    <div class="d-flex justify-content-center mb-4">
        <a href="/entries" class="btn btn-primary me-3">View Entries</a>
        <a href="/moodinsights" class="btn btn-secondary">Mood Insights</a>
    </div>

    <div class="container mt-4">
        <div class="card shadow-sm theme-card">
            <div class="card-body">
                <h4 class="mb-3">Recent Activity</h4>

                <p>
                    <strong>Last Entry:</strong><br>
                    @if(lastEntry != null)
                        ${lastEntry.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy"))} -
                        ${lastEntry.getContent() != null
                            ? (lastEntry.getContent().length() > 80
                                ? lastEntry.getContent().substring(0, 80) + "..."
                                : lastEntry.getContent())
                            : "No content available"}
                    @else
                        No entry yet.
                    @endif
                </p>

                <p><strong>AI Mood Summary:</strong><br>
                    ${summary != null ? summary : "No summary available."}
                </p>

                <p><strong>AI Suggestion:</strong><br>
                    ${suggestions != null ? suggestions : "No suggestions available."}
                </p>

                <p><strong>Average Mood This Week:</strong>
                    @if(weeklyAverage > 0)
                        ${"%.1f".formatted(weeklyAverage)} / 10
                    @else
                        No mood data yet.
                    @endif
                </p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
