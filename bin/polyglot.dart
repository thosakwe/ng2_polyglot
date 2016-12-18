import 'dart:io';
import 'package:args/args.dart';
import 'package:polyglot/polyglot.dart';

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
      final ast = parse(await file.readAsString());
      final compiler = new PolyglotCompiler();
      final output = new File(result['out']);
      await output.writeAsString(compiler.compile(ast));
    }
  } catch (e, st) {
    if (e is ArgParserException) {
      print(e.message);
      printUsage();
    } else {
      stderr..writeln(e)..writeln(st);
    }

    exit(1);
  }
}

void printUsage() {
  print('Usage: polyglot [options...] <filename>');
  print('Options:\n');
  print(createArgParser().usage);
}
