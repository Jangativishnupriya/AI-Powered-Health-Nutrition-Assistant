
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>HealthCare | Home</title>


    <!-- Bootstrap -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <!-- Google Font -->

    <link
        href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Playfair+Display:wght@600;700&display=swap"
        rel="stylesheet">


    <!-- Bootstrap Icons -->

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

            /* Health-related fixed background */

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



        /* ================= NAVBAR ================= */

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


        .admin-link {

            border: 1px solid rgba(114, 230, 210, 0.5);

            color: #9ff3e4 !important;
        }



        /* ================= MAIN ================= */

        .main-section {

            min-height: calc(100vh - 90px);

            display: flex;

            flex-direction: column;

            align-items: center;

            justify-content: center;

            padding: 55px 15px 40px;
        }



        /* ================= HERO ================= */

        .hero-content {

            text-align: center;

            max-width: 800px;

            margin-bottom: 42px;
        }


        .hero-tag {

            display: inline-block;

            padding: 7px 16px;

            margin-bottom: 16px;

            border-radius: 30px;

            background: rgba(114, 230, 210, 0.14);

            border: 1px solid rgba(114, 230, 210, 0.35);

            color: #9ff3e4;

            font-size: 14px;

            font-weight: 600;

            letter-spacing: 0.5px;
        }


        .hero-title {

            font-family: 'Playfair Display', serif;

            font-size: clamp(38px, 5vw, 62px);

            line-height: 1.1;

            margin-bottom: 15px;

            color: white;
        }


        .hero-title span {

            color: #7ee9d7;
        }


        .hero-description {

            color: rgba(255, 255, 255, 0.78);

            font-size: 17px;

            line-height: 1.7;

            max-width: 680px;

            margin: auto;
        }



        /* =====================================================
           CARDS AREA
           ===================================================== */

        .cards-wrapper {

            width: 100%;

            /*
             * Increased from 1150px.
             * This gives all three cards enough space.
             */

            max-width: 1350px;

            margin: 0 auto;
        }


        /*
         * Main gradient/glass container
         */

        .cards-container {

            width: 100%;

            padding: 32px 38px;

            border-radius: 28px;

            background:

                linear-gradient(
                    135deg,
                    rgba(103, 230, 211, 0.16),
                    rgba(255, 255, 255, 0.07),
                    rgba(73, 167, 157, 0.15)
                );

            border: 1px solid rgba(255, 255, 255, 0.18);

            backdrop-filter: blur(12px);

            -webkit-backdrop-filter: blur(12px);

            box-shadow:

                0 20px 60px rgba(0, 0, 0, 0.25);
        }



        /* =====================================================
           CARDS ROW
           ===================================================== */

        .cards-row {

            display: flex;

            width: 100%;

            gap: 28px;

            align-items: stretch;

            justify-content: center;
        }


        /*
         * Each card receives equal width.
         *
         * No Bootstrap col-lg-3 / col-lg-6 restriction here.
         */

        .card-column {

            flex: 1;

            min-width: 0;
        }



        /* =====================================================
           HEALTH CARD
           ===================================================== */

        .health-card {

            width: 100%;

            min-height: 250px;

            height: 100%;

            padding: 30px 28px;

            border-radius: 22px;

            background: rgba(255, 255, 255, 0.11);

            border: 1px solid rgba(255, 255, 255, 0.17);

            backdrop-filter: blur(15px);

            -webkit-backdrop-filter: blur(15px);

            transition: all 0.35s ease;

            position: relative;

            overflow: hidden;
        }


        .health-card::before {

            content: "";

            position: absolute;

            width: 120px;

            height: 120px;

            border-radius: 50%;

            background: rgba(126, 233, 215, 0.12);

            top: -45px;

            right: -40px;

            pointer-events: none;
        }


        .health-card:hover {

            transform: translateY(-8px);

            background: rgba(255, 255, 255, 0.16);

            border-color: rgba(126, 233, 215, 0.45);

            box-shadow:

                0 18px 40px rgba(0, 0, 0, 0.25);
        }



        /* ================= ICON ================= */

        .card-icon {

            width: 58px;

            height: 58px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 17px;

            background: rgba(126, 233, 215, 0.16);

            border: 1px solid rgba(126, 233, 215, 0.30);

            color: #8ff1df;

            font-size: 27px;

            margin-bottom: 20px;
        }



        /* ================= CARD CONTENT ================= */

        .health-card h3 {

            font-size: 21px;

            font-weight: 700;

            margin-bottom: 12px;

            color: white;
        }


        .health-card p {

            color: rgba(255, 255, 255, 0.70);

            font-size: 14px;

            line-height: 1.7;

            margin-bottom: 22px;
        }


        .card-link {

            color: #91f0df;

            text-decoration: none;

            font-size: 14px;

            font-weight: 600;

            transition: 0.3s;
        }


        .card-link:hover {

            color: white;
        }


        .card-link i {

            margin-left: 5px;

            transition: 0.3s;
        }


        .card-link:hover i {

            margin-left: 10px;
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

            .main-section {

                padding-top: 45px;
            }


            .hero-content {

                margin-bottom: 30px;
            }


            .cards-container {

                padding: 25px;
            }


            .cards-row {

                flex-direction: column;

                gap: 20px;
            }


            .health-card {

                min-height: auto;

                margin-bottom: 0;
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


            .hero-title {

                font-size: 38px;
            }


            .hero-description {

                font-size: 15px;
            }


            .cards-container {

                padding: 18px;

                border-radius: 20px;
            }


            .health-card {

                padding: 25px 22px;
            }
        }

    </style>

</head>



<body>


    <!-- ================= NAVBAR ================= -->

    <nav class="navbar navbar-expand-lg navbar-custom">

        <div class="container-fluid">


            <a class="navbar-brand brand" href="home.jsp">

                <i class="bi bi-heart-pulse-fill"></i>

                HealthCare

            </a>



            <button

                class="navbar-toggler"

                type="button"

                data-bs-toggle="collapse"

                data-bs-target="#navbarMenu">

                <span class="navbar-toggler-icon"></span>

            </button>



            <div class="collapse navbar-collapse" id="navbarMenu">

                <ul class="navbar-nav ms-auto align-items-lg-center">


                    <li class="nav-item">

                        <a class="nav-link" href="Home.jsp">

                            Home

                        </a>

                    </li>



                    <li class="nav-item">

                        <a class="nav-link" href="Login.jsp">

                            Login

                        </a>

                    </li>



                    <li class="nav-item">

                        <a class="nav-link" href="register.jsp">

                            Register

                        </a>

                    </li>



                    <li class="nav-item">

                        <a class="nav-link admin-link" href="AdminLogin.jsp">

                            <i class="bi bi-shield-lock me-1"></i>

                            Admin

                        </a>

                    </li>


                </ul>

            </div>


        </div>

    </nav>




    <!-- ================= MAIN ================= -->

    <main class="main-section">


        <!-- HERO -->

        <div class="hero-content">


            <div class="hero-tag">

                <i class="bi bi-heart-pulse me-1"></i>

                Smart Healthcare Platform

            </div>



            <h1 class="hero-title">

                Understand Your

                <span>Health.</span>

            </h1>



            <p class="hero-description">

                Explore reliable health information, understand the importance

                of a healthy lifestyle, and get personalized guidance through

                our intelligent healthcare assistants.

            </p>


        </div>




        <!-- ================= CARDS ================= -->

        <div class="cards-wrapper">


            <div class="cards-container">


                <div class="cards-row">


                    <!-- ================= MEDICAL CHATBOT ================= -->

                    <div class="card-column">


                        <div class="health-card">


                            <div class="card-icon">

                                <i class="bi bi-robot"></i>

                            </div>


                            <h3>

                                Medical Chatbot

                            </h3>


                            <p>

                                Get quick health-related information

                                and guidance through an intelligent

                                medical chatbot.

                            </p>


                            <a

                                href="medicalChatbot.jsp"

                                class="card-link">

                                Explore

                                <i class="bi bi-arrow-right"></i>

                            </a>


                        </div>


                    </div>




                    <!-- ================= HEALTH IMPORTANCE ================= -->

                    <div class="card-column">


                        <div class="health-card">


                            <div class="card-icon">

                                <i class="bi bi-heart-fill"></i>

                            </div>


                            <h3>

                                Health Matters

                            </h3>


                            <p>

                                Learn why maintaining good physical

                                and mental health is essential for

                                a better life.

                            </p>


                            <a

                                href="healthImportance.jsp"

                                class="card-link">

                                Learn More

                                <i class="bi bi-arrow-right"></i>

                            </a>


                        </div>


                    </div>




                    <!-- ================= NUTRITION CHATBOT ================= -->

                    <div class="card-column">


                        <div class="health-card">


                            <div class="card-icon">

                                <i class="bi bi-apple"></i>

                            </div>


                            <h3>

                                Nutrition Chatbot

                            </h3>


                            <p>

                                Discover nutrition information and

                                understand how food choices affect

                                your overall wellbeing.

                            </p>


                            <a

                                href="nutritionChatbot.jsp"

                                class="card-link">

                                Explore

                                <i class="bi bi-arrow-right"></i>

                            </a>


                        </div>


                    </div>


                </div>


            </div>


        </div>


    </main>




    <!-- ================= FOOTER ================= -->

    <footer>


        <p>

            © 2026

            <span>HealthCare</span>.

            Built to promote better health awareness and informed living.

        </p>


    </footer>




    <!-- Bootstrap JS -->

    <script

        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">

    </script>


</body>

</html>

