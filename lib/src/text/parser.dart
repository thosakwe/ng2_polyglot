import 'ast/ast.dart';
import 'base_parser.dart';
import 'token.dart';
import 'token_type.dart';

class Parser extends BaseParser {
  Parser(List<Token> tokens) : super(tokens);

  CompilationUnitContext compilationUnit() {
    final CompilationUnitContext ctx = new CompilationUnitContext();

    TopLevelDeclaration decl = topLevelDeclaration();

    while (decl != null) {
      ctx.topLevelDeclarations.add(decl);
      decl = topLevelDeclaration();
    }

    return ctx;
  }

  TopLevelDeclaration topLevelDeclaration() {
    print('ab');
    LanguagesContext lang = languages();

    if (lang != null) return lang;

    WordDeclaration word = wordDeclaration();

    if (word != null) return word;

    return null;
  }

  LanguagesContext languages() {
    if (next(TokenType.LANGUAGES)) {
      final LANGUAGES = current;

      if (next(TokenType.SQUARE_L)) {
        final SQUARE_L = current;
        final List<IdentifierContext> ids = [];

        while (next(TokenType.ID)) {
          ids.add(new IdentifierContext(current));

          if (!next(TokenType.COMMA)) {
            break;
          }
        }

        if (next(TokenType.SQUARE_R)) {
          final SQUARE_R = current;
          final ctx = new LanguagesContext(LANGUAGES, SQUARE_L, SQUARE_R);
          return ctx..languages.addAll(ids);
        } else {
          throw expectedType(TokenType.SQUARE_R);
        }
      } else {
        throw expectedType(TokenType.SQUARE_L);
      }
    }

    return null;
  }

  WordDeclaration wordDeclaration() {
    if (next(TokenType.STRING)) {
      final word = new StringContext(current);
      final dict = dictionary();

      if (dict == null) {
        throw expected('Expected a dictionary, but none was found.');
      }

      return new WordDeclaration(word, dict);
    }
    return null;
  }

  DictionaryContext dictionary() {
    if (next(TokenType.CURLY_L)) {
      final CURLY_L = current;
      final List<KeyValuePairContext> pairs = [];
      KeyValuePairContext kv;

      while ((kv = keyValuePair()) != null) {
        pairs.add(kv);

        if (!next(TokenType.COMMA)) {
          break;
        }
      }

      if (next(TokenType.CURLY_R)) {
        final CURLY_R = current;
        return new DictionaryContext(CURLY_L, CURLY_R)
          ..keyValuePairs.addAll(pairs);
      } else {
        throw expectedType(TokenType.CURLY_R);
      }
    }

    return null;
  }

  KeyValuePairContext keyValuePair() {
    if (next(TokenType.ID)) {
      final key = new IdentifierContext(current);

      if (next(TokenType.COLON)) {
        final COLON = current;

        if (next(TokenType.STRING)) {
          final value = new StringContext(current);
          return new KeyValuePairContext(key, COLON, value);
        } else {
          throw expectedType(TokenType.STRING);
        }
      } else {
        throw expectedType(TokenType.COLON);
      }
    }

    return null;
  }

  IdentifierContext identifier() {
    if (next(TokenType.ID)) {
      return new IdentifierContext(current);
    } else {
      return null;
    }
  }
}
