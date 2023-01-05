import 'package:flutter/material.dart';
import 'package:outkey_challenge/models/user.dart';
import 'package:outkey_challenge/pages/profile_provider.dart';
import 'package:outkey_challenge/providers/current_user_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => ProfileProvider(c),
      child: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          return Container(
            color: provider.backgroundColor,
            child: buildContent(context, provider),
          );
        },
      ),
    );
  }

  Widget buildContent(BuildContext context, ProfileProvider provider) {
    var user = context.watch<CurrentUserProvider>().user!;
    var isAdm = user.isAdm;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildUserHeader(user, provider, isAdm),
        Expanded(
          child: FutureBuilder(
            future: provider.users,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error!.toString());
              } else if (snapshot.hasData) {
                return buildTable(snapshot.requireData);
              } else {
                return const CircularProgressIndicator.adaptive();
              }
            },
          ),
        ),
      ],
    );
  }

  Padding buildUserHeader(User user, ProfileProvider provider, bool isAdm) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const CircleAvatar(
            child: Icon(Icons.person),
          ),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 20),
                buildUserLabels(),
                const SizedBox(width: 10),
                Expanded(
                  child: buildUserData(user, provider),
                ),
                if (isAdm) ...[
                  IconButton(
                    onPressed: provider.handleEditUser,
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildUserData(User user, ProfileProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user.name,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            )),
        FutureBuilder(
          future: provider.location,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator.adaptive();
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return Text(snapshot.requireData.toString());
                } else {
                  return Text(snapshot.error!.toString());
                }
              default:
                return const Text('This should not happen.');
            }
          },
        ),
        Text(user.age.toString()),
        Text(user.isAdm.toString()),
      ],
    );
  }

  Column buildUserLabels() {
    const style = TextStyle(
      fontWeight: FontWeight.w600,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        Text('Name', style: style),
        Text('Location', style: style),
        Text('Age', style: style),
        Text('Administrator', style: style),
      ],
    );
  }

  Widget buildTable(Iterable<User> users) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text('Profile'),
          ),
          DataColumn(
            label: Text('CPF'),
          ),
          DataColumn(
            label: Text('Name'),
          ),
          DataColumn(
            label: Text('Idade'),
            numeric: true,
          ),
          DataColumn(
            label: Text('Administrator'),
          ),
        ],
        rows: users.map((x) {
          return DataRow(cells: [
            const DataCell(
              CircleAvatar(child: Icon(Icons.person)),
            ),
            DataCell(Text(x.cpf)),
            DataCell(Text(x.name)),
            DataCell(Text(x.age.toString())),
            DataCell(Checkbox(
              value: x.isAdm,
              onChanged: null,
            )),
          ]);
        }).toList(),
      ),
    );
  }
}
