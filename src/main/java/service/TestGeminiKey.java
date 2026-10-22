
package service;

public class TestGeminiKey {

    public static void main(String[] args) {

        String apiKey = System.getenv("GEMINI_API_KEY");

        if (apiKey != null && !apiKey.isEmpty()) {
            System.out.println("Gemini API Key is configured!");
        } else {
            System.out.println("Gemini API Key NOT found!");
        }
    }
}
