class NotAuthenticatedException implements Exception {
  String message;
  NotAuthenticatedException(this.message);

  @override
  String toString() {
    return message;
  }
}