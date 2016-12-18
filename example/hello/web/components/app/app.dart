import 'package:angular2/core.dart' show Component;
import '../../pipes/polyglot.dart';

@Component(
    selector: 'hello-app', templateUrl: 'app.html', pipes: const [PolyglotPipe])
class AppComponent {
  String locale = 'en';
  String get language => locale != null && locale.isNotEmpty ? locale : 'en';
}
