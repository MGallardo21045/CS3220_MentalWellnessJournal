@param com.example.testprojectft.JournalEntry entry
@param String username

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${entry.getTitle()}</title>
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

<div class="container py-5">

    <div class="card shadow-sm theme-card">
        <div class="card-body">
            <h3 class="card-title">${entry.getTitle()}</h3>

            <h6 class="card-subtitle mb-3 text-muted">
                ${entry.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"))}
                <br>
                Mood:
                ${
                    entry.getMoodScale() != null
                        ? entry.getMoodScale() + " / 10"
                        : (entry.getMood() != null ? entry.getMood() : "—")
                }
            </h6>

            <p class="card-text" style="white-space: pre-line;">
                ${entry.getContent()}
            </p>

            @if(entry.getAiInsight() != null && !entry.getAiInsight().isBlank())
                <div class="alert alert-secondary mt-3 theme-card">
                    <strong>AI Insight:</strong><br>
                    ${entry.getAiInsight()}
                </div>
            @endif

            <div class="mt-4">
                <a href="/entries" class="btn btn-outline-light">Back</a>
                <a href="${"/entries/" + entry.getId() + "/edit"}" class="btn btn-primary">Edit</a>

                <form method="post" action="${"/entries/" + entry.getId() + "/delete"}" class="d-inline">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
