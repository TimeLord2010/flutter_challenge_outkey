import 'package:flutter/widgets.dart';
import 'package:outkey_challenge/main_provider.dart';
import 'package:outkey_challenge/pages/profile.dart';
import 'package:outkey_challenge/repositories/permission_repository.dart';
import 'package:provider/provider.dart';

class PermissionProvider extends ChangeNotifier {
  final BuildContext context;
  PermissionProvider(this.context);

  String? _message;
  String? get message => _message;
  set message(String? message) {
    _message = message;
    notifyListeners();
  }

  Future<void> onRequestPermission() async {
    _message = null;
    var granted = await PermissionRepository.requestLocationPermission();
    if (granted) {
      print('Granted');
      context.read<MainProvider>().page = const Profile();
    } else {
      message = 'Permission denied. Nothing to do now.';
    }
  }
}
