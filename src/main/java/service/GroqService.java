package service;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class GroqService {

    private static final String API_URL =
            "https://api.groq.com/openai/v1/chat/completions";

    private static final String MODEL =
            "openai/gpt-oss-20b";

    private static final String SYSTEM_PROMPT =
            "You are a helpful Medical Information Assistant. " +
            "Provide general health information in simple language. " +
            "Do not diagnose diseases or prescribe medicines. " +
            "Encourage users to consult qualified healthcare professionals. " +
            "For emergencies, advise immediate medical attention. " +
            "Clearly explain that your response is not a substitute " +
            "for professional medical advice.";

    public static String generateResponse(String question)
            throws Exception {

        String apiKey = System.getenv("GROQ_API_KEY");

        if (apiKey == null || apiKey.isBlank()) {
            throw new IllegalStateException(
                    "GROQ_API_KEY environment variable is missing.");
        }

        String requestBody =
                "{"
                + "\"model\":\"" + MODEL + "\","
                + "\"messages\":["
                + "{"
                + "\"role\":\"system\","
                + "\"content\":\"" + escapeJson(SYSTEM_PROMPT) + "\""
                + "},"
                + "{"
                + "\"role\":\"user\","
                + "\"content\":\"" + escapeJson(question) + "\""
                + "}"
                + "],"
                + "\"max_completion_tokens\":1000"
                + "}";

        HttpClient client = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(15))
                .build();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(API_URL))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + apiKey)
                .timeout(Duration.ofSeconds(45))
                .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        HttpResponse<String> response = client.send(
                request,
                HttpResponse.BodyHandlers.ofString()
        );

        System.out.println("Groq Status: " + response.statusCode());

        if (response.statusCode() != 200) {
            System.out.println("Groq Error: " + response.body());

            throw new IOException(
                    "Groq API failed with status: "
                    + response.statusCode());
        }

        String answer = extractContent(response.body());

        if (answer == null || answer.isBlank()) {
            throw new IOException(
                    "Groq returned an empty response.");
        }

        return answer;
    }

    private static String escapeJson(String value) {

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    private static String extractContent(String json)
            throws IOException {

        String key = "\"content\"";
        int keyIndex = json.indexOf(key);

        if (keyIndex == -1) {
            throw new IOException(
                    "Content field not found in Groq response.");
        }

        int colonIndex = json.indexOf(":", keyIndex + key.length());
        int start = json.indexOf("\"", colonIndex + 1);

        if (colonIndex == -1 || start == -1) {
            throw new IOException("Invalid Groq response.");
        }

        StringBuilder result = new StringBuilder();
        boolean escaped = false;

        for (int i = start + 1; i < json.length(); i++) {

            char ch = json.charAt(i);

            if (escaped) {

                switch (ch) {
                    case 'n': result.append('\n'); break;
                    case 'r': result.append('\r'); break;
                    case 't': result.append('\t'); break;
                    case 'b': result.append('\b'); break;
                    case 'f': result.append('\f'); break;
                    case '"': result.append('"'); break;
                    case '\\': result.append('\\'); break;
                    case '/': result.append('/'); break;

                    case 'u':
                        if (i + 4 >= json.length()) {
                            throw new IOException(
                                    "Invalid Unicode escape.");
                        }

                        String hex = json.substring(i + 1, i + 5);
                        result.append((char) Integer.parseInt(hex, 16));
                        i += 4;
                        break;

                    default:
                        result.append(ch);
                }

                escaped = false;

            } else if (ch == '\\') {
                escaped = true;

            } else if (ch == '"') {
                return result.toString();

            } else {
                result.append(ch);
            }
        }

        throw new IOException("Incomplete Groq response.");
    }
}

