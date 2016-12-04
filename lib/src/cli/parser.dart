import 'package:args/args.dart';

ArgParser createArgParser() => new ArgParser(allowTrailingOptions: true)
  ..addFlag('help',
      abbr: 'h', help: 'Print this help information.', negatable: false)
  ..addFlag('verbose', help: 'Print verbose output.', negatable: false)
  ..addOption('out',
      abbr: 'o',
      help: 'The output file to be generated.',
      defaultsTo: 'polyglot.dart');
