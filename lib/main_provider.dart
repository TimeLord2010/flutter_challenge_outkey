import 'package:flutter/widgets.dart';
import 'package:outkey_challenge/pages/login.dart';

class MainProvider extends ChangeNotifier {
  Widget? _page;
  Widget get page => _page ?? const Login();
  set page(Widget v) {
    _page = v;
    notifyListeners();
  }
}
