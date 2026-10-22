<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Login | HealthCareSystem</title>

<!-- Bootstrap --> 
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<!-- Google Fonts --> 
<link
    href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Playfair+Display:wght@500;600;700&display=swap"
    rel="stylesheet">

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    min-height: 100vh;
    font-family: 'DM Sans', sans-serif;

    background:
        linear-gradient(
            rgba(7, 30, 40, 0.45),
            rgba(7, 30, 40, 0.45)
        ),
        url("https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=2000&q=80");

    background-size: cover;
    background-position: center;
    background-attachment: fixed;

    display: flex;
    flex-direction: column;
}

/* ================= NAVBAR ================= */

.navbar {
    background: rgba(255, 255, 255, 0.12);
    backdrop-filter: blur(14px);
    -webkit-backdrop-filter: blur(14px);

    border-bottom: 1px solid rgba(255, 255, 255, 0.25);

    padding: 18px 7%;
}

.navbar-brand {
    color: white !important;
    font-family: 'Playfair Display', serif;
    font-size: 25px;
    font-weight: 700;
}

.nav-link {
    color: white !important;
    font-weight: 500;
    margin-left: 25px;
    transition: 0.3s;
}

.nav-link:hover {
    color: #d9f7f2 !important;
}

/* ================= MAIN ================= */

.main-container {
    flex: 1;

    display: flex;
    justify-content: center;
    align-items: center;

    padding: 60px 20px;
}

/* ================= LOGIN CARD ================= */

.login-card {

    width: 100%;
    max-width: 470px;

    padding: 45px 42px;

    background:
        linear-gradient(
            135deg,
            rgba(255, 255, 255, 0.25),
            rgba(255, 255, 255, 0.08)
        );

    backdrop-filter: blur(18px);
    -webkit-backdrop-filter: blur(18px);

    border: 1px solid rgba(255, 255, 255, 0.30);

    border-radius: 25px;

    box-shadow:
        0 20px 50px rgba(0, 0, 0, 0.25);

    color: white;
}

/* ================= TITLE ================= */

.login-title {
    font-family: 'Playfair Display', serif;

    text-align: center;

    font-size: 34px;
    font-weight: 700;

    margin-bottom: 35px;
}

/* ================= LABEL ================= */

.form-label {
    font-weight: 600;
    margin-bottom: 8px;
}

/* ================= INPUT ================= */

.form-control {

    height: 52px;

    border-radius: 12px;

    border: 1px solid rgba(255,255,255,0.35);

    background: rgba(255,255,255,0.15);

    color: white;

    backdrop-filter: blur(8px);

    padding: 0 16px;

    margin-bottom: 22px;
}

.form-control::placeholder {
    color: rgba(255,255,255,0.75);
}

.form-control:focus {

    background: rgba(255,255,255,0.20);

    color: white;

    border-color: rgba(255,255,255,0.7);

    box-shadow: 0 0 0 3px rgba(255,255,255,0.10);
}

/* ================= LOGIN BUTTON ================= */

.login-btn {

    width: 100%;

    height: 52px;

    border: none;

    border-radius: 13px;

    margin-top: 10px;

    font-size: 16px;

    font-weight: 700;

    color: #12343b;

    background: linear-gradient(
        135deg,
        #ffffff,
        #d9f7f2
    );

    transition: all 0.3s ease;
}

.login-btn:hover {

    transform: translateY(-2px);

    box-shadow:
        0 10px 25px rgba(0,0,0,0.20);
}

/* ================= ERROR ================= */

.error-message {

    color: #ffe3e3;

    background: rgba(255, 70, 70, 0.15);

    border: 1px solid rgba(255, 150, 150, 0.30);

    padding: 10px 15px;

    border-radius: 10px;

    margin-bottom: 20px;

    text-align: center;

    font-size: 14px;
}

/* ================= RESPONSIVE ================= */

@media(max-width: 576px) {

    .login-card {
        padding: 35px 25px;
    }

    .login-title {
        font-size: 29px;
    }

    .navbar {
        padding: 15px 5%;
    }
}

</style>

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar navbar-expand-lg">

    <div class="container-fluid">

        <a class="navbar-brand" href="Home.jsp">
            HealthCare
        </a>

        <div class="ms-auto">

            <a class="nav-link d-inline-block"
               href="Home.jsp">
                Home
            </a>

        </div>

    </div>

</nav>


<!-- ================= MAIN ================= -->

<div class="main-container">

    <div class="login-card">

        <h1 class="login-title">
            ADMIN LOGIN
        </h1>

        <!-- Error message -->
        <% if(request.getAttribute("error") != null) { %>

            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>

        <% } %>


        <form action="AdminLoginController" method="post">

            <!-- Admin Name -->

            <label class="form-label">
                Admin Name
            </label>

            <input
                type="text"
                name="Fullname"
                class="form-control"
                placeholder="Enter admin name"
                required>


            <!-- Password -->

            <label class="form-label">
                Password
            </label>

            <input
                type="password"
                name="passwordKey"
                class="form-control"
                placeholder="Enter password"
                required>


            <!-- Login -->

            <button
                type="submit"
                class="login-btn">

                LOGIN

            </button>

        </form>

    </div>

</div>


</body>
</html>