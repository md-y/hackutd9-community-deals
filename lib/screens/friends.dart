import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackutd9/services/nessie.dart';
import 'package:hackutd9/services/user.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final Future<List<String>> _namesFuture = Nessie.getAllCustomers().then(
    (res) => res.map((customer) {
      return '${customer['first_name']} ${customer['last_name']}';
    }).toList(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 253, 235, 218),
      appBar: AppBar(
      elevation: 0,
      title: const Text('Friends'),
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 30, fontFamily: 'BoldMontserrat', fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 138, 105, 81)),
      backgroundColor: Color.fromARGB(255, 253, 235, 218),
    ),

      body: FutureBuilder(
      future: _namesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.map((name) {
              return ListTile(
                contentPadding: EdgeInsets.fromLTRB(20,8,5,8),
                title: Text(name, style: TextStyle(fontSize: 25)),
                leading: Container(
                  margin: const EdgeInsets.fromLTRB(0,2,8,5),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
    );
  }
}
