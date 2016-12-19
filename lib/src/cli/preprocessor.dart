import 'dart:async';
import '../text/text.dart';

abstract class PolyglotPreprocessor {
  Future<CompilationUnitContext> importSource(String path);

  Future<String> process(CompilationUnitContext ast) async {
    List<String> required = [];
    Map<String, Map<String, String>> dicts = {};
    Map<String, WordDeclaration> words = {};

    walkAst(CompilationUnitContext ast) async {
      for (var decl in ast.topLevelDeclarations) {
        if (decl is ImportDeclarationContext) {
          var imported = await importSource(decl.source);
          await walkAst(imported);
        } else if (decl is LanguagesDeclarationContext) {
          required.addAll(decl.languages
              .where((id) => !required.contains(id.name))
              .map((id) => id.name));
        } else if (decl is WordDeclaration) {
          var key = decl.word.stringValue;
          words[key] = words[key] ?? decl;
          dicts[key] = dicts[key] ?? {};
          dicts[key].addAll(decl.dictionary.toMap());
        }
      }
    }

    await walkAst(ast);

    // Lint
    // Just make sure all required are implemented.
    words.forEach((key, word) {
      for (var lang in required) {
        if (!dicts[key].containsKey(lang))
          throw new PolyglotPreprocessorException(
              word.start, 'Word "$key" is missing required locale $lang.');
      }
    });

    // Finally, output
    var buf = new StringBuffer();

    if (required.isNotEmpty) {
      buf.write('@languages [');

      for (int i = 0; i < required.length; i++) {
        if (i > 0) buf.write(', ');
        buf.write(required[i]);
      }

      buf.writeln('];');
    }

    words.forEach((key, word) {
      var dict = dicts[key];
      buf.writeln('"$key" {');

      for (int i = 0; i < dict.keys.length; i++) {
        var id = dict.keys.elementAt(i);

        if (i > 0) buf.writeln(',');

        buf.write('$id: "${dict[id]}"');
      }

      buf..writeln()..writeln("}");
    });

    var processed = buf.toString();
    return processed;
  }

  Future<CompilationUnitContext> processAst(CompilationUnitContext ast) async {
    return parse(await process(ast));
  }
}

class PolyglotPreprocessorException implements Exception {
  final Location location;
  final String message;

  PolyglotPreprocessorException(this.location, this.message);

  @override
  String toString() => '$location $message';
}
