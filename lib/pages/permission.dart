import 'package:flutter/widgets.dart';
import 'package:outkey_challenge/components/button.dart';
import 'package:outkey_challenge/pages/permission_provider.dart';
import 'package:provider/provider.dart';

class Permission extends StatelessWidget {
  const Permission({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => PermissionProvider(c),
      child: Consumer<PermissionProvider>(
        builder: (context, value, child) {
          return Center(
            child: Button(
              label: 'Request location permission',
              onPressed: value.onRequestPermission,
            ),
          );
        },
      ),
    );
  }
}
