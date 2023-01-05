import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:outkey_challenge/main_provider.dart';
import 'package:outkey_challenge/providers/current_user_provider.dart';
import 'package:outkey_challenge/repositories/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sp = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(sp);
  await UserRepository.ensureUsers();
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (c) => CurrentUserProvider())], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: Consumer<MainProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Scaffold(
              body: SafeArea(
                child: Container(
                  child: value.page,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
