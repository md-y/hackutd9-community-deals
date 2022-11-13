import 'package:flutter/material.dart';
import 'package:hackutd9/services/nessie.dart';
import 'package:hackutd9/services/user.dart';

class FriendFloatingButton extends StatelessWidget {
  const FriendFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return FutureBuilder(
              future: Nessie.getAllTansfers(User.account),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AlertDialog(
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ListView(
                        children: snapshot.data!.map((transfer) {
                          return ListTile(
                            title: Text(transfer['amount'].toString()),
                            subtitle: Text(transfer['status']),
                          );
                        }).toList(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Exit'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        );
      },
      child: const Icon(Icons.info),
    );
  }
}
