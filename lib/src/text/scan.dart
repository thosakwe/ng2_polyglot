import 'package:string_scanner/string_scanner.dart';
import 'location.dart';
import 'token.dart';
import 'token_type.dart';

final RegExp _COMMENT = new RegExp(r'//([^\n])*');
final RegExp _WS = new RegExp(r'\r|\t| ');
final RegExp _DBL = new RegExp(r'"((\\")|([^"\n]))*"');
final RegExp _SNGL = new RegExp(r"'((\\')|([^'\n]))*'");
final RegExp _ID = new RegExp(r'[A-Za-z_][A-Za-z0-9_]*');

const Map<String, TokenType> _symbols = const {
  ':': TokenType.COLON,
  ',': TokenType.COMMA,
  '{': TokenType.CURLY_L,
  '}': TokenType.CURLY_R,
  ';': TokenType.SEMI,
  '[': TokenType.SQUARE_L,
  ']': TokenType.SQUARE_R
};

const Map<Pattern, TokenType> _keywords = const {
  '@import': TokenType.IMPORT,
  '@languages': TokenType.LANGUAGES
};

final Map<Pattern, TokenType> _lexRules = {
  _ID: TokenType.ID,
  _DBL: TokenType.STRING,
  _SNGL: TokenType.STRING
};

List<Token> scan(String text, {String filename}) {
  final List<Token> tokens = [];
  final scanner = new StringScanner(text);
  int line = 1, index = 0;

  while (!scanner.isDone) {
    final List<Token> potential = [];
    index++;

    if (scanner.scan('\n') || scanner.scan('\r\n')) {
      line++;
      index = 0;
      continue;
    } else if (scanner.scan(_WS)) {
      index += scanner.lastMatch[0].length;
      continue;
    } else if (scanner.scan(_COMMENT)) {
      continue;
    }

    for (String key in _symbols.keys) {
      if (scanner.matches(key)) {
        potential.add(new Token(_symbols[key], scanner.lastMatch[0]));
      }
    }

    if (potential.isEmpty) {
      for (Pattern key in _keywords.keys) {
        if (scanner.matches(key)) {
          potential.add(new Token(_keywords[key], scanner.lastMatch[0]));
        }
      }

      if (potential.isEmpty) {
        for (Pattern key in _lexRules.keys) {
          if (scanner.matches(key)) {
            potential.add(new Token(_lexRules[key], scanner.lastMatch[0]));
          }
        }
      }
    }

    if (potential.isNotEmpty) {
      potential.sort((a, b) => a.text.compareTo(b.text));
      final token = potential.first;
      token.location = new Location(filename, line, index);
      line += '\n'.allMatches(token.text).length;
      index += token.text.length;
      scanner.position += token.text.length;
      tokens.add(token);
    } else {
      scanner.readChar();
    }
  }

  return tokens;
}
