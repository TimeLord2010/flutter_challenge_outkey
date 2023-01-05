import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:outkey_challenge/components/button.dart';
import 'package:outkey_challenge/components/textbox.dart' as tb;
import 'package:outkey_challenge/models/safe_user.dart';
import 'package:outkey_challenge/pages/edit_user_provider.dart';
import 'package:provider/provider.dart';

class EditUser extends StatelessWidget {
  const EditUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => EditUserProvider(c),
      child: Consumer<EditUserProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: provider.formKey,
              child: Column(
                children: [
                  tb.TextBox(
                    label: 'CPF',
                    controller: provider.cpfController,
                    validator: validateCPF,
                  ),
                  tb.TextBox(
                    label: 'Name',
                    controller: provider.nameController,
                    validator: validateName,
                  ),
                  tb.TextBox(
                    label: 'Birth date',
                    controller: provider.birthController,
                    validator: validateBirthDate,
                  ),
                  Button(
                    label: 'Save',
                    onPressed: provider.save,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
