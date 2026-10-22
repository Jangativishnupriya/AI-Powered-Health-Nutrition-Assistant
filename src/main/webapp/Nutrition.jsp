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

    private String formatInlineMarkdown(String text) {
        String safe = escapeHtml(text);

        safe = safe.replaceAll("\\\\([*#_>])", "$1");

        safe = safe.replaceAll(
            "\\*\\*\\*(.+?)\\*\\*\\*",
            "<strong><em>$1</em></strong>"
        );

        safe = safe.replaceAll(
            "\\*\\*(.+?)\\*\\*",
            "<strong>$1</strong>"
        );

        safe = safe.replaceAll(
            "(?<!\\*)\\*([^*\\n]+?)\\*(?!\\*)",
            "<em>$1</em>"
        );

        safe = safe.replaceAll(
            "(?<![\\w])_([^_\\n]+?)_(?![\\w])",
            "<em>$1</em>"
        );

        return safe;
    }

    private String formatAIResponse(String text) {
        if (text == null || text.trim().isEmpty()) return "";

        StringBuilder html = new StringBuilder();
        String[] lines = text.split("\\r?\\n", -1);

        boolean inBulletList = false;
        boolean inNumberedList = false;

        for (String rawLine : lines) {
            String line = rawLine.trim();

            line = line.replace("\\###", "###")
                       .replace("\\##", "##")
                       .replace("\\#", "#")
                       .replace("\\*", "*")
                       .replace("\\-", "-")
                       .replace("\\>", ">")
                       .replace("\\_", "_");

            // Clean common literal Unicode escape artifacts.
            line = line.replace("u003e", ">")
                       .replace("u003E", ">")
                       .replace("u003c", "<")
                       .replace("u003C", "<");

            if (line.isEmpty()) {
                if (inBulletList) {
                    html.append("</ul>");
                    inBulletList = false;
                }

                if (inNumberedList) {
                    html.append("</ol>");
                    inNumberedList = false;
                }

                continue;
            }

            // Horizontal rules.
            if (line.matches("^(-{3,}|\\*{3,}|_{3,})$")) {
                if (inBulletList) {
                    html.append("</ul>");
                    inBulletList = false;
                }

                if (inNumberedList) {
                    html.append("</ol>");
                    inNumberedList = false;
                }

                html.append("<hr class=\"ai-divider\">");
                continue;
            }

            // Markdown headings.
            if (line.startsWith("### ")
                    || line.startsWith("## ")
                    || line.startsWith("# ")) {

                if (inBulletList) {
                    html.append("</ul>");
                    inBulletList = false;
                }

                if (inNumberedList) {
                    html.append("</ol>");
                    inNumberedList = false;
                }

                int prefixLength = line.startsWith("### ") ? 4
                                 : line.startsWith("## ") ? 3 : 2;

                String heading = line.substring(prefixLength).trim();

                html.append("<h4 class=\"ai-heading\">")
                    .append(formatInlineMarkdown(heading))
                    .append("</h4>");

                continue;
            }

            // Blockquotes and important notes.
            if (line.startsWith(">")) {
                if (inBulletList) {
                    html.append("</ul>");
                    inBulletList = false;
                }

                if (inNumberedList) {
                    html.append("</ol>");
                    inNumberedList = false;
                }

                String note = line.substring(1).trim();

                html.append("<div class=\"ai-note\">")
                    .append("<i class=\"bi bi-info-circle-fill\"></i>")
                    .append("<span>")
                    .append(formatInlineMarkdown(note))
                    .append("</span></div>");

                continue;
            }

            // Numbered lists.
            if (line.matches("^\\d+\\.\\s+.*")) {
                if (inBulletList) {
                    html.append("</ul>");
                    inBulletList = false;
                }

                if (!inNumberedList) {
                    html.append("<ol class=\"ai-list\">");
                    inNumberedList = true;
                }

                String item = line.replaceFirst("^\\d+\\.\\s+", "");

                html.append("<li>")
                    .append(formatInlineMarkdown(item))
                    .append("</li>");

                continue;
            }

            // Bullet lists.
            if (line.matches("^[*-]\\s+.*")) {
                if (inNumberedList) {
                    html.append("</ol>");
                    inNumberedList = false;
                }

                if (!inBulletList) {
                    html.append("<ul class=\"ai-list\">");
                    inBulletList = true;
                }

                String item = line.substring(2).trim();

                html.append("<li>")
                    .append(formatInlineMarkdown(item))
                    .append("</li>");

                continue;
            }

            // Normal paragraph.
            if (inBulletList) {
                html.append("</ul>");
                inBulletList = false;
            }

            if (inNumberedList) {
                html.append("</ol>");
                inNumberedList = false;
            }

            html.append("<p class=\"ai-paragraph\">")
                .append(formatInlineMarkdown(line))
                .append("</p>");
        }

        if (inBulletList) html.append("</ul>");
        if (inNumberedList) html.append("</ol>");

        return html.toString();
    }
