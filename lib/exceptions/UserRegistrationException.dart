class UserRegistrationException implements Exception {
  String message;
  UserRegistrationException(this.message);

  @override
  String toString() {
    return message;
  }
}