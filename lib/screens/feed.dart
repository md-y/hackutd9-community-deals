import 'package:flutter/material.dart';
import 'package:hackutd9/services/categories.dart';
import 'package:hackutd9/services/group_order.dart';
import 'package:hackutd9/widgets/card_version2.dart';
import 'package:hackutd9/widgets/group_card_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../services/deal.dart';
import '../widgets/card_widget.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _Feed();
}

class _Feed extends State<Feed> {
  List<Deal> _deals = [];
  List<GroupOrder> _groupOrders = [];
  List<String> _selectedCategories = Categories.values;

  @override
  void initState() {
    super.initState();
    Deal.getDeals().then((value) => setState(() {
      _deals = value;
    }));
    GroupOrder.getGroupOrders().then((value) => setState(() {
      _groupOrders = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 235, 218),
      appBar: AppBar(
        toolbarHeight: 120,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(40, 70, 40, 0),
            child: const Text(
                'Recommended \nFor You',
              style: TextStyle(fontSize: 30, fontFamily: 'BoldMontserrat', fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 138, 105, 81)),

            ),
          ),

          backgroundColor: Color.fromARGB(255, 253, 235, 218),
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
              icon: const Icon(Icons.sort, color: Colors.brown, size: 35),
            )
          ],
        ),
      body: ListView(
        children: [

          ..._groupOrders.map((e) => GroupCardWidget(groupOrder: e)).toList(),
          ..._deals.where((cat) =>
              cat.categories.any((i) => _selectedCategories.contains(i))
          ).map((e) => Card2(deal: e)).toList()
        ],
      ),
    );
  }
}
