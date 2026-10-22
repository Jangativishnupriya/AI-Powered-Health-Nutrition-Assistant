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

        // =========================================
        // GET UPLOADED IMAGE
        // =========================================

        Part foodImage =
                request.getPart("foodImage");

        System.out.println(
                "================================="
        );

        System.out.println(
                "Nutrition Chatbot Request"
        );

        // =========================================
        // CHECK IMAGE
        // =========================================

        if (foodImage == null
                || foodImage.getSize() == 0) {

            request.setAttribute(
                    "aiResponse",
                    "Please select a food image first."
            );

            request.getRequestDispatcher(
                    "Nutrition.jsp"
            ).forward(
                    request,
                    response
            );

            return;
        }

        // =========================================
        // GET IMAGE INFORMATION
        // =========================================

        String fileName =
                foodImage.getSubmittedFileName();

        String contentType =
                foodImage.getContentType();

        long fileSize =
                foodImage.getSize();

        System.out.println(
                "File Name: "
                + fileName
        );

        System.out.println(
                "Content Type: "
                + contentType
        );

        System.out.println(
                "File Size: "
                + fileSize
                + " bytes"
        );

        // =========================================
        // CHECK IMAGE TYPE
        // =========================================

        if (contentType == null
                || !contentType.startsWith("image/")) {

            request.setAttribute(
                    "aiResponse",
                    "Please upload a valid food image."
            );

            request.getRequestDispatcher(
                    "Nutrition.jsp"
            ).forward(
                    request,
                    response
            );

            return;
        }

        // =========================================
        // READ IMAGE BYTES
        // =========================================

        try (
            InputStream imageInputStream =
                    foodImage.getInputStream()
        ) {

            byte[] imageBytes =
                    imageInputStream.readAllBytes();

            System.out.println(
                    "Image successfully received."
            );

            System.out.println(
                    "Image bytes: "
                    + imageBytes.length
            );

            // =====================================
            // CREATE GEMINI SERVICE
            // =====================================

            NutritionGeminiService nutritionService =
                    new NutritionGeminiService();

            // =====================================
            // CALL GEMINI
            // =====================================

            try {

                String aiResponse =
                        nutritionService.analyzeFood(
                                imageBytes,
                                contentType
                        );

                // =================================
                // SEND AI RESPONSE TO JSP
                // =================================

                request.setAttribute(
                        "aiResponse",
                        aiResponse
                );

            } catch (InterruptedException e) {

                /*
                 * The current thread was interrupted
                 * while waiting for Gemini response.
                 */

                Thread.currentThread().interrupt();

                e.printStackTrace();

                request.setAttribute(
                        "aiResponse",
                        "The AI service request was "
                        + "interrupted. Please try again."
                );

            } catch (IOException e) {

                /*
                 * Problem while communicating
                 * with Gemini API.
                 */

                e.printStackTrace();

                request.setAttribute(
                        "aiResponse",
                        "Unable to connect to the AI "
                        + "nutrition service. "
                        + "Please try again later."
                );
            }
        }

        // =========================================
        // RETURN TO NUTRITION.JSP
        // =========================================

        request.getRequestDispatcher(
                "Nutrition.jsp"
        ).forward(
                request,
                response
        );

        System.out.println(
                "================================="
        );
    }
}