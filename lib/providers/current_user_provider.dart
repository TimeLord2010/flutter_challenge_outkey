import 'package:flutter/widgets.dart';
import 'package:outkey_challenge/models/user.dart';

class CurrentUserProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  set user(User? user) {
    _user = user;
    notifyListeners();
  }
}
