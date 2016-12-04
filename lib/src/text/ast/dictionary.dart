import '../token.dart';
import 'key_value_pair.dart';
import 'node.dart';

class DictionaryContext extends Node {
  final Token CURLY_L, CURLY_R;
  final List<KeyValuePairContext> keyValuePairs = [];

  @override
  List<Token> get tokens {
    final List<Token> tokens = [];

    for (KeyValuePairContext keyValuePair in keyValuePairs) {
      tokens.addAll(keyValuePair.tokens);
    }

    return tokens;
  }

  DictionaryContext(this.CURLY_L, this.CURLY_R);

  @override
  String toSource() {
    final buf = new StringBuffer('@languages [');

    for (int i = 0; i < keyValuePairs.length; i++) {
      if (i > 0) {
        buf.write(', ');
      }

      buf.write(keyValuePairs[i].key.ID.text);
      buf.write(': ');
      buf.write(keyValuePairs[i].value.STRING.text);
    }

    buf.write(']');
    return buf.toString();
  }
}