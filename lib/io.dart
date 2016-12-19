import 'dart:async';
import 'dart:io';
import 'polyglot.dart';
export 'polyglot.dart';

class IoPreprocessor extends PolyglotPreprocessor {
  final Directory sourceDirectory;

  IoPreprocessor(this.sourceDirectory);

  @override
  Future<CompilationUnitContext> importSource(String path) async {
    var file = new File(path);
    return parse(await file.readAsString(), filename: path);
  }
}
