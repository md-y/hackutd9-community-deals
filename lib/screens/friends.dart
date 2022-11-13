import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackutd9/services/user.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final Future<List<String>> _namesFuture =
      FirebaseFirestore.instance.collection('deals').get().then(
    (res) {
      var docs = res.docs;
      List<String> names = [];
      for (var doc in docs) {
        var data = doc.data();
        var name = data['posterName'];
        if (!names.contains(name) && name != User.username) {
          names.add(name);
        }
      }
      return names;
    },
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _namesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.map((name) {
              return ListTile(
                title: Text(name),
                leading: const CircleAvatar(backgroundColor: Colors.blue),
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
