@param com.example.testprojectft.JournalEntry entry
@param String username

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Entry</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/NightTheme.css">
</head>
<body>

<div class="container">
    <div class="card mx-auto mt-5 shadow-sm theme-card" style="max-width:700px;">
        <div class="card-body">
            <h3 class="mb-3">Edit Entry</h3>

            <form method="post" action="${"/entries/" + entry.getId() + "/edit"}">

                <div class="mb-3">
                    <label class="form-label">Title</label>
                    <input name="title" value="${entry.getTitle()}" class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label">Mood</label>
                    <input name="mood" value="${entry.getMood() != null ? entry.getMood() : ""}" class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label">Mood (1-10)</label>
                    <input type="range" name="moodScale" class="form-range"
                           min="1" max="10" value="${entry.getMoodScale() != null ? entry.getMoodScale() : 5}"
                           oninput="this.nextElementSibling.value = this.value">
                    <output>${entry.getMoodScale() != null ? entry.getMoodScale() : 5}</output>
                </div>

                <div class="mb-3">
                    <label class="form-label">Content</label>
                    <textarea name="content" rows="6" class="form-control">${entry.getContent()}</textarea>
                </div>

                @if(entry.getAiInsight() != null && !entry.getAiInsight().isBlank())
                    <div class="alert alert-secondary small mt-3">
                        <strong>AI Insight:</strong><br>
                        ${entry.getAiInsight()}
                    </div>
                @endif

                <button class="btn btn-success mt-3">Save</button>
                <a href="${"/entries/" + entry.getId()}" class="btn btn-secondary mt-3 ms-2">Cancel</a>
            </form>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
