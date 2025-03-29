/// Central class for all validation logic in the app
class AppValidators {
  const AppValidators._(); // Private constructor to prevent instantiation

  /// Validates an email address
  static String? email(String? value,
      {String errorMessage = 'Please enter a valid email'}) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return errorMessage;
    }
    return null;
  }

  /// Validates a password
  static String? password(String? value,
      {int minLength = 6, String errorMessage = ''}) {
    errorMessage = errorMessage.isEmpty
        ? 'Password must be at least $minLength characters'
        : errorMessage;
    if (value == null || value.isEmpty || value.length < minLength) {
      return errorMessage;
    }
    return null;
  }

  /// Validates a required field
  static String? required(String? value,
      {String errorMessage = 'This field is required'}) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  /// Validates a numeric field
  static String? number(String? value,
      {String errorMessage = 'Please enter a valid number'}) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    if (double.tryParse(value) == null) {
      return errorMessage;
    }
    return null;
  }

  /// Validates a field with a minimum value
  static String? minValue(String? value, double min,
      {String errorMessage = ''}) {
    errorMessage =
        errorMessage.isEmpty ? 'Value must be at least $min' : errorMessage;
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    final numValue = double.tryParse(value);
    if (numValue == null || numValue < min) {
      return errorMessage;
    }
    return null;
  }

  /// Validates a field with a maximum value
  static String? maxValue(String? value, double max,
      {String errorMessage = ''}) {
    errorMessage =
        errorMessage.isEmpty ? 'Value must not exceed $max' : errorMessage;
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    final numValue = double.tryParse(value);
    if (numValue == null || numValue > max) {
      return errorMessage;
    }
    return null;
  }

  /// Combines multiple validators
  static String? combine(
      List<String? Function(String?)> validators, String? value) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
