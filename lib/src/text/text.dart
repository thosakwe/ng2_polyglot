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

CompilationUnitContext parse(String text, {String filename}) {
  final tokens = scan(text, filename: filename);
  final parser = new Parser(filename, tokens);
  return parser.compilationUnit();
}
