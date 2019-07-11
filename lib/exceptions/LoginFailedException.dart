class LoginFailedException implements Exception {
  String message;
  LoginFailedException(this.message);

  @override
  String toString() {
    return message;
  }
}