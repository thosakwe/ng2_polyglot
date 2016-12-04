import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/pretty_printer.dart';
import '../text/text.dart';

// Todo: Add a linter...
class PolyglotCompiler {
  String compile(CompilationUnitContext ast) {
    final builder = visitCompilationUnit(ast);
    final lib = builder.buildAst();
    return dartfmt(prettyToSource(lib));
  }

  LibraryBuilder visitCompilationUnit(CompilationUnitContext ctx) {
    final builder = new LibraryBuilder();
    return builder..addMember(buildClass(ctx));
  }

  ClassBuilder buildClass(CompilationUnitContext ctx) {
    final builder = new ClassBuilder('PolyglotService');
    return builder..addMethod(buildMethod(ctx));
  }

  MethodBuilder buildMethod(CompilationUnitContext ctx) {
    final builder =
        new MethodBuilder('transform', returnType: new TypeBuilder('String'));
    builder.addPositional(
        new ParameterBuilder('key', type: new TypeBuilder('String')));
    builder.addStatement(buildSwitch(ctx));
    return builder;
  }

  StatementBuilder buildSwitch(CompilationUnitContext ctx) {
    final builder = new StatementBuilder().
  }
}
