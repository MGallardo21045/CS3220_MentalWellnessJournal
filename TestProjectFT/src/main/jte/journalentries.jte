@param java.util.List<com.example.testprojectft.JournalEntry> entries
@param String username

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Journal Entries</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/NightTheme.css">
</head>
<body>

<nav class="navbar navbar-dark bg-dark px-3 mb-4">
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

<div class="container-fluid entries-container py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>Your Journal Entries</h3>
        <a class="btn btn-success" href="/entries/new">+ New Entry</a>
    </div>

    @if(entries == null || entries.isEmpty())
        <p class="text-muted">No entries found.</p>
    @endif

    @for(com.example.testprojectft.JournalEntry e : entries)
        <div class="card mb-3 shadow-sm theme-card">
            <div class="card-body">

                <h5 class="card-title">${e.getTitle()}</h5>

                <h6 class="card-subtitle mb-2 text-muted">
                    ${e.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"))}
                </h6>

                @if(e.getMoodScale() != null)
                    <span class="badge bg-info mb-2">Mood: ${e.getMoodScale()}</span>
                @endif

                <p class="card-text">
                    ${e.getContent() != null ? e.getContent().substring(0, Math.min(120, e.getContent().length())) + (e.getContent().length() > 120 ? "..." : "") : ""}
                </p>

                <a href="${"/entries/" + e.getId()}" class="btn btn-secondary btn-sm">View</a>
                <a href="${"/entries/" + e.getId() + "/edit"}" class="btn btn-primary btn-sm">Edit</a>

                <form method="post" action="${"/entries/" + e.getId() + "/delete"}" class="d-inline"
                      onsubmit="return confirm('Delete this entry?');">
                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                </form>

            </div>
        </div>
    @endfor

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
