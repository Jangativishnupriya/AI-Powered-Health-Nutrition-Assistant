<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Dashboard | HealthCareSystem</title>

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


/* ================= ADMIN CARD ================= */

.admin-card {

    width: 100%;

    max-width: 900px;

    padding: 65px 70px;

    text-align: center;

    background:
        linear-gradient(
            135deg,
            rgba(255, 255, 255, 0.25),
            rgba(255, 255, 255, 0.08)
        );

    backdrop-filter: blur(18px);
    -webkit-backdrop-filter: blur(18px);

    border: 1px solid rgba(255, 255, 255, 0.30);

    border-radius: 30px;

    box-shadow:
        0 25px 60px rgba(0, 0, 0, 0.25);

    color: white;
}


/* ================= TITLE ================= */

.admin-title {

    font-family: 'Playfair Display', serif;

    font-size: 42px;

    font-weight: 700;

    margin-bottom: 20px;
}


/* ================= DESCRIPTION ================= */

.admin-description {

    max-width: 700px;

    margin: 0 auto 40px auto;

    font-size: 17px;

    line-height: 1.8;

    color: rgba(255,255,255,0.90);
}


/* ================= BUTTON ================= */

.user-btn {

    display: inline-block;

    padding: 15px 30px;

    border: none;

    border-radius: 13px;

    text-decoration: none;

    font-size: 16px;

    font-weight: 700;

    color: #12343b;

    background:
        linear-gradient(
            135deg,
            #ffffff,
            #d9f7f2
        );

    transition: all 0.3s ease;

    box-shadow:
        0 8px 20px rgba(0,0,0,0.15);
}

.user-btn:hover {

    transform: translateY(-3px);

    color: #12343b;

    box-shadow:
        0 12px 28px rgba(0,0,0,0.25);
}


/* ================= RESPONSIVE ================= */

@media(max-width: 768px) {

    .admin-card {

        padding: 45px 30px;

    }

    .admin-title {

        font-size: 34px;

    }

    .admin-description {

        font-size: 15px;

    }

}

</style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <div class="container-fluid">

        <a class="navbar-brand" href="home.jsp">
            HealthCare
        </a>

        <div class="ms-auto">

            <a class="nav-link d-inline-block"
               href="Home.jsp">
                Home
            </a>

            <a class="nav-link d-inline-block"
               href="AdminLogoutController">
                Logout
            </a>

        </div>

    </div>

</nav>



<!-- ================= MAIN ================= -->

<div class="main-container">

    <div class="admin-card">


        <!-- ADMIN NAME -->

        <h1 class="admin-title">

            Welcome to
            <%= session.getAttribute("adminName") != null
                    ? session.getAttribute("adminName")
                    : "Admin" %>

        </h1>


        <!-- DESCRIPTION -->

        <p class="admin-description">

            Manage user accounts and access AI-powered
            medical and nutrition insights for personalized
            health solutions.

        </p>


        <!-- VIEW USERS -->

        <a href="ViewUsersController"
           class="user-btn">

            View &amp; Activate Users

        </a>


    </div>

</div>


</body>
</html>