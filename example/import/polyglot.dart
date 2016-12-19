import 'package:angular2/core.dart' show Pipe, PipeTransform;

@Pipe(name: 'polyglot')
class PolyglotPipe implements PipeTransform {
  String transform(String key, [String locale]) {
    if (key == 'hello') {
      if (locale == null) {
        return 'en';
      }
      if (locale == 'en') {
        return 'Hello!';
      }
      if (locale == 'es') {
        return 'Hola!';
      }
    }
    return 'Unrecognized key: "$key"';
  }
}
