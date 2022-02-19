class Error {
  final String message;

  const Error({required this.message});

  @override
  String toString() {
    return message;
  }
}
