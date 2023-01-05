import 'package:flutter/widgets.dart';
import 'package:outkey_challenge/main_provider.dart';
import 'package:outkey_challenge/pages/permission.dart';
import 'package:outkey_challenge/providers/current_user_provider.dart';
import 'package:outkey_challenge/repositories/user_repository.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final BuildContext context;
  LoginProvider(this.context);

  String? _message;
  String? get message => _message;
  set message(String? message) {
    _message = message;
    notifyListeners();
  }

  Future<void> onLogin() async {
    _message = null;
    var cpf = loginController.text;
    var pwd = passwordController.text;
    var user = UserRepository.authenticate(cpf, pwd);
    if (user == null) {
      message = 'Invalid credentials';
      return;
    }
    context.read<CurrentUserProvider>().user = user;
    debugPrint('Going to permission page...');
    context.read<MainProvider>().page = const Permission();
  }
}
