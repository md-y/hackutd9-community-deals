import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hackutd9/screens/feed.dart';
import 'package:hackutd9/screens/friends.dart';
import 'package:hackutd9/screens/nearby.dart';
import 'package:hackutd9/widgets/feed_floating_button.dart';
import 'package:hackutd9/widgets/friend_floating_button.dart';
import 'firebase_options.dart';

const String email = 'something@email.com';
const String password = 'hunter2';
const String displayName = 'John Doe';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  await FirebaseAuth.instance.currentUser?.updateDisplayName(displayName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;
  final List<Widget> _pageBodies = [
    Feed(),
    Nearby(),
    Friends(),
  ];
  final List<Widget?> _pageFloatingButtons = [
    FeedFloatingButton(),
    null,
    FriendFloatingButton(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageBodies[_pageIndex],
      floatingActionButton: _pageFloatingButtons[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (value) => setState(() {
          _pageIndex = value;
        }),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop),
            label: 'Nearby Deals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
        ],
      ),
    );
  }
}