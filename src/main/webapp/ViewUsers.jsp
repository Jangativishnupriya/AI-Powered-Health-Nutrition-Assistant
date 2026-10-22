<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.model.UserModel" %>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
   content="width=device-width, initial-scale=1.0">

<title>Manage Users | HealthCareSystem</title>

<!-- ================= BOOTSTRAP ================= -->

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<!-- ================= GOOGLE FONTS ================= -->

<link
    href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Playfair+Display:wght@500;600;700&display=swap"
    rel="stylesheet">

<style>

/* ================= GLOBAL ================= */

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

    padding: 55px 5%;

    display: flex;

    justify-content: center;

    align-items: flex-start;
}


/* ================= USERS CARD ================= */

.users-card {

    width: 100%;

    max-width: 1250px;

    padding: 45px;

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


/* ================= PAGE HEADER ================= */

.page-title {

    font-family: 'Playfair Display', serif;

    font-size: 40px;

    font-weight: 700;

    margin-bottom: 10px;

    text-align: center;
}

.page-description {

    text-align: center;

    color: rgba(255,255,255,0.90);

    font-size: 16px;

    margin-bottom: 35px;
}


/* ================= TABLE CONTAINER ================= */

.table-container {

    width: 100%;

    overflow-x: auto;

    border-radius: 18px;

    background: rgba(255,255,255,0.10);

    border: 1px solid rgba(255,255,255,0.20);
}


/* ================= TABLE ================= */

.users-table {

    width: 100%;

    min-width: 900px;

    border-collapse: collapse;

    margin: 0;
}

.users-table th {

    padding: 17px 15px;

    background: rgba(255,255,255,0.18);

    color: white;

    font-weight: 700;

    font-size: 14px;

    text-align: left;

    border-bottom:
        1px solid rgba(255,255,255,0.25);
}

.users-table td {

    padding: 16px 15px;

    color: rgba(255,255,255,0.92);

    font-size: 14px;

    border-bottom:
        1px solid rgba(255,255,255,0.15);

    vertical-align: middle;
}

.users-table tr:last-child td {

    border-bottom: none;
}

.users-table tbody tr {

    transition: 0.25s;
}

.users-table tbody tr:hover {

    background: rgba(255,255,255,0.10);
}


/* ================= STATUS ================= */

.status {

    display: inline-block;

    padding: 6px 12px;

    border-radius: 20px;

    font-size: 12px;

    font-weight: 700;

    background: rgba(255,255,255,0.18);
}


/* ================= ACTION BUTTONS ================= */

.action-btn {

    border: none;

    border-radius: 9px;

    padding: 8px 13px;

    font-size: 13px;

    font-weight: 600;

    cursor: pointer;

    margin-right: 5px;

    transition: 0.3s;
}

.activate-btn {

    background: #d9f7f2;

    color: #12343b;
}

.activate-btn:hover {

    transform: translateY(-2px);

    box-shadow:
        0 6px 15px rgba(0,0,0,0.20);
}

.delete-btn {

    background: rgba(255,255,255,0.18);

    color: white;

    border: 1px solid rgba(255,255,255,0.30);
}

.delete-btn:hover {

    background: rgba(255,255,255,0.28);

    transform: translateY(-2px);
}


/* ================= EMPTY MESSAGE ================= */

.empty-message {

    text-align: center;

    padding: 35px;

    color: rgba(255,255,255,0.85);

    font-size: 16px;
}


/* ================= FOOTER ================= */

.footer {

    padding: 22px 20px;

    text-align: center;

    background: rgba(255,255,255,0.10);

    backdrop-filter: blur(14px);

    -webkit-backdrop-filter: blur(14px);

    border-top: 1px solid rgba(255,255,255,0.20);

    color: rgba(255,255,255,0.85);

    font-size: 14px;
}


/* ================= RESPONSIVE ================= */

@media(max-width: 768px) {

    .main-container {

        padding: 35px 15px;
    }

    .users-card {

        padding: 30px 20px;

        border-radius: 22px;
    }

    .page-title {

        font-size: 32px;
    }

    .page-description {

        font-size: 14px;
    }

    .navbar {

        padding: 16px 5%;
    }

    .nav-link {

        margin-left: 12px;
    }
}

</style>

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar">


<div class="container-fluid">

    <a class="navbar-brand" href="Home.jsp">
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

<div class="users-card">


    <!-- ================= PAGE HEADER ================= -->

    <h1 class="page-title">
        Manage User Accounts
    </h1>

    <p class="page-description">
        View registered users, manage their account status,
        and remove user accounts when required.
    </p>



    <!-- ================= USERS TABLE ================= -->

    <div class="table-container">

        <table class="users-table">

            <thead>

                <tr>

                    <th>Full Name</th>

                    <th>Email</th>

                    <th>Age</th>

                    <th>Gender</th>

                    <th>Status</th>

                    <th>Action</th>

                </tr>

            </thead>


            <tbody>

            <%
                List<UserModel> users =
                    (List<UserModel>) request.getAttribute("users");

                if (users != null && !users.isEmpty()) {

                    for (UserModel user : users) {
            %>

                <tr>

                    <!-- FULL NAME -->

                    <td>
                        <%= user.getName() %>
                    </td>


                    <!-- EMAIL -->

                    <td>
                        <%= user.getEmail() %>
                    </td>


                    <!-- AGE -->

                    <td>
                        <%= user.getAge() %>
                    </td>


                    <!-- GENDER -->

                    <td>
                        <%= user.getGender() %>
                    </td>

                    <!-- STATUS -->

                    <td>

                        <span class="status">
                            <%= user.getStatus() %>
                        </span>

                    </td>


                    <!-- ACTION -->

                    <td>

                        <!-- ACTIVATE -->

                        <form action="ActivateUserController"
                              method="post"
                              style="display:inline;">

                            <input type="hidden"
                                   name="email"
                                   value="<%= user.getEmail() %>">

                            <button type="submit"
                                    class="action-btn activate-btn">

                                Activate

                            </button>

                        </form>


                        <!-- DELETE -->

                        <form action="DeleteUserController"
                              method="post"
                              style="display:inline;"
                              onsubmit="return confirm('Are you sure you want to delete this user?');">

                            <input type="hidden"
                                   name="email"
                                   value="<%= user.getEmail() %>">

                            <button type="submit"
                                    class="action-btn delete-btn">

                                Delete

                            </button>

                        </form>

                    </td>

                </tr>

            <%
                    }

                } else {
            %>

                <tr>

                    <td colspan="7"
                        class="empty-message">

                        No registered users found.

                    </td>

                </tr>

            <%
                }
            %>

            </tbody>

        </table>

    </div>

</div>


</div>

<!-- ================= FOOTER ================= -->

<footer class="footer">

© 2026 HealthCareSystem. All rights reserved.


</footer>

</body>

</html>
