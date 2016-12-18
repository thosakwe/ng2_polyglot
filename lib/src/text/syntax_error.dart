class SyntaxError implements Exception {
  final String cause;

  SyntaxError(this.cause);

  @override
  String toString() => 'Syntax error: $cause';
}