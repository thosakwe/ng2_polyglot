import '../token.dart';
import 'node.dart';

class IdentifierContext extends Node {
  final Token ID;

  String get name => ID.text;

  IdentifierContext(this.ID) {
    tokens.add(ID);
  }
}