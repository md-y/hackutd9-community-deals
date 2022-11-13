import 'package:flutter/material.dart';
import 'package:hackutd9/services/categories.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../services/deal.dart';
import '../widgets/card_widget.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _Feed();
}

class _Feed extends State<Feed> {
  late Future<List<Deal>> deals = Deal.getDeals();
  List<String> _selectedCategories = Categories.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Feed'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 28, fontFamily: 'BreeSerif'),
        backgroundColor: Colors.blue[600],
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return MultiSelectDialog(
                    items: Categories.values
                        .map((cat) => MultiSelectItem(cat, cat.toUpperCase()))
                        .toList(),
                    initialValue: _selectedCategories,
                    onConfirm: (values) {
                      setState(() {
                        _selectedCategories = values;
                      });
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.sort),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: deals,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!
                    .where((cat) => cat.categories
                        .any((i) => _selectedCategories.contains(i)))
                    .map((e) => CardWidget(deal: e))
                    .toList(),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
