import '../token.dart';
import 'node.dart';
import 'top_level_declaration.dart';

class CompilationUnitContext extends Node {
  final List<TopLevelDeclaration> topLevelDeclarations = [];

  @override
  List<Token> get tokens {
    final List<Token> tokens = [];

    for (TopLevelDeclaration decl in topLevelDeclarations) {
      tokens.addAll(decl.tokens);
    }

    return tokens;
  }

  @override
  String toSource() =>
      topLevelDeclarations.map((decl) => decl.toSource()).join();
}
