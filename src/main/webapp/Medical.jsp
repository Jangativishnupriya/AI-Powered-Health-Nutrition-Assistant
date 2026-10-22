
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
    private String escapeHtml(String text) {
        if (text == null) return "";

        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }

    private String formatBoldText(String text) {
        if (text == null) return "";

        return text.replaceAll(
            "\\*\\*(.*?)\\*\\*",
            "<strong>$1</strong>"
        );
    }

    private String formatAIResponse(String text) {
        if (text == null || text.trim().isEmpty()) return "";

        StringBuilder html = new StringBuilder();
        String[] lines = text.split("\\r?\\n", -1);

        boolean insideList = false;
        boolean insideOrderedList = false;

        for (String originalLine : lines) {
            String line = originalLine.trim();

            line = line.replace("\\###", "###")
                       .replace("\\##", "##")
                       .replace("\\#", "#")
                       .replace("\\*", "*")
                       .replace("\\-", "-")
                       .replace("\\>", ">");

            if (line.isEmpty()) {
                if (insideList) {
                    html.append("</ul>");
                    insideList = false;
                }

                if (insideOrderedList) {
                    html.append("</ol>");
                    insideOrderedList = false;
                }

                continue;
            }

            // Horizontal rules
            if (line.matches("^(-{3,}|\\*{3,}|_{3,})$")) {
                if (insideList) {
                    html.append("</ul>");
                    insideList = false;
                }

                if (insideOrderedList) {
                    html.append("</ol>");
                    insideOrderedList = false;
                }

                html.append("<hr class='ai-divider'>");
                continue;
            }

            // Markdown headings
            if (line.startsWith("### ")
                    || line.startsWith("## ")
                    || line.startsWith("# ")) {

                if (insideList) {
                    html.append("</ul>");
                    insideList = false;
                }

                if (insideOrderedList) {
                    html.append("</ol>");
                    insideOrderedList = false;
                }

                int prefixLength = line.startsWith("### ") ? 4
                                 : line.startsWith("## ") ? 3 : 2;

                String heading = line.substring(prefixLength).trim();

                html.append("<h4 class='ai-heading'>")
                    .append(formatBoldText(escapeHtml(heading)))
                    .append("</h4>");

                continue;
            }

            // Important notes and blockquotes
            if (line.startsWith(">")) {
                if (insideList) {
                    html.append("</ul>");
                    insideList = false;
                }

                if (insideOrderedList) {
                    html.append("</ol>");
                    insideOrderedList = false;
                }

                String note = line.substring(1).trim();

                html.append("<div class='ai-note'>")
                    .append("<i class='bi bi-info-circle-fill'></i>")
                    .append("<span>")
                    .append(formatBoldText(escapeHtml(note)))
                    .append("</span></div>");

                continue;
            }

            // Numbered lists
            if (line.matches("^\\d+\\.\\s+.*")) {
                if (insideList) {
                    html.append("</ul>");
                    insideList = false;
                }

                if (!insideOrderedList) {
                    html.append("<ol class='ai-list'>");
                    insideOrderedList = true;
                }

                String item = line.replaceFirst("^\\d+\\.\\s+", "");

                html.append("<li>")
                    .append(formatBoldText(escapeHtml(item)))
                    .append("</li>");

                continue;
            }

            // Bullet lists
            if (line.startsWith("* ") || line.startsWith("- ")) {
                if (insideOrderedList) {
                    html.append("</ol>");
                    insideOrderedList = false;
                }

                if (!insideList) {
                    html.append("<ul class='ai-list'>");
                    insideList = true;
                }

                String item = line.substring(2).trim();

                html.append("<li>")
                    .append(formatBoldText(escapeHtml(item)))
                    .append("</li>");

                continue;
            }

            // Normal paragraphs
            if (insideList) {
                html.append("</ul>");
                insideList = false;
            }

            if (insideOrderedList) {
                html.append("</ol>");
                insideOrderedList = false;
            }

            html.append("<p class='ai-paragraph'>")
                .append(formatBoldText(escapeHtml(line)))
                .append("</p>");
        }

        if (insideList) html.append("</ul>");
        if (insideOrderedList) html.append("</ol>");

        return html.toString();
    }
%>

