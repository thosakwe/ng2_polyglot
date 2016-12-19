import '../token.dart';
import 'node.dart';

final RegExp _dbl = new RegExp(r'(^")|("$)');
final RegExp _sngl = new RegExp(r"(^')|('$)");

class StringContext extends Node {
  final Token STRING;

  String get stringValue {
    // Todo: Allow escapes
    if (_dbl.hasMatch(STRING.text)) return STRING.text.replaceAll(_dbl, '');
    if (_sngl.hasMatch(STRING.text)) return STRING.text.replaceAll(_sngl, '');
    return STRING.text;
  }

  StringContext(this.STRING) {
    tokens.add(STRING);
  }
}
