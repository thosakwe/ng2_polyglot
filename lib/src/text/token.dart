import 'location.dart';
import 'token_type.dart';

class Token {
  Location location;
  final TokenType type;
  final String text;

  Token(this.type, this.text, {this.location});
}