<%
    String aiResponse =
            (String) request.getAttribute("aiResponse");

    String question =
            (String) request.getAttribute("question");

    if (question == null) {
        question = "";
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Medical Chatbot | HealthCare</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Google Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Playfair+Display:wght@600;700&display=swap"
        rel="stylesheet">

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
            display: flex;
            flex-direction: column;
            color: white;

            /* Same background as Home.jsp */
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

            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.20);
        }

        .brand {
            font-size: 24px;
            font-weight: 700;
            color: white !important;
            letter-spacing: 0.5px;
            text-decoration: none;
        }

        .brand i {
            color: #72e6d2;
            margin-right: 7px;
        }

        .navbar-custom .nav-link {
            color: rgba(255, 255, 255, 0.88) !important;
            font-weight: 500;
            margin-left: 10px;
            padding: 8px 15px !important;
            border-radius: 10px;
            transition: 0.3s ease;
        }

        .navbar-custom .nav-link:hover {
            color: white !important;
            background: rgba(255, 255, 255, 0.15);
        }

        .logout-link {
            border: 1px solid rgba(114, 230, 210, 0.5);
            color: #9ff3e4 !important;
        }

        .navbar-toggler {
            border: 1px solid rgba(255, 255, 255, 0.35);
        }

        .navbar-toggler:focus {
            box-shadow: none;
        }

        .navbar-toggler-icon {
            filter: invert(1);
        }

        /* ================= MAIN SECTION ================= */

        .medical-section {
            flex: 1;
            width: 100%;
            padding: 55px 18px 45px;

            display: flex;
            justify-content: center;
            align-items: flex-start;
        }

        .medical-container {
            width: 100%;
            max-width: 900px;
        }

        /* ================= PAGE HEADING ================= */

        .page-heading {
            text-align: center;
            margin-bottom: 32px;
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

        .page-heading h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(34px, 5vw, 48px);
            line-height: 1.15;
            font-weight: 700;
            color: white;
            margin-bottom: 12px;
        }

        .page-heading p {
            color: rgba(255, 255, 255, 0.78);
            font-size: 16px;
            line-height: 1.7;
            margin: 0;
        }

        /* ================= CHAT CARD ================= */

        .chat-card {
            padding: 32px;
            border-radius: 24px;

            background: linear-gradient(
                135deg,
                rgba(103, 230, 211, 0.13),
                rgba(255, 255, 255, 0.09),
                rgba(73, 167, 157, 0.12)
            );

            border: 1px solid rgba(255, 255, 255, 0.18);

            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);

            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
        }

        .question-label {
            display: block;
            font-size: 17px;
            font-weight: 600;
            color: white;
            margin-bottom: 12px;
        }

        .question-label i {
            color: #8ff1df;
            margin-right: 7px;
        }

        .question-box {
            width: 100%;
            min-height: 150px;
            resize: vertical;
            padding: 18px;
            border-radius: 15px;

            border: 1px solid rgba(255, 255, 255, 0.20);
            background: rgba(0, 0, 0, 0.20);

            color: white;
            font-family: 'DM Sans', sans-serif;
            font-size: 16px;
            line-height: 1.7;

            outline: none;
            transition: 0.3s;
        }

        .question-box::placeholder {
            color: rgba(255, 255, 255, 0.55);
        }

        .question-box:focus {
            border-color: #72e6d2;
            box-shadow: 0 0 0 3px rgba(114, 230, 210, 0.12);
        }

        .ask-wrapper {
            display: flex;
            justify-content: flex-end;
            margin-top: 18px;
        }

        .ask-btn {
            border: none;
            border-radius: 12px;
            padding: 12px 28px;

            background: #72e6d2;
            color: #063238;

            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .ask-btn i {
            margin-right: 7px;
        }

        .ask-btn:hover {
            transform: translateY(-2px);
            background: #a1f5e7;
            box-shadow: 0 8px 20px rgba(114, 230, 210, 0.20);
        }

        /* ================= AI RESPONSE ================= */

        .response-box {
            margin-top: 32px;
            padding: 25px;
            border-radius: 18px;

            background: rgba(0, 0, 0, 0.20);
            border: 1px solid rgba(114, 230, 210, 0.22);
        }

        .response-header {
            display: flex;
            align-items: center;
            gap: 10px;

            margin-bottom: 18px;
            padding-bottom: 15px;

            border-bottom: 1px solid rgba(255, 255, 255, 0.14);
        }

        .response-header i {
            font-size: 26px;
            color: #8ff1df;
        }

        .response-header h3 {
            margin: 0;
            font-size: 20px;
            font-weight: 700;
        }

        .response-text {
            color: rgba(255, 255, 255, 0.86);
            font-size: 15px;
            line-height: 1.8;
            overflow-wrap: anywhere;
        }

        .response-text strong {
            color: white;
            font-weight: 700;
        }

        .ai-heading {
            margin: 22px 0 12px;
            font-size: 19px;
            font-weight: 700;
            line-height: 1.45;
            color: #8ff1df;
        }

        .ai-heading:first-child {
            margin-top: 0;
        }

        .ai-paragraph {
            margin: 8px 0 12px;
            color: rgba(255, 255, 255, 0.84);
        }

        .ai-list {
            margin: 10px 0 18px;
            padding-left: 25px;
        }

        .ai-list li {
            margin-bottom: 9px;
            padding-left: 4px;
            line-height: 1.7;
            color: rgba(255, 255, 255, 0.84);
        }

        .ai-list li::marker {
            color: #72e6d2;
            font-weight: 700;
        }

        .ai-divider {
            border: 0;
            border-top: 1px solid rgba(255, 255, 255, 0.18);
            margin: 20px 0;
        }

        .ai-note {
            display: flex;
            align-items: flex-start;
            gap: 9px;

            margin: 16px 0;
            padding: 14px 16px;
            border-radius: 12px;

            background: rgba(114, 230, 210, 0.08);
            border: 1px solid rgba(114, 230, 210, 0.22);

            color: rgba(255, 255, 255, 0.80);
            font-size: 13px;
            line-height: 1.7;
        }

        .ai-note i {
            color: #8ff1df;
            margin-top: 3px;
            flex-shrink: 0;
        }

        /* ================= DISCLAIMER ================= */

        .disclaimer {
            margin-top: 24px;
            padding: 15px 18px;
            border-radius: 12px;

            background: rgba(255, 193, 7, 0.08);
            border: 1px solid rgba(255, 193, 7, 0.20);

            color: rgba(255, 255, 255, 0.75);
            font-size: 13px;
            line-height: 1.7;
        }

        .disclaimer i {
            color: #ffd166;
            margin-right: 6px;
        }

        /* ================= FOOTER — SAME AS Home.jsp ================= */

        footer {
            width: 100%;
            margin-top: auto;
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
            line-height: 1.7;
        }

        footer span {
            color: #8ff1df;
        }

        /* ================= TABLET ================= */

        @media (max-width: 991px) {
            .navbar-custom {
                padding: 12px 18px;
            }

            .navbar-custom .nav-link {
                margin-left: 0;
            }
        }

        /* ================= MOBILE ================= */

        @media (max-width: 576px) {
            .navbar-custom {
                width: 96%;
                padding: 10px 15px;
            }

            .medical-section {
                padding: 38px 13px 35px;
            }

            .chat-card {
                padding: 21px 17px;
                border-radius: 20px;
            }

            .page-heading p {
                font-size: 15px;
            }

            .ask-wrapper {
                justify-content: stretch;
            }

            .ask-btn {
                width: 100%;
            }

            .response-box {
                padding: 19px 15px;
            }

            .response-text {
                font-size: 14px;
            }
        }
    </style>
</head>

<body>

    <!-- NAVBAR: HOME, NUTRITION, LOGOUT -->

    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
        <div class="container-fluid">

            <a class="navbar-brand brand" href="Dashboard.jsp">
                <i class="bi bi-heart-pulse-fill"></i>
                HealthCare
            </a>

            <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarMenu"
                aria-controls="navbarMenu"
                aria-expanded="false"
                aria-label="Toggle navigation">

                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarMenu">
                <ul class="navbar-nav ms-auto align-items-lg-center">

                    <li class="nav-item">
                        <a class="nav-link" href="Dashboard.jsp">
                            Home
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Nutrition.jsp">
                            Nutrition
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link logout-link"
                           href="LogoutController">
                            <i class="bi bi-box-arrow-right me-1"></i>
                            Logout
                        </a>
                    </li>

                </ul>
            </div>
        </div>
    </nav>

    <!-- MAIN SECTION -->

    <main class="medical-section">
        <div class="medical-container">

            <div class="page-heading">

                <div class="hero-tag">
                    <i class="bi bi-heart-pulse me-1"></i>
                    Smart Healthcare Assistant
                </div>

                <h1>Medical Assistant</h1>

                <p>
                    Ask your health-related questions and get general
                    medical information to help you make informed decisions.
                </p>

            </div>

            <div class="chat-card">

                <!-- MEDICAL QUESTION FORM -->

                <form action="MedicalChatbotController" method="post">

                    <label class="question-label" for="question">
                        <i class="bi bi-chat-left-heart-fill"></i>
                        Ask your medical question
                    </label>

                    <textarea
                        id="question"
                        name="question"
                        class="question-box"
                        placeholder="e.g. What are common causes of headaches?"
                        required><%= escapeHtml(question) %></textarea>

                    <div class="ask-wrapper">
                        <button type="submit" class="ask-btn">
                            <i class="bi bi-heart-pulse-fill"></i>
                            Ask
                        </button>
                    </div>

                </form>

                <!-- AI RESPONSE -->

                <% if (aiResponse != null && !aiResponse.trim().isEmpty()) { %>

                    <div class="response-box">

                        <div class="response-header">
                            <i class="bi bi-robot"></i>
                            <h3>Medical Assistant</h3>
                        </div>

                        <div class="response-text">
                            <%= formatAIResponse(aiResponse) %>
                        </div>

                    </div>

                <% } %>

                <!-- MEDICAL DISCLAIMER -->

                <div class="disclaimer">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <strong>Important:</strong>
                    This AI assistant provides general health information
                    only. It is not a substitute for professional medical
                    advice, diagnosis, or treatment. If you have serious
                    or emergency symptoms, consult a qualified doctor or
                    seek immediate medical care.
                </div>

            </div>
        </div>
    </main>

    <!-- SAME FOOTER AS Home.jsp -->

    <footer>
        <p>
            © 2026 <span>HealthCare</span>. Built to promote better health
            awareness and informed living.
        </p>
    </footer>

    <!-- Bootstrap JavaScript -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
