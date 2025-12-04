@param String username

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home</title>
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
            <a href="/dashboard" class="btn btn-outline-light me-2">Dashboard</a>
            <a href="/logout" class="btn btn-danger">Logout</a>
        @else
            <a href="/login" class="btn btn-outline-light me-2">Login</a>
            <a href="/register" class="btn btn-success">Register</a>
        @endif
    </div>
</nav>

<div class="container py-5">
    <div class="card shadow-sm mx-auto theme-card" style="max-width: 600px;">
        <div class="card-body text-center">

            <h2 class="mb-3">Welcome to AI Wellness Journal</h2>

            @if(username != null)
                <p>Signed in as <strong>${username}</strong></p>
                <a class="btn btn-primary" href="/dashboard">Go to Dashboard</a>
                <a class="btn btn-outline-secondary ms-2" href="/logout">Logout</a>
            @else
                <a class="btn btn-success" href="/login">Login</a>
                <a class="btn btn-outline-primary ms-2" href="/register">Register</a>
            @endif

        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
