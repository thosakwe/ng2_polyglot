import '../token.dart';
import 'identifier.dart';
import 'node.dart';
import 'string.dart';

class KeyValuePairContext extends Node {
  final Token COLON;
  final IdentifierContext key;
  final StringContext value;

  KeyValuePairContext(this.key, this.COLON, this.value) {
    tokens
      ..addAll(key.tokens)
      ..add(COLON)
      ..addAll(value.tokens);
  }
}