@param String error
@param String fullName
@param String username

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Account</title>
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
        <a href="/login" class="btn btn-outline-light me-2">Login</a>
        <a href="/register" class="btn btn-success">Register</a>
    </div>
</nav>

<div class="row justify-content-center mt-5">
    <div class="col-md-5">
        <div class="card shadow-sm theme-card">
            <div class="card-body">
                <h3 class="mb-3">Create Account</h3>

                <form method="post" action="/register" autocomplete="off">
                    <div class="mb-2">
                        <label class="form-label">Full Name</label>
                        <input name="fullName" class="form-control"
                               value="${fullName != null ? fullName : ""}"
                               placeholder="e.g. John Doe" required>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Username (email)</label>
                        <input type="email" name="username" class="form-control"
                               value="${username != null ? username : ""}"
                               placeholder="e.g. john@example.com" required>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control"
                               autocomplete="new-password" required>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Confirm Password</label>
                        <input type="password" name="confirmPassword" class="form-control"
                               autocomplete="new-password" required>
                    </div>

                    <button class="btn btn-primary w-100 mt-2">Register</button>
                </form>

                @if(error != null && !error.isEmpty())
                    <div class="alert alert-danger mt-3">${error}</div>
                @endif

                <p class="mt-3 small text-center">
                    Already have an account? <a href="/login">Login here</a>
                </p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
