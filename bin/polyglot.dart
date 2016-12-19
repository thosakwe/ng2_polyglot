import 'dart:io';
import 'package:args/args.dart';
import 'package:polyglot/io.dart';

main(List<String> args) async {
  try {
    final parser = createArgParser();
    final result = parser.parse(args);

    if (result['help']) {
      printUsage();
    } else {
      if (result.rest.isEmpty) {
        throw new ArgParserException('No input filename specified.');
      }

      final file = new File(result.rest.first);
      final preprocessor = new IoPreprocessor(file.parent);
      var original = parse(await file.readAsString(), filename: file.path);
      final ast = await preprocessor.processAst(original);
      final compiler = new PolyglotCompiler();
      final output = new File(result['out']);
      await output.writeAsString(compiler.compile(ast));
    }
  } catch (e) {
    if (e is ArgParserException) {
      print(e.message);
      printUsage();
    } else {
      stderr..writeln(e);
    }

    exit(1);
  }
}

void printUsage() {
  print('Usage: polyglot [options...] <filename>');
  print('Options:\n');
  print(createArgParser().usage);
}
