import 'location.dart';
import 'syntax_error.dart';
import 'token.dart';
import 'token_type.dart';

class BaseParser {
  int _index = -1;
  Location location = new Location(1, 0);
  final List<Token> tokens;

  BaseParser(this.tokens);

  bool eof() => _index >= tokens.length;

  SyntaxError expected(String msg) {
    return new SyntaxError(current != null ? '${current.location} $msg' : msg);
  }

  SyntaxError expectedType(TokenType type) {
    return expected('Expected $type, ${current?.type ?? "nothing"} found.');
  }

  Token backtrack([int n]) => read((n ?? 1) * -1);

  Token get current => eof() ? null : tokens[_index];

  bool next(TokenType type) {
    if (_index >= tokens.length - 1) {
      return false;
    }

    if (peek().type == type) {
      read();
      return true;
    }

    return false;
  }

  Token peek([int n]) => tokens[_index + n ?? 1];

  Token peekBack([int n]) => peek((n ?? -1) * -1);

  Token read([int n]) => tokens[_index += n ?? 1];

}