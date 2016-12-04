import '../token.dart';
import 'node.dart';
final RegExp _quotes = new RegExp(r'(^")|("$)');

class StringContext extends Node {
  final Token STRING;

  String get stringValue {
    // Todo: Allow escapes
    return STRING.text.replaceAll(_quotes, '');
  }

  StringContext(this.STRING) {
    tokens.add(STRING);
  }
}