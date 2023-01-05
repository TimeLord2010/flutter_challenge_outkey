import 'dart:convert';

import 'package:outkey_challenge/models/safe_user.dart';
import 'package:outkey_challenge/utils/date.dart';

class User {
  final String cpf, name, password;
  final DateTime birthDate;
  final bool isAdm;
  const User({
    required this.birthDate,
    required this.cpf,
    required this.name,
    required this.password,
    required this.isAdm,
  });

  factory User.fromSafeUser(SafeUser safeUser) {
    return User(
      name: safeUser.name!,
      birthDate: safeUser.birthDate!,
      cpf: safeUser.cpf!,
      password: safeUser.password!,
      isAdm: safeUser.isAdm,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      birthDate: parseDate(map['birthDate']),
      cpf: map['cpf'],
      name: map['name'],
      password: map['password'],
      isAdm: map['isAdm'] ?? false,
    );
  }

  factory User.fromJson(String json) {
    var parsed = jsonDecode(json);
    return User.fromMap(parsed);
  }

  int get age {
    var now = DateTime.now();
    return (now.difference(birthDate).inDays / 365).floor();
  }

  Map<String, dynamic> get toMap {
    return {
      'birthDate': birthDate.toIso8601String(),
      'cpf': cpf,
      'name': name,
      'password': password,
      'isAdm': isAdm,
    };
  }
}
