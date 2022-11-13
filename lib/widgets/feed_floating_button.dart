import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hackutd9/screens/add_collab.dart';
import 'package:hackutd9/screens/add_deal.dart';

class FeedFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      children: [
        SpeedDialChild(
          label: 'Add New Deal',
          child: const Icon(Icons.price_change),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddDeal()),
            );
          },
        ),
        SpeedDialChild(
          label: 'Add New Group Order',
          child: const Icon(Icons.price_change),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddCollab()),
            );
          },
        ),
      ],
      child: const Icon(Icons.add),
    );
  }
}
