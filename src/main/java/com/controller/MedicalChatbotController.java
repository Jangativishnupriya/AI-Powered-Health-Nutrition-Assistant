package com.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import service.GeminiService;
import service.GroqService;

@WebServlet("/MedicalChatbotController")
public class MedicalChatbotController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String question = request.getParameter("question");

        request.setAttribute("question", question);

        System.out.println("Medical Chatbot Request Received");

        // CHECK EMPTY QUESTION
        if (question == null || question.trim().isEmpty()) {

            request.setAttribute(
                    "aiResponse",
                    "Please enter a medical question."
            );

            request.getRequestDispatcher("Medical.jsp")
                    .forward(request, response);

            return;
        }

        String aiResponse;

        // FIRST: TRY GEMINI
        try {

            System.out.println("Calling Gemini Service...");

            GeminiService geminiService = new GeminiService();

            aiResponse = geminiService.getMedicalResponse(
                    question.trim()
            );

            // Detect errors returned as text instead of exceptions
            if (aiResponse == null || aiResponse.isBlank()
                    || aiResponse.contains("Gemini API failed with status:")
                    || aiResponse.contains("RESOURCE_EXHAUSTED")
                    || aiResponse.toLowerCase().contains("quota exceeded")) {

                throw new IOException("Gemini quota or service error.");
            }

            System.out.println("Gemini Response Received Successfully!");

        } catch (Exception geminiError) {

            System.err.println(
                    "Gemini failed: " + geminiError.getMessage()
            );

            // SECOND: TRY GROQ BACKUP
            try {

                System.out.println("Switching to Groq Backup...");

                aiResponse = GroqService.generateResponse(
                        question.trim()
                );

                System.out.println("Groq Response Received Successfully!");

            } catch (Exception groqError) {

                System.err.println(
                        "Groq Backup Failed: " + groqError.getMessage()
                );

                groqError.printStackTrace();

                aiResponse =
                        "Sorry, both AI services are currently unavailable. "
                        + "Please try again later or consult a qualified "
                        + "healthcare professional for medical concerns.";
            }
        }

        request.setAttribute("aiResponse", aiResponse);

        // RETURN TO MEDICAL JSP
        request.getRequestDispatcher("Medical.jsp")
                .forward(request, response);
    }
}
