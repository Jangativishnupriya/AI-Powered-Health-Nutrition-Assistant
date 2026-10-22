<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>HealthCare | Login</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Google Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Playfair+Display:wght@600;700&display=swap"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;

            font-family: 'DM Sans', sans-serif;
            color: #ffffff;

            background:
                linear-gradient(
                    rgba(5, 35, 35, 0.72),
                    rgba(5, 35, 35, 0.72)
                ),
                url("https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=2000&q=85");

            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
        }

        /* ================= NAVBAR ================= */

        .navbar-custom {
            width: 94%;
            margin: 18px auto 0;

            padding: 13px 24px;

            border-radius: 18px;

            background: rgba(255, 255, 255, 0.10);

            border: 1px solid rgba(255, 255, 255, 0.18);

            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);

            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.18);
        }

        .navbar-brand {
            color: #ffffff !important;

            font-size: 1.45rem;
            font-weight: 700;
        }

        .navbar-brand i {
            color: #67e6d3;
            margin-right: 8px;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.85) !important;

            font-weight: 500;

            margin-left: 12px;

            padding: 8px 14px !important;

            border-radius: 10px;

            transition: 0.3s ease;
        }

        .nav-link:hover {
            color: #ffffff !important;

            background: rgba(103, 230, 211, 0.14);
        }

        .nav-link.active {
            color: #67e6d3 !important;

            background: rgba(103, 230, 211, 0.12);
        }

        /* ================= LOGIN SECTION ================= */

        .login-section {
            min-height: calc(100vh - 105px);

            display: flex;
            justify-content: center;
            align-items: center;

            padding: 55px 20px 70px;
        }

        .login-container {
            width: 100%;
            max-width: 500px;
        }

        .login-card {
            width: 100%;

            padding: 40px 42px;

            border-radius: 28px;

            background:
                linear-gradient(
                    135deg,
                    rgba(103, 230, 211, 0.16),
                    rgba(255, 255, 255, 0.09),
                    rgba(73, 167, 157, 0.14)
                );

            border: 1px solid rgba(255, 255, 255, 0.20);

            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);

            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.30);
        }

        /* ================= HEADING ================= */

        .login-icon {
            width: 62px;
            height: 62px;

            margin: 0 auto 18px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 18px;

            background: rgba(103, 230, 211, 0.15);

            border: 1px solid rgba(103, 230, 211, 0.25);

            color: #67e6d3;

            font-size: 1.7rem;
        }

        .login-title {
            font-family: 'Playfair Display', serif;

            text-align: center;

            font-size: 2.15rem;

            margin-bottom: 10px;

            color: #ffffff;
        }

        .login-title .user-name {
            color: #67e6d3;
        }

        .login-subtitle {
            text-align: center;

            color: rgba(255, 255, 255, 0.68);

            font-size: 0.94rem;

            margin-bottom: 32px;
        }

        /* ================= FORM ================= */

        .form-label {
            color: rgba(255, 255, 255, 0.88);

            font-weight: 600;

            font-size: 0.91rem;

            margin-bottom: 8px;
        }

        .input-group {
            margin-bottom: 21px;
        }

        .input-group-text {
            background: rgba(255, 255, 255, 0.08);

            border: 1px solid rgba(255, 255, 255, 0.16);

            border-right: none;

            color: #67e6d3;

            padding-left: 15px;
            padding-right: 12px;
        }

        .form-control {
            height: 47px;

            color: #ffffff;

            background: rgba(255, 255, 255, 0.08);

            border: 1px solid rgba(255, 255, 255, 0.16);

            border-left: none;

            border-radius: 0 12px 12px 0;

            font-family: 'DM Sans', sans-serif;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.42);
        }

        .form-control:focus {
            color: #ffffff;

            background: rgba(255, 255, 255, 0.11);

            border-color: #67e6d3;

            box-shadow: 0 0 0 3px rgba(103, 230, 211, 0.10);

            outline: none;
        }

        /* ================= REMEMBER ME ================= */

        .login-options {
            display: flex;

            justify-content: space-between;
            align-items: center;

            margin: 4px 0 25px;
        }

        .remember-me {
            display: flex;
            align-items: center;

            gap: 8px;

            color: rgba(255, 255, 255, 0.70);

            font-size: 0.84rem;
        }

        .remember-me input {
            width: 17px;
            height: 17px;

            accent-color: #67e6d3;

            cursor: pointer;
        }

        .forgot-link {
            color: #67e6d3;

            font-size: 0.84rem;

            text-decoration: none;
        }

        .forgot-link:hover {
            text-decoration: underline;
        }

        /* ================= LOGIN BUTTON ================= */

        .login-btn {
            width: 100%;

            height: 48px;

            border: none;

            border-radius: 13px;

            background: linear-gradient(
                135deg,
                #67e6d3,
                #45c9b7
            );

            color: #063b38;

            font-size: 1rem;

            font-weight: 700;

            transition: all 0.3s ease;

            box-shadow:
                0 10px 25px rgba(103, 230, 211, 0.20);
        }

        .login-btn i {
            margin-right: 7px;
        }

        .login-btn:hover {
            transform: translateY(-2px);

            box-shadow:
                0 14px 30px rgba(103, 230, 211, 0.28);
        }

        /* ================= REGISTER LINK ================= */

        .register-text {
            text-align: center;

            margin-top: 23px;
            margin-bottom: 0;

            color: rgba(255, 255, 255, 0.65);

            font-size: 0.9rem;
        }

        .register-text a {
            color: #67e6d3;

            text-decoration: none;

            font-weight: 700;

            margin-left: 4px;
        }

        .register-text a:hover {
            text-decoration: underline;
        }

        /* ================= FOOTER ================= */

        footer {
            text-align: center;

            padding: 18px 20px 24px;

            color: rgba(255, 255, 255, 0.48);

            font-size: 0.78rem;
        }

        /* ================= RESPONSIVE ================= */

        @media (max-width: 576px) {

            .navbar-custom {
                width: 94%;
                padding: 11px 16px;
            }

            .login-section {
                padding: 35px 15px 45px;
            }

            .login-card {
                padding: 30px 22px;

                border-radius: 22px;
            }

            .login-title {
                font-size: 1.85rem;
            }

            .login-subtitle {
                font-size: 0.85rem;
            }

            .login-options {
                flex-direction: column;

                align-items: flex-start;

                gap: 12px;
            }

        }

    </style>

