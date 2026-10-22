<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>HealthCare | Dashboard</title>


    <!-- ================= BOOTSTRAP ================= -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <!-- ================= GOOGLE FONT ================= -->

    <link
        href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Playfair+Display:wght@600;700&display=swap"
        rel="stylesheet">


    <!-- ================= BOOTSTRAP ICONS ================= -->

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }


        html,
        body {
            width: 100%;
            min-height: 100%;
            font-family: 'DM Sans', sans-serif;
        }


        body {

            min-height: 100vh;

            /* SAME BACKGROUND AS HOME.JSP */

            background-image:
                linear-gradient(
                    rgba(5, 35, 35, 0.72),
                    rgba(5, 35, 35, 0.72)
                ),
                url("https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=2000&q=85");

            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;

            color: white;

        }


        /* =====================================================
           NAVBAR
        ===================================================== */

        .navbar-custom {

            margin: 18px auto 0;

            width: 94%;

            padding: 12px 24px;

            border-radius: 18px;

            background: rgba(255, 255, 255, 0.10);

            border: 1px solid rgba(255, 255, 255, 0.20);

            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);

            box-shadow:
                0 8px 30px rgba(0, 0, 0, 0.20);

        }


        .brand {

            font-size: 24px;

            font-weight: 700;

            color: white !important;

            letter-spacing: 0.5px;

        }


        .brand i {

            color: #72e6d2;

            margin-right: 7px;

        }


        .nav-link {

            color: rgba(255, 255, 255, 0.88) !important;

            font-weight: 500;

            margin-left: 10px;

            padding: 8px 15px !important;

            border-radius: 10px;

            transition: 0.3s ease;

        }


        .nav-link:hover {

            color: white !important;

            background: rgba(255, 255, 255, 0.15);

        }


        /* =====================================================
           LOGOUT
        ===================================================== */

        .logout-link {

            border: 1px solid rgba(114, 230, 210, 0.5);

            color: #9ff3e4 !important;

        }


        .logout-link:hover {

            background: rgba(114, 230, 210, 0.15);

            color: #b9fff2 !important;

        }


        /* =====================================================
           DASHBOARD MAIN
        ===================================================== */

        .dashboard-section {

            min-height: calc(100vh - 90px);

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 40px 15px;

        }


        /* =====================================================
           DASHBOARD WRAPPER
        ===================================================== */

        .dashboard-wrapper {

            width: 100%;

            max-width: 1000px;

            margin: 0 auto;

        }


        /* =====================================================
           WELCOME CARD
        ===================================================== */

        .welcome-card {

            width: 100%;

            padding: 60px 55px;

            border-radius: 28px;

            /*
             * LINEAR GRADIENT IS ONLY INSIDE
             * THE CENTER CONTENT BOX
             */

            background:
                linear-gradient(
                    135deg,
                    rgba(103, 230, 211, 0.20),
                    rgba(5, 35, 35, 0.35),
                    rgba(73, 167, 157, 0.22)
                );

            border: 1px solid rgba(255, 255, 255, 0.20);

            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);

            box-shadow:
                0 20px 60px rgba(0, 0, 0, 0.28);

            text-align: center;

        }


        /* =====================================================
           ICON
        ===================================================== */

        .welcome-icon {

            width: 72px;

            height: 72px;

            margin: 0 auto 22px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 20px;

            background: rgba(126, 233, 215, 0.16);

            border: 1px solid rgba(126, 233, 215, 0.30);

            color: #8ff1df;

            font-size: 33px;

        }


        /* =====================================================
           WELCOME TITLE
        ===================================================== */

        .welcome-title {

            font-family: 'Playfair Display', serif;

            font-size: clamp(42px, 5vw, 60px);

            font-weight: 700;

            line-height: 1.15;

            margin-bottom: 20px;

            color: white;

        }


        .welcome-title span {

            color: #7ee9d7;

        }


        /* =====================================================
           DESCRIPTION
        ===================================================== */

        .welcome-description {

            color: rgba(255, 255, 255, 0.82);

            font-size: 18px;

            line-height: 1.7;

            max-width: 720px;

            margin: 0 auto;

            font-weight: 400;

        }


        /* =====================================================
           FOOTER
        ===================================================== */

        footer {

            width: 100%;

            padding: 20px;

            text-align: center;

            background: rgba(0, 0, 0, 0.28);

            border-top: 1px solid rgba(255, 255, 255, 0.10);

            backdrop-filter: blur(10px);

        }


        footer p {

            margin: 0;

            color: rgba(255, 255, 255, 0.62);

            font-size: 13px;

        }


        footer span {

            color: #8ff1df;

        }


        /* =====================================================
           TABLET
        ===================================================== */

        @media (max-width: 991px) {

            .dashboard-section {

                padding: 40px 20px;

            }

            .welcome-card {

                padding: 50px 35px;

            }

        }


        /* =====================================================
           MOBILE
        ===================================================== */

        @media (max-width: 576px) {

            .navbar-custom {

                width: 96%;

                padding: 10px 15px;

            }


            .welcome-card {

                padding: 40px 22px;

                border-radius: 22px;

            }


            .welcome-icon {

                width: 62px;

                height: 62px;

                font-size: 28px;

            }


            .welcome-title {

                font-size: 38px;

            }


            .welcome-description {

                font-size: 15px;

                line-height: 1.6;

            }

        }

    </style>

