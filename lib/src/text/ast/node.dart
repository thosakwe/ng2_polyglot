import '../location.dart';
import '../token.dart';

class Node {
  String filename;
  final List<Token> tokens = [];

  Location get start => tokens.first.location;

  Location get stop {
    final last = tokens.last;
    final line = last.location.line;
    final index = last.location.index + last.text.length;
    return new Location(filename, line, index);
  }

  String toSource() => tokens.map((token) => token.text).join();
}