%>

<%
    String aiResponse = (String) request.getAttribute("aiResponse");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Nutrition Chatbot | HealthCare</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Playfair+Display:wght@600;700&display=swap"
          rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            width: 100%;
            min-height: 100%;
            font-family: 'DM Sans', sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: white;

            /* SAME BACKGROUND IMAGE AND OVERLAY AS Home.jsp */
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

        /* NAVBAR — SAME AS Home.jsp */
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

        /* MAIN */
        .nutrition-section {
            flex: 1;
            width: 100%;
            padding: 55px 18px 45px;
        }

        .nutrition-title-box {
            text-align: center;
            margin-bottom: 30px;
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

        .nutrition-title-box h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(34px, 5vw, 48px);
            font-weight: 700;
            line-height: 1.15;
            color: white;
            margin-bottom: 12px;
        }

        .nutrition-title-box p {
            color: rgba(255, 255, 255, 0.78);
            font-size: 16px;
            line-height: 1.7;
            margin: 0;
        }

        /* GLASS UPLOAD CARD */
        .nutrition-container {
            width: 100%;
            max-width: 820px;
            margin: auto;
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

        .upload-label {
            display: block;
            color: white;
            font-size: 17px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .upload-label i {
            color: #8ff1df;
            margin-right: 7px;
        }

        .file-box {
            padding: 18px;
            border: 1px dashed rgba(255, 255, 255, 0.40);
            border-radius: 14px;
            background: rgba(0, 0, 0, 0.15);
        }

        .file-input {
            display: block;
            width: 100%;
            color: white;
        }

        .file-input::file-selector-button {
            border: none;
            border-radius: 8px;
            padding: 9px 14px;
            margin-right: 12px;
            color: #063238;
            background: #72e6d2;
            font-family: 'DM Sans', sans-serif;
            font-weight: 600;
            cursor: pointer;
        }

        .file-input::file-selector-button:hover {
            background: #a1f5e7;
        }

        .file-status {
            color: rgba(255, 255, 255, 0.72);
            font-size: 13px;
            line-height: 1.6;
            margin-top: 12px;
            overflow-wrap: anywhere;
        }

        .analyze-wrapper {
            display: flex;
            justify-content: flex-end;
            margin-top: 22px;
        }

        .analyze-btn {
            border: none;
            border-radius: 12px;
            padding: 12px 26px;
            background: #72e6d2;
            color: #063238;
            font-size: 15px;
            font-weight: 700;
            transition: 0.3s ease;
            cursor: pointer;
        }

        .analyze-btn i {
            margin-right: 7px;
        }

        .analyze-btn:hover {
            background: #a1f5e7;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(114, 230, 210, 0.20);
        }

        /* AI ANALYSIS */
        .analysis-box {
            margin-top: 32px;
            padding: 25px;
            border-radius: 18px;
            background: rgba(0, 0, 0, 0.20);
            border: 1px solid rgba(114, 230, 210, 0.22);
        }

        .analysis-header {
            display: flex;
            align-items: center;
            gap: 10px;
            font-family: 'Playfair Display', serif;
            font-size: 23px;
            font-weight: 700;
            padding-bottom: 15px;
            margin-bottom: 18px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.14);
        }

        .analysis-header i {
            color: #8ff1df;
            font-size: 25px;
        }

        .analysis-response {
            color: rgba(255, 255, 255, 0.86);
            font-size: 15px;
            line-height: 1.8;
            overflow-wrap: anywhere;
        }

        .analysis-response strong {
            color: white;
            font-weight: 700;
        }

        .analysis-response em {
            color: rgba(255, 255, 255, 0.95);
        }

        .ai-heading {
            color: #8ff1df;
            font-size: 19px;
            font-weight: 700;
            line-height: 1.45;
            margin: 23px 0 12px;
        }

        .ai-heading:first-child {
            margin-top: 0;
        }

        .ai-paragraph {
            margin: 8px 0 12px;
            color: rgba(255, 255, 255, 0.84);
        }

        .ai-list {
            padding-left: 25px;
            margin: 10px 0 18px;
        }

        .ai-list li {
            padding-left: 4px;
            margin-bottom: 9px;
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
            margin: 21px 0;
        }

        .ai-note {
            display: flex;
            align-items: flex-start;
            gap: 9px;
            margin: 15px 0;
            padding: 14px 16px;
            border-radius: 12px;
            background: rgba(114, 230, 210, 0.08);
            border: 1px solid rgba(114, 230, 210, 0.22);
            color: rgba(255, 255, 255, 0.82);
            font-size: 13px;
            line-height: 1.7;
            overflow-wrap: anywhere;
        }

        .ai-note i {
            color: #8ff1df;
            margin-top: 4px;
            flex-shrink: 0;
        }

        .analysis-disclaimer {
            margin-top: 23px;
            padding-top: 16px;
            border-top: 1px solid rgba(255, 255, 255, 0.14);
            color: rgba(255, 255, 255, 0.68);
            font-size: 12px;
            line-height: 1.7;
        }

        .analysis-disclaimer i {
            color: #8ff1df;
            margin-right: 5px;
        }

        .nutrition-note {
            max-width: 820px;
            margin: 20px auto 0;
            text-align: center;
            color: rgba(255, 255, 255, 0.72);
            font-size: 13px;
            line-height: 1.7;
        }

        /* SAME FOOTER AS Home.jsp */
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

        @media (max-width: 991px) {
            .navbar-custom {
                padding: 12px 18px;
            }

            .navbar-custom .nav-link {
                margin-left: 0;
            }
        }

        @media (max-width: 576px) {
            .navbar-custom {
                width: 96%;
                padding: 10px 15px;
            }

            .nutrition-section {
                padding: 38px 13px 35px;
            }

            .nutrition-container {
                padding: 21px 17px;
                border-radius: 20px;
            }

            .file-box {
                padding: 14px;
            }

            .analyze-wrapper {
                justify-content: stretch;
            }

            .analyze-btn {
                width: 100%;
            }

            .analysis-box {
                padding: 19px 15px;
            }

            .analysis-response {
                font-size: 14px;
            }

            .ai-heading {
                font-size: 17px;
            }
        }
    </style>
</head>

<body>

<!-- NAVBAR: HOME, MEDICAL, LOGOUT -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container-fluid">

        <a class="navbar-brand brand" href="Dashboard.jsp">
            <i class="bi bi-heart-pulse-fill"></i>HealthCare
        </a>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarMenu"
                aria-controls="navbarMenu" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMenu">
            <ul class="navbar-nav ms-auto align-items-lg-center">

                <li class="nav-item">
                    <a class="nav-link" href="Dashboard.jsp">Home</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="Medical.jsp">Medical</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link logout-link" href="LogoutController">
                        <i class="bi bi-box-arrow-right me-1"></i>Logout
                    </a>
                </li>

            </ul>
        </div>
    </div>
</nav>

<main class="nutrition-section">

    <div class="nutrition-title-box">
        <div class="hero-tag">
            <i class="bi bi-apple me-1"></i>
            Smart Nutrition Assistant
        </div>

        <h1>Nutrition Assistant</h1>

        <p>
            Upload a food image to explore its estimated nutritional value
            and discover suggestions for healthier food choices.
        </p>
    </div>

    <div class="nutrition-container">

        <form action="NutritionChatbotController"
              method="post"
              enctype="multipart/form-data">

            <label class="upload-label" for="foodImage">
                <i class="bi bi-image"></i>
                Upload a food image
            </label>

            <div class="file-box">
                <input type="file"
                       name="foodImage"
                       id="foodImage"
                       class="file-input"
                       accept="image/*"
                       required>

                <div class="file-status" id="fileStatus" aria-live="polite">
                    No file chosen
                </div>
            </div>

            <div class="analyze-wrapper">
                <button type="submit" class="analyze-btn">
                    <i class="bi bi-stars"></i>
                    Analyze Food
                </button>
            </div>

        </form>

        <% if (aiResponse != null && !aiResponse.trim().isEmpty()) { %>

            <div class="analysis-box">

                <div class="analysis-header">
                    <i class="bi bi-clipboard2-pulse"></i>
                    AI Analysis
                </div>

                <div class="analysis-response">
                    <%= formatAIResponse(aiResponse) %>
                </div>

                <div class="analysis-disclaimer">
                    <i class="bi bi-info-circle"></i>
                    Nutrition values are estimates. A photo cannot reveal
                    exact ingredients, portion sizes, or cooking methods.
                    This information is for general educational purposes
                    and is not medical advice.
                </div>

            </div>

        <% } %>

    </div>

    <p class="nutrition-note">
        Nutrition analysis is AI-generated and may not be exact.
        For personalized dietary advice, consult a qualified healthcare
        professional or registered dietitian.
    </p>

</main>

<footer>
    <p>
        © 2026 <span>HealthCare</span>. Built to promote better health
        awareness and informed living.
    </p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const foodImage = document.getElementById("foodImage");
    const fileStatus = document.getElementById("fileStatus");

    foodImage.addEventListener("change", function () {
        if (this.files && this.files.length > 0) {
            fileStatus.textContent =
                "Selected file: " + this.files[0].name;
        } else {
            fileStatus.textContent = "No file chosen";
        }
    });
</script>

</body>
</html>