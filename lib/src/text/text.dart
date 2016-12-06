library polyglot.text;

import 'ast/compilation_unit.dart';
import 'parser.dart';
import 'scan.dart';
export 'ast/ast.dart';
export 'base_parser.dart';
export 'location.dart';
export 'parser.dart';
export 'scan.dart';
export 'syntax_error.dart';
export 'token.dart';
export 'token_type.dart';

CompilationUnitContext parse(String text) {
  final tokens = scan(text);
  final parser = new Parser(tokens);
  print('${tokens.length} token(s)');
  return parser.compilationUnit();
}