</head>

<body>

    <!-- ================= NAVBAR ================= -->

    <nav class="navbar navbar-expand-lg navbar-custom">

        <div class="container-fluid">

            <a class="navbar-brand" href="home.jsp">
                <i class="bi bi-heart-pulse-fill"></i>
                HealthCare
            </a>

            <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">

                <span class="navbar-toggler-icon"></span>

            </button>

            <div
                class="collapse navbar-collapse justify-content-end"
                id="navbarNav">

                <ul class="navbar-nav">

                    <li class="nav-item">
                        <a class="nav-link" href="Home.jsp">
                            <i class="bi bi-house-door"></i>
                            Home
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link active" href="Login.jsp">
                            <i class="bi bi-box-arrow-in-right"></i>
                            Login
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="register.jsp">
                            <i class="bi bi-person-plus"></i>
                            Register
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="AdminLogin.jsp">
                            <i class="bi bi-shield-lock"></i>
                            Admin
                        </a>
                    </li>

                </ul>

            </div>

        </div>

    </nav>


    <!-- ================= LOGIN SECTION ================= -->

    <section class="login-section">

        <div class="login-container">

            <div class="login-card">

                <!-- Icon -->

                <div class="login-icon">
                    <i class="bi bi-person-check-fill"></i>
                </div>


                <!-- Heading -->

                <h1 class="login-title">

                    Welcome Back

                    <span class="user-name">
                        ${sessionScope.Fullname}
                    </span>

                    👋

                </h1>

                <p class="login-subtitle">
                    Login to Health &amp; Nutrition Assistant
                </p>


                <!-- ================= LOGIN FORM ================= -->

                <form action="LoginController" method="post">

                    <!-- Email -->

                    <label class="form-label">
                        Email
                    </label>

                    <div class="input-group">

                        <span class="input-group-text">
                            <i class="bi bi-envelope"></i>
                        </span>

                        <input
                            type="email"
                            name="email"
                            class="form-control"
                            placeholder="Enter your email"
                            required>

                    </div>


                    <!-- Password -->

                    <label class="form-label">
                        Password
                    </label>

                    <div class="input-group">

                        <span class="input-group-text">
                            <i class="bi bi-lock"></i>
                        </span>

                        <input
                            type="password"
                            name="passwordKey"
                            class="form-control"
                            placeholder="Enter your password"
                            required>

                    </div>


                    <!-- Remember Me + Forgot Password -->

                    <div class="login-options">

                        <div class="remember-me">

                            <input
                                type="checkbox"
                                id="rememberMe"
                                name="rememberMe"
                                value="true">

                            <label for="rememberMe">
                                Remember me
                            </label>

                        </div>

                        <a href="#" class="forgot-link">
                            Forgot Password?
                        </a>

                    </div>


                    <!-- Login Button -->

                    <button
                        type="submit"
                        class="login-btn">

                        <i class="bi bi-box-arrow-in-right"></i>
                        Login

                    </button>


                    <!-- Create Account -->

                    <p class="register-text">

                        Don't have an account?

                        <a href="register.jsp">
                            Create Account
                        </a>

                    </p>

                </form>

            </div>

        </div>

    </section>


    <!-- ================= FOOTER ================= -->

    <footer>

        © 2026 HealthCare.
        Built to promote better health awareness and informed living.

    </footer>


    <!-- Bootstrap JS -->

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
    </script>

</body>

</html>