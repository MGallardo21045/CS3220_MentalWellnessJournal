@param String error
@param String username

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - AI Wellness Journal</title>
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
        <a href="/register" class="btn btn-outline-light me-2">Register</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-sm theme-card">
                <div class="card-body">

                    <div class="text-center mb-3">
                        <img src="/WJ_Logo.jpg" alt="AI Wellness Logo" style="height:80px;">
                    </div>

                    <h3 class="mb-3 text-center">Login</h3>

                    <form method="post" action="/login">
                        <div class="mb-2">
                            <label class="form-label">Username</label>
                            <input name="username" class="form-control"
                                   value="${username != null ? username : ""}" required>
                        </div>

                        <div class="mb-2">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>

                        <button class="btn btn-success w-100 mt-2">Login</button>
                    </form>

                    @if(error != null && !error.isEmpty())
                        <div class="alert alert-danger mt-3">${error}</div>
                    @endif

                    <p class="mt-3 small text-center">
                        Don’t have an account? <a href="/register">Register here</a>
                    </p>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
