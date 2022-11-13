import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/deal.dart';
import '../widgets/card_widget.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _Feed();
}

class _Feed extends State<Feed> {
  final Future<List<Deal>> deals = Deal.getDeals();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Your Feed'),
              centerTitle: true,
              titleTextStyle: TextStyle(fontSize: 28, fontFamily: 'BreeSerif'),
              backgroundColor: Colors.blue[600],
            ),
            body:
     Center(
      child:
        FutureBuilder(future: deals, builder: (context, snapshot)
      {
        print(snapshot.error);
      if (snapshot.hasData) {

        return ListView(children: snapshot.data!.map((e) => CardWidget(deal:e)).toList());
      }
      else {
        return CircularProgressIndicator();
      }
      })
    ),
    ),
    );
  }
}
