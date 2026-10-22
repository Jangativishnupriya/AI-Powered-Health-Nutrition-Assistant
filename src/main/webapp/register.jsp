<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>HealthCare | Register</title>

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

            color: #ffffff;
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

            letter-spacing: 0.3px;
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

        /* ================= REGISTER SECTION ================= */

        .register-section {
            min-height: calc(100vh - 105px);

            display: flex;
            justify-content: center;
            align-items: center;

            padding: 55px 20px 70px;
        }

        .register-container {
            width: 100%;
            max-width: 560px;
        }

        .register-card {
            width: 100%;

            padding: 38px 42px;

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

            box-shadow:
                0 25px 60px rgba(0, 0, 0, 0.30);
        }

        /* ================= TITLE ================= */

        .register-icon {
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

        .register-title {
            font-family: 'Playfair Display', serif;

            text-align: center;

            font-size: 2.15rem;

            margin-bottom: 8px;

            color: #ffffff;
        }

        .register-subtitle {
            text-align: center;

            color: rgba(255, 255, 255, 0.68);

            font-size: 0.94rem;

            margin-bottom: 30px;
        }

        /* ================= FORM ================= */

        .form-label {
            color: rgba(255, 255, 255, 0.88);

            font-weight: 600;

            font-size: 0.91rem;

            margin-bottom: 8px;
        }

        .input-group {
            margin-bottom: 18px;
        }

        .input-group-text {
            background: rgba(255, 255, 255, 0.08);

            border: 1px solid rgba(255, 255, 255, 0.16);

            border-right: none;

            color: #67e6d3;

            padding-left: 15px;
            padding-right: 12px;
        }

        .form-control,
        .form-select {
            height: 46px;

            color: #ffffff;

            background: rgba(255, 255, 255, 0.08);

            border: 1px solid rgba(255, 255, 255, 0.16);

            border-left: none;

            border-radius: 0 12px 12px 0;

            font-family: 'DM Sans', sans-serif;

            transition: 0.3s ease;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.42);
        }

        .form-control:focus,
        .form-select:focus {
            color: #ffffff;

            background: rgba(255, 255, 255, 0.11);

            border-color: #67e6d3;

            box-shadow: 0 0 0 3px rgba(103, 230, 211, 0.10);

            outline: none;
        }

        .form-select {
            border-left: 1px solid rgba(255, 255, 255, 0.16);

            border-radius: 12px;

            padding-left: 14px;

            color: rgba(255, 255, 255, 0.85);
        }

        .form-select option {
            color: #222222;
            background: #ffffff;
        }

        /* Age field */

        .age-group {
            margin-bottom: 18px;
        }

        .age-input {
            width: 100%;

            height: 46px;

            color: #ffffff;

            background: rgba(255, 255, 255, 0.08);

            border: 1px solid rgba(255, 255, 255, 0.16);

            border-radius: 12px;

            padding: 0 14px;

            font-family: 'DM Sans', sans-serif;
        }

        .age-input:focus {
            outline: none;

            border-color: #67e6d3;

            box-shadow: 0 0 0 3px rgba(103, 230, 211, 0.10);

            background: rgba(255, 255, 255, 0.11);
        }

        /* ================= CHECKBOX ================= */

        .terms-box {
            display: flex;

            align-items: flex-start;

            gap: 11px;

            margin: 20px 0 24px;

            padding: 13px 14px;

            border-radius: 13px;

            background: rgba(255, 255, 255, 0.055);

            border: 1px solid rgba(255, 255, 255, 0.10);
        }

        .terms-box input {
            width: 18px;
            height: 18px;

            margin-top: 2px;

            flex-shrink: 0;

            accent-color: #67e6d3;

            cursor: pointer;
        }

        .terms-box label {
            color: rgba(255, 255, 255, 0.70);

            font-size: 0.82rem;

            line-height: 1.5;

            cursor: pointer;
        }

        /* ================= REGISTER BUTTON ================= */

        .register-btn {
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

        .register-btn i {
            margin-right: 7px;
        }

        .register-btn:hover {
            transform: translateY(-2px);

            box-shadow:
                0 14px 30px rgba(103, 230, 211, 0.28);
        }

        /* ================= LOGIN LINK ================= */

        .login-text {
            text-align: center;

            margin-top: 22px;

            margin-bottom: 0;

            color: rgba(255, 255, 255, 0.65);

            font-size: 0.9rem;
        }

        .login-text a {
            color: #67e6d3;

            text-decoration: none;

            font-weight: 700;

            margin-left: 4px;
        }

        .login-text a:hover {
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

            .register-section {
                padding: 35px 15px 45px;
            }

            .register-card {
                padding: 30px 22px;

                border-radius: 22px;
            }

            .register-title {
                font-size: 1.85rem;
            }

            .register-subtitle {
                font-size: 0.85rem;
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

            <div class="collapse navbar-collapse justify-content-end"
                 id="navbarNav">

                <ul class="navbar-nav">

                    <li class="nav-item">
                        <a class="nav-link" href="Home.jsp">
                            <i class="bi bi-house-door"></i>
                            Home
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Login.jsp">
                            <i class="bi bi-box-arrow-in-right"></i>
                            Login
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link active" href="register.jsp">
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


    <!-- ================= REGISTER SECTION ================= -->

    <section class="register-section">

        <div class="register-container">

            <div class="register-card">

                <!-- Icon -->

                <div class="register-icon">
                    <i class="bi bi-person-plus-fill"></i>
                </div>


                <!-- Heading -->

                <h1 class="register-title">
                    Create Your Account
                </h1>

                <p class="register-subtitle">
                    Join HealthCare and take a step towards better health awareness.
                </p>


                <!-- ================= FORM ================= -->

                <form name ="Register"method="post"  action="RegisterController" >

                    <!-- Full Name -->

                    <label class="form-label">
                        Full Name
                    </label>

                    <div class="input-group">

                        <span class="input-group-text">
                            <i class="bi bi-person"></i>
                        </span>

                        <input
                            type="text"
                            name="Fullname"
                            class="form-control"
                            placeholder="Enter your full name"
                            required>

                    </div>


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
                            placeholder="Create a password"
                            required>

                    </div>


                    <!-- Confirm Password -->

                    <label class="form-label">
                        Confirm Password
                    </label>

                    <div class="input-group">

                        <span class="input-group-text">
                            <i class="bi bi-lock-fill"></i>
                        </span>

                        <input
                            type="password"
                            name="confirmPassword"
                            class="form-control"
                            placeholder="Confirm your password"
                            required>

                    </div>


                    <!-- Age -->

                    <div class="age-group">

                        <label class="form-label">
                            Age
                        </label>

                        <input
                            type="number"
                            name="age"
                            class="age-input"
                            placeholder="Enter your age"
                            min="1"
                            max="120"
                            required>

                    </div>


                    <!-- Gender -->

                    <label class="form-label">
                        Gender
                    </label>

                    <div class="mb-2">

                        <select
                            name="gender"
                            class="form-select"
                            required>

                            <option value="" selected disabled>
                                Select Gender
                            </option>

                            <option value="Male">
                                Male
                            </option>

                            <option value="Female">
                                Female
                            </option>

                            <option value="Other">
                                Other
                            </option>

                            <option value="Prefer not to say">
                                Prefer not to say
                            </option>

                        </select>

                    </div>


                    <!-- Disclaimer -->

                    <div class="terms-box">

                        <input
                            type="checkbox"
                            id="healthDisclaimer"
                            name="healthDisclaimer"
                            value="accepted"
                            required>

                        <label for="healthDisclaimer">

                            I understand that this application provides
                            general health information and does not replace
                            professional medical advice.

                        </label>

                    </div>


                    <!-- Register Button -->

                    <button
                        type="submit"
                        class="register-btn">

                        <i class="bi bi-person-plus-fill"></i>
                        Register

                    </button>


                    <!-- Login -->

                    <p class="login-text">

                        Already have an account?

                        <a href="Login.jsp">
                            Login
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