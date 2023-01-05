import 'package:flutter/material.dart';
import 'package:outkey_challenge/models/location.dart';
import 'package:outkey_challenge/models/user.dart';
import 'package:outkey_challenge/pages/edit_user.dart';
import 'package:outkey_challenge/providers/current_user_provider.dart';
import 'package:outkey_challenge/repositories/permission_repository.dart';
import 'package:outkey_challenge/repositories/user_repository.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier {
  final BuildContext context;
  ProfileProvider(this.context);
  User get user => context.read<CurrentUserProvider>().user!;

  Location? _location;
  Future<Location> get location async {
    _location ??= await PermissionRepository.location;
    return _location!;
  }

  Color get backgroundColor {
    if (user.isAdm) {
      return const Color.fromARGB(26, 212, 212, 212);
    } else {
      return const Color.fromARGB(255, 214, 230, 248);
    }
  }

  Iterable<User>? _users;
  Future<Iterable<User>> get users async {
    _users ??= await UserRepository.find();
    return _users!;
  }

  void handleEditUser() {
    var c = context;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ChangeNotifierProvider.value(
            value: c.read<CurrentUserProvider>(),
            child: const Scaffold(
              body: SafeArea(
                child: EditUser(),
              ),
            ),
          );
        },
      ),
    );
  }
}