</head>


<body>


    <!-- =====================================================
         NAVBAR
    ===================================================== -->

    <nav class="navbar navbar-expand-lg navbar-custom">

        <div class="container-fluid">


            <!-- BRAND -->

            <a class="navbar-brand brand"
                href="Dashboard.jsp">

                <i class="bi bi-heart-pulse-fill"></i>

                HealthCare

            </a>


            <!-- MOBILE MENU -->

            <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarMenu">

                <span class="navbar-toggler-icon"></span>

            </button>


            <!-- NAVIGATION -->

            <div
                class="collapse navbar-collapse"
                id="navbarMenu">

                <ul
                    class="navbar-nav ms-auto align-items-lg-center">


                    <!-- HOME -->

                    <li class="nav-item">

                        <a
                            class="nav-link"
                            href="Dashboard.jsp">

                            Home

                        </a>

                    </li>


                    <!-- MEDICAL CHATBOT -->

                    <li class="nav-item">

                        <a
                            class="nav-link"
                            href="Medical.jsp">

                            Medical Chatbot

                        </a>

                    </li>


                    <!-- NUTRITION -->

                    <li class="nav-item">

                        <a
                            class="nav-link"
                            href="Nutrition.jsp">

                            Nutrition

                        </a>

                    </li>


                    <!-- LOGOUT -->

                    <li class="nav-item">

                        <a
                            class="nav-link logout-link"
                            href="LogoutController">

                            <i class="bi bi-box-arrow-right me-1"></i>

                            Logout

                        </a>

                    </li>

                </ul>

            </div>

        </div>

    </nav>



    <!-- =====================================================
         DASHBOARD
    ===================================================== -->

    <main class="dashboard-section">


        <div class="dashboard-wrapper">


            <!-- =================================================
                 CENTER WELCOME CONTENT
            ================================================= -->

            <div class="welcome-card">


                <!-- ICON -->

                <div class="welcome-icon">

                    <i class="bi bi-heart-pulse-fill"></i>

                </div>


                <!-- TITLE -->
               <% String Fullname =(String) session.getAttribute("Fullname"); %>

                <h1 class="welcome-title">
                
                   <span>   Welcome to <%= Fullname %></span>

                   👋

                </h1>


                <!-- DESCRIPTION -->

                <p class="welcome-description">

                    Explore AI-powered medical chatbot and
                    nutrition insights for personalized health
                    solutions.

                </p>


            </div>


        </div>

    </main>



    <!-- =====================================================
         FOOTER
    ===================================================== -->

    <footer>

        <p>

            © 2026

            <span>HealthCare</span>.

            Built to promote better health awareness
            and informed living.

        </p>

    </footer>



    <!-- =====================================================
         BOOTSTRAP JS
    ===================================================== -->

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
    </script>


</body>

</html>