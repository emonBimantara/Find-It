class AuthErrorMessage {
  static const Map<String, String> messages = {
    // Local validation
    "username is required": "Username is required.",
    "email is required": "Email is required.",
    "password is required": "Password is required.",
    "confirm password is required": "Please confirm your password.",
    "passwords do not match": "Passwords do not match.",

    // Supabase Auth
    "invalid login credentials": "Invalid email or password.",
    "user already registered": "This email is already registered.",
    "email not confirmed": "Please verify your email before signing in.",
    "password should be at least": "Password must be at least 6 characters.",
    "too many requests": "Too many attempts. Please try again later.",
    "network": "No internet connection. Please try again.",
  };

  static String getMessage(dynamic error) {
    final message = error.toString().toLowerCase();

    for (final entry in messages.entries) {
      if (message.contains(entry.key)) {
        return entry.value;
      }
    }

    return "Something went wrong. Please try again.";
  }
}
