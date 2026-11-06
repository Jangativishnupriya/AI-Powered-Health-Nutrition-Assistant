package service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Base64;

public class GroqNutritionService {

    private static final String API_URL =
            "https://api.groq.com/openai/v1/chat/completions";

    private static final String MODEL =
            "qwen/qwen3.8-27b";

    private static final String API_KEY =
            System.getenv("GROQ_API_KEY");

    private static final HttpClient CLIENT =
            HttpClient.newBuilder()
                    .connectTimeout(Duration.ofSeconds(20))
                    .build();

    public static String analyzeFood(
            byte[] imageBytes,
            String contentType) throws IOException {

        // 1. Check API key
        if (API_KEY == null || API_KEY.isBlank()) {
            throw new IOException(
                    "GROQ_API_KEY environment variable is missing."
            );
        }

        // 2. Validate image
        if (imageBytes == null || imageBytes.length == 0) {
            throw new IOException("No image received.");
        }

        if (contentType == null) {
            throw new IOException("Image content type is missing.");
        }

        String normalizedType = contentType
                .split(";")[0]
                .trim()
                .toLowerCase();

        if (!normalizedType.equals("image/jpeg")
                && !normalizedType.equals("image/png")
                && !normalizedType.equals("image/webp")) {

            throw new IOException(
                    "Unsupported image format: " + normalizedType
            );
        }

        // 3. Convert image to Base64
        String base64Image =
                Base64.getEncoder().encodeToString(imageBytes);

        String imageDataUrl =
                "data:" + normalizedType + ";base64," + base64Image;

        // 4. System prompt
        String systemPrompt =
                "You are a helpful food and nutrition information assistant. "
                + "Analyze uploaded food images and provide general nutrition "
                + "information. Identify visible food items, estimate portion "
                + "sizes cautiously, and provide approximate calories and "
                + "macronutrients only when reasonably possible. Clearly label "
                + "all estimates as approximate. Do not invent exact nutritional "
                + "values or claim certainty about hidden ingredients. If the "
                + "food is unclear, explain the uncertainty. Provide practical "
                + "balanced-diet suggestions. Do not diagnose medical conditions "
                + "or prescribe treatment. Remind users with medical dietary "
                + "needs to consult a qualified healthcare professional.";

        // 5. User prompt
        String userPrompt =
                "Analyze this food image and provide the following sections:\n"
                + "1. Food items identified\n"
                + "2. Estimated portion size\n"
                + "3. Approximate calories\n"
                + "4. Approximate protein, carbohydrates and fats\n"
                + "5. Possible nutritional benefits\n"
                + "6. Suggestions to make this meal more balanced\n"
                + "7. A short overall nutrition summary\n\n"
                + "Use a readable format with headings and bullet points. "
                + "Mention uncertainty wherever appropriate.";

        // 6. Build JSON request safely
        String requestBody =
                "{"
                + "\"model\":" + jsonString(MODEL) + ","
                + "\"messages\":["
                + "{"
                + "\"role\":\"system\","
                + "\"content\":" + jsonString(systemPrompt)
                + "},"
                + "{"
                + "\"role\":\"user\","
                + "\"content\":["
                + "{"
                + "\"type\":\"text\","
                + "\"text\":" + jsonString(userPrompt)
                + "},"
                + "{"
                + "\"type\":\"image_url\","
                + "\"image_url\":{"
                + "\"url\":" + jsonString(imageDataUrl)
                + "}"
                + "}"
                + "]"
                + "}"
                + "],"
                + "\"temperature\":0.3,"
                + "\"max_completion_tokens\":1200,"
                + "\"stream\":false"
                + "}";

        // 7. Create HTTP request
        HttpRequest request =
                HttpRequest.newBuilder()
                        .uri(URI.create(API_URL))
                        .timeout(Duration.ofSeconds(60))
                        .header(
                                "Authorization",
                                "Bearer " + API_KEY
                        )
                        .header(
                                "Content-Type",
                                "application/json"
                        )
                        .POST(
                                HttpRequest.BodyPublishers.ofString(
                                        requestBody,
                                        StandardCharsets.UTF_8
                                )
                        )
                        .build();

        System.out.println("Calling Groq Vision API...");

        // 8. Send request
        HttpResponse<String> response;

        try {
            response = CLIENT.send(
                    request,
                    HttpResponse.BodyHandlers.ofString(
                            StandardCharsets.UTF_8
                    )
            );

        } catch (InterruptedException e) {

            Thread.currentThread().interrupt();

            throw new IOException(
                    "Groq request was interrupted.",
                    e
            );
        }

        int statusCode = response.statusCode();
        String responseBody = response.body();

        System.out.println(
                "Groq HTTP Status: " + statusCode
        );

        // 9. Check API response
        if (statusCode < 200 || statusCode >= 300) {

            System.err.println(
                    "Groq API Error: " + responseBody
            );

            throw new IOException(
                    "Groq API failed with HTTP " + statusCode
            );
        }

        // 10. Extract AI response
        String aiResponse = extractContent(responseBody);

        if (aiResponse == null || aiResponse.isBlank()) {
            throw new IOException(
                    "Groq returned an empty nutrition response."
            );
        }

        System.out.println(
                "Groq Nutrition Response Received Successfully!"
        );

        return aiResponse;
    }

