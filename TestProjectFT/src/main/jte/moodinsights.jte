@param java.util.List<com.example.testprojectft.JournalEntry> entries
@param double averageMood
@param String summary
@param String suggestions

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Mood Insights</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/NightTheme.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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


<div class="container-fluid mt-4 px-5">

    <h2>Mood Insights</h2>
    <p><strong>Your average mood:</strong> ${"%.1f".formatted(averageMood)}</p>

    @if(summary != null)
        <div class="alert alert-info mt-3 theme-card">
            <strong>AI Summary:</strong><br>
            ${summary}
        </div>
    @endif

    <h4 class="mt-4">Entries Used for Analysis</h4>

    @if(entries.isEmpty())
        <p>No entries available.</p>
    @else

        <div class="card shadow-sm theme-card p-3">

            <table class="table table-hover table-bordered align-middle text-light table-dark">

                <thead>
                <tr>
                    <th>Date</th>
                    <th>Your Mood</th>
                    <th>Content</th>
                    <th>AI Insight</th>
                </tr>
                </thead>

                <tbody>
                @for(com.example.testprojectft.JournalEntry entry : entries)
                    <tr>
                        <td>${entry.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"))}</td>
                        <td>
                            @if(entry.getMoodScale() != null)
                                ${entry.getMoodScale()}
                            @else
                                N/A
                            @endif

                        </td>
                        <td>${
                        entry.getContent() != null && entry.getContent().length() > 120
                        ? entry.getContent().substring(0, 120) + "..."
                        : entry.getContent()
                    }</td>
                        <td>${entry.getAiInsight() != null ? entry.getAiInsight() : "No AI Insight Yet"}</td>
                    </tr>
                @endfor
                </tbody>
            </table>
        </div>
    @endif

    <div class="row mt-5">

        <div class="col-md-6">
            <h4>Mood Trend Graph</h4>
            <div class="d-flex mb-2">
                <select id="rangeSelector" class="form-select w-50">
                    <option value="all">All Time</option>
                    <option value="week">Past Week</option>
                    <option value="month">Past Month</option>
                </select>
            </div>
            <div style="width: 100%; height: 500px; position: relative;">
                <canvas id="moodChart"></canvas>
            </div>
        </div>

        <div class="col-md-6">
            <h4>AI Suggestions</h4>
            <div class="card shadow-sm theme-card">
                <div class="card-header text-white bg-primary">
                    <strong>Helpful Tips</strong>
                </div>
                <div class="card-body text-muted" style="font-size:0.95rem;">
                    ${suggestions}
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    let combined = [];

    @if(!entries.isEmpty())
    @for(com.example.testprojectft.JournalEntry entry : entries)
    combined.push({
        label: "${entry.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("MM-dd"))}",
        value: ${entry.getMoodScale() != null ? entry.getMoodScale() : null},
        date: new Date("${entry.getCreatedAt().toString()}")
    });
    @endfor
    @endif

    combined.sort((a, b) => a.date - b.date);

    const rawLabels = combined.map(x => x.label);
    const rawValues = combined.map(x => x.value).map(v => v === null ? null : Number(v));

    const ctx = document.getElementById('moodChart').getContext('2d');

    function moodColor(mood) {
        if (mood >= 7) return "#4caf50";
        if (mood >= 4) return "#ff9800";
        return "#f44336";
    }

    function buildGradient(ctx) {
        const gradient = ctx.createLinearGradient(0, 0, 0, 350);
        gradient.addColorStop(0, 'rgba(0, 123, 255, 0.6)');
        gradient.addColorStop(1, 'rgba(0, 123, 255, 0)');
        return gradient;
    }

    let chart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: rawLabels,
            datasets: [{
                label: 'Mood Over Time',
                data: rawValues,
                borderColor: rawValues.map(v => moodColor(v)),
                borderWidth: 2,
                pointRadius: 4,
                pointBackgroundColor: rawValues.map(v => moodColor(v)),
                fill: true,
                backgroundColor: buildGradient(ctx),
                tension: 0.3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: { suggestedMin: 0, suggestedMax: 10, title: { display: true, text: 'Mood' } },
                x: { title: { display: true, text: 'Date' } }
            }
        }
    });

    document.getElementById('rangeSelector').addEventListener('change', e => {
        const v = e.target.value;
        const now = new Date();

        let filtered;

        if (v === 'week') {
            filtered = combined.filter(x => (now - x.date) / 86400000 <= 7);
        } else if (v === 'month') {
            filtered = combined.filter(x => (now - x.date) / 86400000 <= 30);
        } else {
            filtered = combined;
        }

        chart.data.labels = filtered.map(x => x.label);
        chart.data.datasets[0].data = filtered.map(x => x.value);
        chart.data.datasets[0].pointBackgroundColor = filtered.map(x => moodColor(x.value));
        chart.update();
    });
</script>

</body>
</html>
