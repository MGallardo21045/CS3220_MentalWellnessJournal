@param java.util.List<com.example.testprojectft.JournalEntry> entries
@param String username

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>New Entry</title>
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
        @if(username != null && !username.isEmpty())
            <span class="text-light small me-2">Signed in as <strong>${username}</strong></span>
            <a href="/logout" class="btn btn-danger btn-sm">Logout</a>
        @endif
    </div>
</nav>

<div class="container py-4">
    <div class="card mx-auto mt-5 shadow-sm theme-card" style="max-width:700px;">
        <div class="card-body">
            <h3 class="mb-3">Create New Entry</h3>

            <form method="post" action="/entries/new">

                <div class="mb-2">
                    <label class="form-label">Title</label>
                    <input name="title" class="form-control" required placeholder="Give your entry a title">
                </div>

                <div class="mb-2">
                    <label class="form-label">Mood (description)</label>
                    <input name="mood" class="form-control" placeholder="e.g. happy, anxious, stressed">
                </div>

                <div class="mb-2">
                    <label class="form-label">Mood Scale (1–10)</label>
                    <input type="range" name="moodScale" class="form-range" min="1" max="10" value="5"
                           oninput="this.nextElementSibling.value = this.value">
                    <output style="margin-left: 8px;">5</output>
                </div>

                <div class="mb-2">
                    <label class="form-label">Journal Content</label>
                    <textarea name="content" class="form-control" rows="6" required placeholder="Write your thoughts here..."></textarea>
                </div>

                <div class="mt-3">
                    <button class="btn btn-success">Save Entry</button>
                    <a href="/entries" class="btn btn-outline-light ms-2">Cancel</a>
                </div>

            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
