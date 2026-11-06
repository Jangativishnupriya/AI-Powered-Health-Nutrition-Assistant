package service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpTimeoutException;
import java.time.Duration;

public class GeminiService {

    private static final String API_KEY =
            System.getenv("GEMINI_API_KEY");

    private static final String API_URL =
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.8-flash:generateContent";

    public String getMedicalResponse(String question)
            throws IOException, InterruptedException {

        if (API_KEY == null || API_KEY.isBlank()) {
            throw new IllegalStateException(
                    "GEMINI_API_KEY environment variable is not configured."
            );
        }

        // MEDICAL PROMPT
        String prompt =
                "You are a medical information assistant. "
                + "Provide general health information only. "
                + "Do not diagnose the user or claim certainty. "
                + "Give simple, clear and practical information. "
                + "Explain possible common causes and general precautions. "
                + "Mention when the person should consult a doctor. "
                + "For emergencies, recommend immediate medical care. "
                + "Do not prescribe medicines or specific dosages. "
                + "Keep answers concise, around 300 to 500 words. "
                + "Use simple language and headings where helpful. "
                + "Remind the user that this is not a substitute "
                + "for professional medical advice. "
                + "\n\nUser question: "
                + question;

        // JSON REQUEST BODY
        String jsonBody =
                "{"
                + "\"contents\":["
                + "{"
                + "\"parts\":["
                + "{"
                + "\"text\":" + jsonString(prompt)
                + "}"
                + "]"
                + "}"
                + "],"
                + "\"generationConfig\":{"
                + "\"maxOutputTokens\":1200,"
                + "\"thinkingConfig\":{"
                + "\"thinkingLevel\":\"LOW\""
                + "}"
                + "}"
                + "}";

        HttpClient client = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(15))
                .build();

        int maxAttempts = 3;

        // RETRY LOOP
        for (int attempt = 1;
                attempt <= maxAttempts;
                attempt++) {

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(API_URL))
                    .timeout(Duration.ofSeconds(45))
                    .header("Content-Type", "application/json")
                    .header("x-goog-api-key", API_KEY)
                    .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                    .build();

            System.out.println(
                    "Medical Gemini Attempt: " + attempt
            );

            HttpResponse<String> response;

            // HANDLE REQUEST TIMEOUT
            try {
                response = client.send(
                        request,
                        HttpResponse.BodyHandlers.ofString()
                );

            } catch (HttpTimeoutException e) {

                System.err.println(
                        "Gemini request timed out on attempt: "
                        + attempt
                );

                if (attempt < maxAttempts) {
                    System.out.println("Retrying after timeout...");
                    Thread.sleep(2000);
                    continue;
                }

                throw e;
            }

            int status = response.statusCode();

            System.out.println(
                    "Gemini Status: " + status
            );

            // SUCCESS
            if (status == 200) {

                System.out.println(
                        "Gemini response received successfully."
                );

                return extractText(response.body());
            }

            // ERROR DETAILS
            System.err.println(
                    "Gemini Error Details: " + response.body()
            );

            // RETRY HTTP 503
            if (status == 503) {

                if (attempt < maxAttempts) {

                    long waitTime =
                            attempt == 1 ? 1000 : 2000;

                    System.out.println(
                            "Gemini temporarily unavailable. Retrying..."
                    );

                    Thread.sleep(waitTime);
                    continue;
                }

                throw new IOException(
                        "Gemini is temporarily unavailable. HTTP 503"
                );
            }

            // ALL OTHER HTTP ERRORS (INCLUDING 429)
            System.err.println(
                    "Gemini API failed with status: " + status
            );

            throw new IOException(
                    "Gemini API failed with HTTP status: " + status
            );
        }

        throw new IOException(
                "Gemini service is unavailable after all retry attempts."
        );
    }

    // EXTRACT AI RESPONSE
    private String extractText(String json) {

        try {

            String searchText = "\"text\":";
            int textIndex = json.indexOf(searchText);

            if (textIndex == -1) {
                return "Gemini returned no answer text.";
            }

            int start = textIndex + searchText.length();

            while (start < json.length()
                    && Character.isWhitespace(json.charAt(start))) {
                start++;
            }

            if (start >= json.length()
                    || json.charAt(start) != '"') {
                return "Unable to read the AI response.";
            }

            start++;

            StringBuilder result = new StringBuilder();
            boolean escaped = false;

            for (int i = start; i < json.length(); i++) {

                char c = json.charAt(i);

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

                        case 'b':
                            result.append('\b');
                            break;

                        case 'f':
                            result.append('\f');
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

            return "Unable to read the AI response.";
        }
    }

    // JSON STRING ESCAPING
    private String jsonString(String text) {

        return "\""
                + text
                        .replace("\\", "\\\\")
                        .replace("\"", "\\\"")
                        .replace("\b", "\\b")
                        .replace("\f", "\\f")
                        .replace("\n", "\\n")
                        .replace("\r", "\\r")
                        .replace("\t", "\\t")
                + "\"";
    }
}
