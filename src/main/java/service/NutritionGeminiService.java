
package service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Base64;

public class NutritionGeminiService {

    private static final String API_KEY =
            System.getenv("GEMINI_API_KEY");

    private static final String API_URL =
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.8-flash:generateContent?key="
            + API_KEY;

    private final HttpClient client =
            HttpClient.newHttpClient();

    public String analyzeFood(
            byte[] imageBytes,
            String mimeType)
            throws IOException, InterruptedException {

        if (API_KEY == null || API_KEY.isBlank()) {
            throw new IllegalStateException(
                    "GEMINI_API_KEY environment variable is not configured."
            );
        }

        if (imageBytes == null || imageBytes.length == 0) {
            return "Please select a valid food image.";
        }

        if (mimeType == null || !mimeType.startsWith("image/")) {
            return "Please upload a valid image file.";
        }

        String base64Image =
                Base64.getEncoder().encodeToString(imageBytes);

        String prompt =
                "You are a nutrition information assistant. "
                + "Analyze the food shown in the uploaded image. "
                + "Identify the most likely food or dish. "
                + "Use Markdown formatting with clear headings, "
                + "bold labels, bullet lists, and numbered lists. "
                + "Include the food name and estimated serving size. "
                + "Provide approximate calories, protein, "
                + "carbohydrates, fat, and dietary fiber. "
                + "Give an overall nutritional assessment and "
                + "practical suggestions to make the meal healthier. "
                + "Clearly explain that values are estimates because "
                + "portion size, ingredients, and cooking methods "
                + "cannot be determined precisely from an image. "
                + "If the food cannot be identified reliably, "
                + "state that clearly. Do not diagnose conditions "
                + "or prescribe medicines. Keep the answer simple.";

        String jsonBody =
                "{"
                + "\"contents\":[{"
                + "\"parts\":["
                + "{\"text\":" + jsonString(prompt) + "},"
                + "{\"inline_data\":{"
                + "\"mime_type\":" + jsonString(mimeType) + ","
                + "\"data\":" + jsonString(base64Image)
                + "}}"
                + "]"
                + "}]"
                + "}";

        int maxAttempts = 3;

        for (int attempt = 1;
                attempt <= maxAttempts;
                attempt++) {

            HttpRequest request =
                    HttpRequest.newBuilder()
                    .uri(URI.create(API_URL))
                    .header("Content-Type", "application/json")
                    .POST(
                            HttpRequest.BodyPublishers.ofString(jsonBody)
                    )
                    .build();

            HttpResponse<String> response =
                    client.send(
                            request,
                            HttpResponse.BodyHandlers.ofString()
                    );

            System.out.println("=================================");
            System.out.println(
                    "Nutrition Gemini Attempt: " + attempt
            );
            System.out.println(
                    "Nutrition Gemini Status: "
                    + response.statusCode()
            );
            System.out.println("Nutrition Gemini Response:");
            System.out.println(response.body());
            System.out.println("=================================");

            if (response.statusCode() == 200) {
                return extractText(response.body());
            }

            if (response.statusCode() == 503) {

                if (attempt < maxAttempts) {

                    long waitTime =
                            attempt == 1 ? 2000 : 4000;

                    System.out.println(
                            "Gemini returned 503. Retrying after "
                            + waitTime + " ms."
                    );

                    Thread.sleep(waitTime);
                    continue;
                }

                return "Gemini is temporarily unavailable. "
                        + "Please try again after a few moments.";
            }

            // Log the detailed API error in the server console.
            System.err.println(
                    "Gemini API error: " + response.body()
            );

            if (response.statusCode() == 429) {
                return "The Gemini API request limit or quota "
                        + "has been reached. Please check your "
                        + "Gemini API quota and try again later.";
            }

            return "Sorry, the AI nutrition service could not "
                    + "process the image right now. Please try again later.";
        }

        return "Sorry, the AI nutrition service could not "
                + "process the image right now.";
    }

    private String extractText(String json) {

        try {
            String searchText = "\"text\":";
            int textIndex = json.indexOf(searchText);

            if (textIndex == -1) {
                return "Gemini returned a response, "
                        + "but no nutrition analysis was found.";
            }

            int start = textIndex + searchText.length();

            while (start < json.length()
                    && Character.isWhitespace(json.charAt(start))) {
                start++;
            }

            if (start >= json.length()
                    || json.charAt(start) != '"') {
                return "Unable to read the Gemini response.";
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

                        case '/':
                            result.append('/');
                            break;

                        case 'u':

                            if (i + 4 < json.length()) {

                                String hex =
                                        json.substring(i + 1, i + 5);

                                try {
                                    char unicodeChar =
                                            (char) Integer.parseInt(hex, 16);

                                    result.append(unicodeChar);
                                    i += 4;

                                } catch (NumberFormatException e) {
                                    result.append("\\u");
                                }

                            } else {
                                result.append("\\u");
                            }

                            break;

                        default:
                            result.append('\\').append(c);
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

            if (escaped) {
                result.append('\\');
            }

            return result.toString();

        } catch (Exception e) {

            e.printStackTrace();

            return "Unable to read the Gemini response.";
        }
    }

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
