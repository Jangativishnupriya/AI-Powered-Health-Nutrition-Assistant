package service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class GeminiService {

    // ==============================
    // GEMINI API KEY
    // ==============================
    private static final String API_KEY =
            System.getenv("GEMINI_API_KEY");

    // ==============================
    // GEMINI API URL
    // ==============================
    private static final String API_URL =
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.8-flash:generateContent?key="
            + API_KEY;


    // ==============================
    // MEDICAL AI RESPONSE
    // ==============================
    public String getMedicalResponse(String question)
            throws IOException, InterruptedException {

        if (API_KEY == null || API_KEY.isEmpty()) {

            throw new IllegalStateException(
                    "GEMINI_API_KEY environment variable is not configured."
            );
        }

        String prompt =
                "You are a medical information assistant. "
                + "Provide general health information only. "
                + "Do not diagnose the user or claim certainty. "
                + "Give simple, clear and practical information. "
                + "Explain possible common causes, general precautions, "
                + "and when the person should consult a doctor. "
                + "If the symptoms may indicate a serious condition, "
                + "clearly recommend professional medical evaluation. "
                + "If the situation appears to be an emergency, "
                + "recommend immediate emergency medical care. "
                + "Do not prescribe medicines or give specific "
                + "dosages without professional medical supervision. "
                + "Always remind the user that the response is "
                + "not a substitute for professional medical advice. "
                + "\n\nUser question: "
                + question;


        String jsonBody =
                "{"
                + "\"contents\":["
                + "{"
                + "\"parts\":["
                + "{"
                + "\"text\":"
                + jsonString(prompt)
                + "}"
                + "]"
                + "}"
                + "]"
                + "}";


        HttpClient client =
                HttpClient.newHttpClient();


        int maxAttempts = 3;


        // ==============================
        // RETRY LOOP
        // ==============================

        for (int attempt = 1;
                attempt <= maxAttempts;
                attempt++) {

            HttpRequest request =
                    HttpRequest.newBuilder()
                    .uri(URI.create(API_URL))
                    .header(
                            "Content-Type",
                            "application/json"
                    )
                    .POST(
                            HttpRequest.BodyPublishers
                                    .ofString(jsonBody)
                    )
                    .build();


            HttpResponse<String> response =
                    client.send(
                            request,
                            HttpResponse.BodyHandlers
                                    .ofString()
                    );


            System.out.println(
                    "================================="
            );

            System.out.println(
                    "Medical Gemini Attempt: "
                    + attempt
            );

            System.out.println(
                    "Gemini Status: "
                    + response.statusCode()
            );

            System.out.println(
                    "Gemini Response:"
            );

            System.out.println(
                    response.body()
            );

            System.out.println(
                    "================================="
            );


            // ==============================
            // SUCCESS
            // ==============================

            if (response.statusCode() == 200) {

                return extractText(
                        response.body()
                );
            }


            // ==============================
            // 503 - RETRY
            // ==============================

            if (response.statusCode() == 503) {

                if (attempt < maxAttempts) {

                    long waitTime =
                            attempt == 1
                            ? 2000
                            : 4000;


                    System.out.println(
                            "Gemini is temporarily "
                            + "unavailable."
                    );

                    System.out.println(
                            "Retrying after "
                            + waitTime
                            + " ms..."
                    );


                    Thread.sleep(waitTime);

                    continue;
                }


                return
                        "Gemini is temporarily unavailable "
                        + "because the model is experiencing "
                        + "high demand. Please try again "
                        + "after a few moments.";
            }


            // ==============================
            // OTHER ERRORS
            // ==============================

            return
                    "Sorry, the AI service could not "
                    + "process your request right now. "
                    + "Please try again later.";
        }


        return
                "Sorry, the AI service could not "
                + "process your request right now.";
    }


    // ==============================
    // EXTRACT AI TEXT
    // ==============================

    private String extractText(String json) {

        try {

            String searchText =
                    "\"text\":";

            int textIndex =
                    json.indexOf(searchText);


            if (textIndex == -1) {

                return
                        "Gemini returned a response, "
                        + "but no answer text was found.";
            }


            int start =
                    textIndex + searchText.length();


            while (start < json.length()
                    && Character.isWhitespace(
                            json.charAt(start))) {

                start++;
            }


            if (start >= json.length()
                    || json.charAt(start) != '"') {

                return
                        "Unable to read the AI response.";
            }


            start++;


            StringBuilder result =
                    new StringBuilder();

            boolean escaped = false;


            for (int i = start;
                    i < json.length();
                    i++) {

                char c =
                        json.charAt(i);


                if (escaped) {

                    switch (c) {

                        case 'n':
                            result.append('\n');
                            break;

                        case 'r':
                            result.append('\r');
                            break;

                        case 't':
                            result.append('\t');
                            break;

                        case '"':
                            result.append('"');
                            break;

                        case '\\':
                            result.append('\\');
                            break;

                        default:
                            result.append(c);
                            break;
                    }

                    escaped = false;

                } else if (c == '\\') {

                    escaped = true;

                } else if (c == '"') {

                    break;

                } else {

                    result.append(c);
                }
            }


            return result.toString();


        } catch (Exception e) {

            e.printStackTrace();

            return
                    "Unable to read the AI response.";
        }
    }


    // ==============================
    // JSON STRING
    // ==============================

    private String jsonString(String text) {

        return "\""
                + text
                    .replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t")
                + "\"";
    }
}