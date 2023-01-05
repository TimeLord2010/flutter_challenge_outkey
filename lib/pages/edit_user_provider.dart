import 'package:flutter/widgets.dart';
import 'package:outkey_challenge/models/user.dart';
import 'package:outkey_challenge/providers/current_user_provider.dart';
import 'package:outkey_challenge/repositories/user_repository.dart';
import 'package:provider/provider.dart';

class EditUserProvider extends ChangeNotifier {
  final BuildContext context;
  final User user;
  EditUserProvider(this.context) : user = context.read<CurrentUserProvider>().user! {
    cpfController.text = user.cpf;
    nameController.text = user.name;
    birthController.text = user.birthDate.toIso8601String().split('T')[0];
  }

  final formKey = GlobalKey<FormState>();
  final cpfController = TextEditingController();
  final nameController = TextEditingController();
  final birthController = TextEditingController();

  void save() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    var newUser = User(
      cpf: cpfController.text,
      birthDate: DateTime.parse(birthController.text),
      name: nameController.text,
      isAdm: user.isAdm,
      password: user.password,
    );
    await UserRepository.save(newUser);
    context.read<CurrentUserProvider>().user = newUser;
    Navigator.pop(context);
  }
}
