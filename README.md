# ng2_polyglot
i18n DSL and compiler for Angular2 Dart.

# Example

```polyglot
@languages [en, es];
 
"hello" {
    en: "Hello, world!",
    es: "¡Hola, mundo!"
}
```

Output:

```dart
import 'package:angular2/core.dart' show Pipe, PipeTransform;

@Pipe(name: 'polyglot')
class PolyglotPipe implements PipeTransform {
  String transform(String key, [String locale]) {
    if (key == 'hello') {
      if (locale == null) {
        return 'en';
      }
      if (locale == 'en') {
        return 'Hello, world!';
      }
      if (locale == 'es') {
        return '¡Hola, mundo!';
      }
    }
    return 'Unrecognized key: "$key"';
  }
}

```