import 'package:outkey_challenge/models/user.dart';
import 'package:outkey_challenge/utils/date.dart';

String? validateCPF(String? v) {
  if (v == null) return 'CPF empty';
  var pat = RegExp(r"^[0-9]{11}$");
  if (!pat.hasMatch(v)) return 'Must contain only numbers and have 11 characters';
  return null;
}

String? validateName(String? v) {
  if (v == null) return 'Empty name';
  if (v.length < 5) return 'Name too short';
  return null;
}

String? validateBirthDate(dynamic v) {
  var dt = safeParseDate(v);
  if (dt == null) return 'Empty birth date';
  var now = DateTime.now();
  if (now.difference(dt).inDays / 365 < 18) return 'User must be 18 or older';
  return null;
}

class SafeUser {
  SafeUser.fromUser(User user) {
    cpf = user.cpf;
    name = user.name;
    password = user.password;
    birthDate = user.birthDate;
    isAdm = user.isAdm;
  }

  String? _cpf;
  String? get cpf => _cpf;
  set cpf(String? v) {
    if (validateCPF(v) != null) return;
    _cpf = v;
  }

  String? _name;
  String? get name => _name;
  set name(String? v) {
    if (validateName(v) != null) return;
    _name = v;
  }

  String? _password;
  String? get password => _password;
  set password(String? v) {
    if (v == null) return;
    if (v.length < 3) return;
    _password = v;
  }

  DateTime? _birthDate;
  DateTime? get birthDate => _birthDate;
  set birthDate(DateTime? v) {
    if (validateBirthDate(v) != null) return;
    _birthDate = birthDate;
  }

  bool isAdm = false;
}
