import 'package:flutter/material.dart';
import 'package:hackutd9/services/categories.dart';
import 'package:hackutd9/services/group_order.dart';
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
      body: ListView(
        children: [
          Text(_groupOrders.length.toString()),
          ..._groupOrders.map((e) => GroupCardWidget(groupOrder: e)).toList(),
          ..._deals.where((cat) =>
              cat.categories.any((i) => _selectedCategories.contains(i))
          ).map((e) => CardWidget(deal: e)).toList()
        ],
      ),
    );
  }
}
