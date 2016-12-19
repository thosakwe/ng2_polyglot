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
    builder.addDirective(new ImportBuilder('package:angular2/core.dart')
      ..showAll(['Pipe', 'PipeTransform']));
    return builder..addMember(buildClass(ctx));
  }

  ClassBuilder buildClass(CompilationUnitContext ctx) {
    final builder = new ClassBuilder('PolyglotPipe')
      ..addAnnotation(new TypeBuilder('Pipe')
          .newInstance([], {'name': literal('polyglot')}))
      ..addImplement(new TypeBuilder('PipeTransform'));
    return builder..addMethod(buildMethod(ctx));
  }

  MethodBuilder buildMethod(CompilationUnitContext ctx) {
    final builder =
        new MethodBuilder('transform', returnType: new TypeBuilder('String'));
    builder.addPositional(
        new ParameterBuilder('key', type: new TypeBuilder('String')));
    builder.addPositional(
        new ParameterBuilder('locale', type: new TypeBuilder('String'))
            .asOptional());

    List<String> languages = [];

    for (var decl in ctx.topLevelDeclarations) {
      if (decl is LanguagesDeclarationContext) {
        languages.addAll(decl.languages.map((id) => id.name));
      }
    }

    for (var decl in ctx.topLevelDeclarations) {
      if (decl is WordDeclaration) {
        builder
            .addStatement(buildWord(decl, languages, decl.dictionary.toMap()));
      }
    }

    
    builder.addStatement(literal(r'Unrecognized key: "$key"').asReturn());

    return builder;
  }

  StatementBuilder buildWord(
      WordDeclaration ctx, List<String> languages, Map<String, String> dict) {
    final builder =
        ifThen(reference('key').equals(literal(ctx.word.stringValue)));

    StatementBuilder addChecker(ExpressionBuilder matcher, String value) {
      var locale = reference('locale');

      if (matcher == null) {
        var builder =
            ifThen(locale.equals(literal(null)).or(locale.property('isEmpty')));
        builder.addStatement(literal(value).asReturn());
        return builder;
      }

      var builder = ifThen(locale.equals(matcher));
      builder.addStatement(literal(value).asReturn());
      return builder;
    }

    for (int i = 0; i < languages.length; i++) {
      var language = languages[i];

      if (i == 0) builder.addStatement(addChecker(null, language));

      builder.addStatement(addChecker(literal(language), dict[language]));
    }

    return builder;
  }
}
