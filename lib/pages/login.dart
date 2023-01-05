import 'package:flutter/material.dart';
import 'package:outkey_challenge/components/button.dart';
import 'package:outkey_challenge/components/textbox.dart' as tb;
import 'package:outkey_challenge/pages/login_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => LoginProvider(c),
      child: Consumer<LoginProvider>(
        builder: (context, value, child) {
          var height = MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: height,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    tb.TextBox(
                      label: 'CPF',
                      controller: value.loginController,
                    ),
                    const SizedBox(height: 20),
                    tb.TextBox(
                      label: 'Senha',
                      controller: value.passwordController,
                    ),
                    const SizedBox(height: 40),
                    Button(
                      label: 'Login',
                      onPressed: value.onLogin,
                    ),
                    if (value.message != null) ...[
                      const SizedBox(height: 10),
                      buildMessage(value),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildMessage(LoginProvider provider) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        provider.message ?? '',
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
