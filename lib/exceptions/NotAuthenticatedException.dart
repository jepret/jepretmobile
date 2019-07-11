class NotAuthenticatedException implements Exception {
  String message;
  NotAuthenticatedException(this.message);
}