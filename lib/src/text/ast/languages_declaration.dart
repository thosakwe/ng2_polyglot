import '../token.dart';
import 'identifier.dart';
import 'top_level_declaration.dart';

class LanguagesDeclarationContext extends TopLevelDeclaration {
  final Token LANGUAGES, SQUARE_L, SQUARE_R;
  final List<IdentifierContext> languages = [];

  LanguagesDeclarationContext(this.LANGUAGES, this.SQUARE_L, this.SQUARE_R) {
    tokens.addAll([LANGUAGES, SQUARE_L, SQUARE_R]);
  }

  @override
  String toSource() {
    final buf = new StringBuffer('@languages [');

    for (int i = 0; i < languages.length; i++) {
      if (i > 0) {
        buf.write(', ');
      }

      buf.write(languages[i].ID.text);
    }

    buf.write('];');
    return buf.toString();
  }
}
