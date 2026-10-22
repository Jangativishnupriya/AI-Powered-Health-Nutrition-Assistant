
package com.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import service.GeminiService;

@WebServlet("/MedicalChatbotController")
public class MedicalChatbotController extends HttpServlet {

    private static final long serialVersionUID = 1L;


    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {


        // =========================================
        // GET USER QUESTION
        // =========================================

        String question =
                request.getParameter("question");


        // Send question back to Medical.jsp
        // so it can remain in the textarea
        request.setAttribute(
                "question",
                question
        );


        System.out.println(
                "================================="
        );

        System.out.println(
                "Medical Chatbot Request"
        );

        System.out.println(
                "User Question: " + question
        );

        System.out.println(
                "================================="
        );


        // =========================================
        // CHECK EMPTY QUESTION
        // =========================================

        if (question == null
                || question.trim().isEmpty()) {


            request.setAttribute(
                    "aiResponse",
                    "Please enter a medical question."
            );


            request.getRequestDispatcher(
                    "Medical.jsp"
            ).forward(
                    request,
                    response
            );


            return;
        }


        // =========================================
        // CALL GEMINI
        // =========================================

        try {


            // Create Gemini service object
            GeminiService geminiService =
                    new GeminiService();


            // Send question to Gemini
            String aiResponse =
                    geminiService.getMedicalResponse(
                            question.trim()
                    );


            // Send Gemini response to Medical.jsp
            request.setAttribute(
                    "aiResponse",
                    aiResponse
            );


        } catch (Exception e) {


            // Print error in Eclipse/Tomcat console
            e.printStackTrace();


            // Show user-friendly error on JSP
            request.setAttribute(
                    "aiResponse",
                    "Sorry, I could not process your request "
                    + "right now. Please try again later."
            );

        }


        // =========================================
        // RETURN TO MEDICAL.JSP
        // =========================================

        request.getRequestDispatcher(
                "Medical.jsp"
        ).forward(
                request,
                response
        );

    }

}
