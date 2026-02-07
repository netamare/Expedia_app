bool isEmail(String value) {
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  return emailRegex.hasMatch(value);
}

bool isNotEmpty(String? value) => value != null && value.trim().isNotEmpty;