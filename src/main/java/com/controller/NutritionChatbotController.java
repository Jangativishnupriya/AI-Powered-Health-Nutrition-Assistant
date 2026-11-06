
package com.controller;

import java.io.IOException;
import java.io.InputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import service.NutritionGeminiService;
import service.GroqNutritionService;

@WebServlet("/NutritionChatbotController")
@MultipartConfig(
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class NutritionChatbotController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Part foodImage = request.getPart("foodImage");

        System.out.println("=================================");
        System.out.println("Nutrition Chatbot Request");

        // Check image
        if (foodImage == null || foodImage.getSize() == 0) {

            request.setAttribute(
                    "aiResponse",
                    "Please select a food image first."
            );

            request.getRequestDispatcher("Nutrition.jsp")
                   .forward(request, response);
            return;
        }

        // Get image information
        String fileName = foodImage.getSubmittedFileName();
        String contentType = foodImage.getContentType();

        System.out.println("File Name: " + fileName);
        System.out.println("Content Type: " + contentType);
        System.out.println("File Size: " + foodImage.getSize() + " bytes");

        // Validate image
        if (contentType == null || !contentType.startsWith("image/")) {

            request.setAttribute(
                    "aiResponse",
                    "Please upload a valid food image."
            );

            request.getRequestDispatcher("Nutrition.jsp")
                   .forward(request, response);
            return;
        }

        // Read image
        try (InputStream imageInputStream = foodImage.getInputStream()) {

            byte[] imageBytes = imageInputStream.readAllBytes();

            System.out.println("Image successfully received.");
            System.out.println("Image bytes: " + imageBytes.length);

            String aiResponse;

            // =====================================
            // FIRST: TRY GEMINI
            // =====================================

            try {

                System.out.println("Calling Gemini Nutrition Service...");

                NutritionGeminiService nutritionService =
                        new NutritionGeminiService();

                aiResponse = nutritionService.analyzeFood(
                        imageBytes,
                        contentType
                );

                // Some service implementations return error
                // messages instead of throwing exceptions.
                if (aiResponse == null
                        || aiResponse.isBlank()
                        || aiResponse.contains("RESOURCE_EXHAUSTED")
                        || aiResponse.toLowerCase().contains("quota")
                        || aiResponse.contains("Gemini API failed")
                        || aiResponse.contains("Gemini API request limit")) {

                    throw new IOException(
                            "Gemini quota or service error."
                    );
                }

                System.out.println(
                        "Gemini Nutrition Response Received Successfully!"
                );

            } catch (InterruptedException e) {

                Thread.currentThread().interrupt();

                System.err.println(
                        "Gemini request interrupted: " + e.getMessage()
                );

                aiResponse =
                        "The nutrition analysis request was interrupted. "
                        + "Please try again.";

            } catch (Exception geminiError) {

                System.err.println(
                        "Gemini Nutrition Failed: "
                        + geminiError.getMessage()
                );

                // =================================
                // SECOND: TRY GROQ VISION BACKUP
                // =================================

                try {

                    System.out.println(
                            "Switching to Groq Nutrition Backup..."
                    );

                    aiResponse = GroqNutritionService.analyzeFood(
                            imageBytes,
                            contentType
                    );

                    if (aiResponse == null || aiResponse.isBlank()) {
                        throw new IOException(
                                "Groq returned an empty response."
                        );
                    }

                    System.out.println(
                            "Groq Nutrition Response Received Successfully!"
                    );

                } catch (Exception groqError) {

                    System.err.println(
                            "Groq Nutrition Backup Failed: "
                            + groqError.getMessage()
                    );

                    groqError.printStackTrace();

                    aiResponse =
                            "Sorry, both Gemini and Groq nutrition "
                            + "services are currently unavailable. "
                            + "Please try again later.";
                }
            }

            // Send response to JSP
            request.setAttribute("aiResponse", aiResponse);
        }

        // Return to Nutrition.jsp
        request.getRequestDispatcher("Nutrition.jsp")
               .forward(request, response);

        System.out.println("=================================");
    }
}
