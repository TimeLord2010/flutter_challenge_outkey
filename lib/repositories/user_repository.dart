import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:outkey_challenge/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages users saved in the local storage using SharedPreferences package.
///
/// Users are indexed by their CPF.
/// So the database looks like this:
/// | CPF | JSON data |
/// |-----|-----------|
/// | 21092303221 | { ... } |
/// | 21093838032 | { ... } |
/// | ... | ... |
///
/// To look for saved cpfs, the 'users' key was created
/// containing all the CPFs stored:
///
/// users : [21092303221, 21093838032, ...]
class UserRepository {
  static Future<void> ensureUsers() async {
    var sp = GetIt.I<SharedPreferences>();
    var users = [
      User(
        birthDate: DateTime(1997, 03, 05),
        cpf: '18628866361',
        name: 'Vinicius Gabriel dos Santos Velloso Amazonas Cotta',
        password: '123456',
        isAdm: true,
      ),
      User(
        birthDate: DateTime(1997, 03, 05),
        cpf: '68156209303',
        name: 'Gildevan Sousa',
        password: 'CrazyPassword123',
        isAdm: true,
      ),
      User(
        birthDate: DateTime(1970, 01, 01),
        cpf: '96689383059',
        name: 'Stefano Vacis',
        password: '123456',
        isAdm: false,
      ),
      User(
        birthDate: DateTime(1995, 01, 01),
        cpf: '08159028083',
        name: 'Gabriel Albuquerque',
        password: '123456',
        isAdm: false,
      ),
      User(
        birthDate: DateTime(1995, 01, 01),
        cpf: '71039431097',
        name: 'Mauricio Portfilio',
        password: '123456',
        isAdm: false,
      ),
    ];
    for (var user in users) {
      await _ensureUser(sp, user);
    }
  }

  static User? authenticate(String cpf, String pwd) {
    var sp = GetIt.I<SharedPreferences>();
    var found = sp.getString(cpf);
    if (found == null) {
      debugPrint('No user with cpf $cpf found.');
      return null;
    }
    var map = json.decode(found);
    var user = User.fromMap(map);
    if (user.cpf != cpf || user.password != pwd) {
      debugPrint('Miss matched credentials.');
      return null;
    }
    debugPrint('Valid credentials!');
    return user;
  }

  static Future<Iterable<User>> find() async {
    var sp = GetIt.I<SharedPreferences>();
    var usersCPF = sp.getStringList('users');
    if (usersCPF == null) return [];
    return _findUsersFromCpf(sp, usersCPF);
  }

  static Future<void> save(User user) async {
    var sp = GetIt.I<SharedPreferences>();
    await sp.setString(user.cpf, json.encode(user.toMap));
    await _addCPF(sp, user.cpf);
  }

  static Future<void> delete(String cpf) async {
    var sp = GetIt.I<SharedPreferences>();
    await sp.remove(cpf);
    await _removeCPF(sp, cpf);
  }

  static Future<void> _ensureUser(SharedPreferences sp, User user) async {
    var rootUser1 = sp.getString(user.cpf);
    if (rootUser1 == null) {
      debugPrint('Saving user ${user.toMap}');
      await save(user);
    } else {
      debugPrint('User with cpf ${user.cpf} already exists. Data: $rootUser1');
    }
  }

  static Future<void> _addCPF(SharedPreferences sp, String cpf) async {
    var cpfs = sp.getStringList('users');
    if (cpfs == null) {
      cpfs = [cpf];
    } else {
      cpfs.add(cpf);
    }
    await sp.setStringList('users', cpfs.toSet().toList());
  }

  static Future<void> _removeCPF(SharedPreferences sp, String cpf) async {
    var cpfs = sp.getStringList('users');
    if (cpfs == null) {
      cpfs = [];
    } else {
      cpfs.removeWhere((x) => x == cpf);
    }
    await sp.setStringList('users', cpfs.toSet().toList());
  }

  static Future<List<User>> _findUsersFromCpf(SharedPreferences sp, Iterable<String> cpfs) async {
    var users = <User>[];
    for (var cpf in cpfs) {
      var json = sp.getString(cpf);
      if (json == null) continue;
      try {
        users.add(User.fromJson(json));
      } on Exception catch (e) {
        debugPrint('There was a problem parsing data from cpf $cpf. Data: $json');
        debugPrint('The user will be deleted');
        debugPrint(e.toString());
        await delete(cpf);
      }
    }
    return users;
  }
}