    // =========================================
    // SAFE JSON STRING CREATION
    // =========================================

    private static String jsonString(String value) {

        StringBuilder result = new StringBuilder("\"");

        for (int i = 0; i < value.length(); i++) {

            char c = value.charAt(i);

            switch (c) {

                case '"':
                    result.append("\\\"");
                    break;

                case '\\':
                    result.append("\\\\");
                    break;

                case '\b':
                    result.append("\\b");
                    break;

                case '\f':
                    result.append("\\f");
                    break;

                case '\n':
                    result.append("\\n");
                    break;

                case '\r':
                    result.append("\\r");
                    break;

                case '\t':
                    result.append("\\t");
                    break;

                default:
                    if (c < 0x20) {
                        result.append(String.format("\\u%04x", (int) c));
                    } else {
                        result.append(c);
                    }
            }
        }

        result.append("\"");

        return result.toString();
    }

    // =========================================
    // EXTRACT CONTENT FROM GROQ JSON RESPONSE
    // No regular expressions used
    // =========================================

    private static String extractContent(String json)
            throws IOException {

        String key = "\"content\"";

        int keyPosition = json.indexOf(key);

        while (keyPosition != -1) {

            int position = keyPosition + key.length();

            // Skip whitespace
            while (position < json.length()
                    && Character.isWhitespace(json.charAt(position))) {
                position++;
            }

            // Expect colon
            if (position >= json.length()
                    || json.charAt(position) != ':') {

                keyPosition = json.indexOf(key, keyPosition + key.length());
                continue;
            }

            position++;

            // Skip whitespace after colon
            while (position < json.length()
                    && Character.isWhitespace(json.charAt(position))) {
                position++;
            }

            // Content must be a JSON string
            if (position < json.length()
                    && json.charAt(position) == '"') {

                return readJsonString(json, position + 1);
            }

            keyPosition = json.indexOf(key, keyPosition + key.length());
        }

        throw new IOException(
                "Could not find AI response in Groq JSON."
        );
    }

    // =========================================
    // READ AND DECODE A JSON STRING
    // =========================================

    private static String readJsonString(
            String json,
            int start) throws IOException {

        StringBuilder result = new StringBuilder();

        int i = start;

        while (i < json.length()) {

            char current = json.charAt(i);

            // End of JSON string
            if (current == '"') {
                return result.toString();
            }

            // Normal character
            if (current != '\\') {
                result.append(current);
                i++;
                continue;
            }

            // Escape sequence
            i++;

            if (i >= json.length()) {
                throw new IOException("Invalid JSON escape.");
            }

            char next = json.charAt(i);

            switch (next) {

                case '"':
                    result.append('"');
                    break;

                case '\\':
                    result.append('\\');
                    break;

                case '/':
                    result.append('/');
                    break;

                case 'b':
                    result.append('\b');
                    break;

                case 'f':
                    result.append('\f');
                    break;

                case 'n':
                    result.append('\n');
                    break;

                case 'r':
                    result.append('\r');
                    break;

                case 't':
                    result.append('\t');
                    break;

                case 'u':

                    if (i + 4 >= json.length()) {
                        throw new IOException(
                                "Invalid Unicode escape."
                        );
                    }

                    String hex = json.substring(i + 1, i + 5);

                    try {
                        result.append(
                                (char) Integer.parseInt(hex, 16)
                        );

                    } catch (NumberFormatException e) {

                        throw new IOException(
                                "Invalid Unicode escape.",
                                e
                        );
                    }

                    i += 4;
                    break;

                default:
                    throw new IOException(
                            "Invalid JSON escape character."
                    );
            }

            i++;
        }

        throw new IOException(
                "JSON response string was not properly closed."
        );
    }
}
