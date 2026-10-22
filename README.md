# 🏥 AI-Powered Health & Nutrition Assistant

An AI-powered web application that aims to make general health information and nutrition guidance more accessible through two specialized chatbots: a **Medical Chatbot** and a **Nutrition Chatbot**.

The application combines Java web development, database management, and AI integration to provide users with an interactive platform for health-related queries and food nutrition insights.

## ✨ Features

### 🩺 Medical Chatbot
- Allows users to ask general health-related questions.
- Provides AI-generated health information and general guidance.
- Offers informational support while encouraging users to consult healthcare professionals when necessary.

### 🥗 Nutrition Chatbot
- Designed to accept food images for nutrition-related analysis.
- Provides information about food and its nutritional value.
- Aims to suggest healthier dietary choices and eating habits.

### 👤 User Authentication
- User registration and login.
- Database-backed user information management.
- Personalized dashboard after login.

### 🛡️ Admin Panel
- Separate administrator login.
- View registered users.
- Manage user activation status.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Java | Backend programming |
| JSP | Dynamic web pages |
| Servlets | Request handling and application logic |
| JDBC | Java–database connectivity |
| MySQL | Relational database |
| HTML5 | Web page structure |
| CSS3 | Styling and layout |
| Bootstrap 5 | Responsive user interface |
| JavaScript | Client-side interactions |
| Apache Tomcat 11 | Web application server |
| Google Gemini API | AI-powered responses, where integrated |

## 🏗️ Application Workflow

1. Users visit the home page.
2. New users register, while existing users log in.
3. After successful authentication, users access the dashboard.
4. Users select either the Medical Chatbot or Nutrition Chatbot.
5. The backend processes the request and communicates with the configured AI service where applicable.
6. The application displays the response to the user.

## 🗄️ Database

The application uses **MySQL** to manage user information.

The `users` table contains the following fields:

| Column | Description |
|---|---|
| `user_id` | Unique user identifier |
| `Fullname` | User's full name |
| `email` | Unique email address |
| `passwordkey` | User password field |
| `age` | User's age |
| `gender` | User's gender |
| `rol` | User role, such as USER or ADMIN |
| `created_at` | Account creation timestamp |

## 🚀 Getting Started

### Prerequisites

- Java Development Kit (JDK)
- Eclipse IDE for Enterprise Java and Web Developers
- Apache Tomcat 11
- MySQL Server
- MySQL JDBC driver
- Gemini API key, if required by the implemented AI features

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/Jangativishnupriya/AI-Powered-Health-Nutrition-Assistant.git
```

**2. Import the project into Eclipse**

- Open Eclipse.
- Select **File → Import → Existing Projects into Workspace**.
- Browse to the cloned project folder and finish the import.

**3. Configure MySQL**

- Start the MySQL server.
- Create the application database.
- Create the required tables.
- Configure the JDBC URL, username, and password in the project's database connection settings.

**4. Configure the AI service**

If the chatbot uses Google Gemini, configure a valid API key through an environment variable or another secure server-side configuration method.

**5. Configure Tomcat**

- Add Apache Tomcat 11 in Eclipse.
- Associate the project with the server.
- Clean and build the project.

**6. Run the application**

- Right-click the project.
- Select **Run As → Run on Server**.
- Choose the configured Tomcat server and open the application in your browser.

## 🔐 Security and Responsible Use

- Do not commit API keys or database credentials to GitHub.
- Use secure password hashing rather than plain-text password storage.
- Validate user input and uploaded files.
- Treat AI-generated health information as general guidance, not a medical diagnosis.
- Consult a qualified healthcare professional for medical concerns and seek emergency care when necessary.

## 🔮 Future Enhancements

- Improve medical chatbot response quality and reliability.
- Enhance food-image analysis and nutrition estimation.
- Provide more personalized nutrition recommendations.
- Improve application security and input validation.
- Add more interactive features and improve the user experience.
- Introduce automated testing and improved error handling.

## 🎯 Project Objective

The objective of this project is to demonstrate how Java web technologies, relational database management, and AI integration can be combined to develop an interactive health and nutrition assistance platform.

## 👩‍💻 Author

**Vishnupriya Jangati**

- GitHub: [@Jangativishnupriya](https://github.com/Jangativishnupriya)

## ⚕️ Disclaimer

This application is intended for educational and informational purposes only. It does not replace professional medical advice, diagnosis, or treatment. AI-generated information may be inaccurate, and users should consult qualified healthcare professionals for medical decisions.

---

⭐ If you find this project interesting, feel free to explore the repository.
