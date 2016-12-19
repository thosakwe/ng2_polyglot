import '../token.dart';
import 'string.dart';
import 'top_level_declaration.dart';

class ImportDeclarationContext extends TopLevelDeclaration {
  final Token IMPORT;
  final StringContext string;

  String get source => string.stringValue;

  ImportDeclarationContext(this.IMPORT, this.string);

  @override
  String toSource() => '@import ${string.STRING.text};';
}
