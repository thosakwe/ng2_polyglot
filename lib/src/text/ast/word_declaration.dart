import 'dictionary.dart';
import 'string.dart';
import 'top_level_declaration.dart';

class WordDeclaration extends TopLevelDeclaration {
  final StringContext word;
  final DictionaryContext dictionary;

  WordDeclaration(this.word, this.dictionary) {
    tokens
      ..addAll(word.tokens)
      ..addAll(dictionary.tokens);
  }

  @override
  String toSource() => '${word.STRING.text}${dictionary.toSource()}';
}