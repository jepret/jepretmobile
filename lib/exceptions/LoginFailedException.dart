class LoginFailedException implements Exception {
  String message;
  LoginFailedException(this.message);
}