import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackutd9/screens/add_deal.dart';
import 'package:hackutd9/services/group_order.dart';
import 'package:hackutd9/services/deal.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:hackutd9/services/nessie.dart';
import 'package:hackutd9/services/user.dart';

class GroupCardWidget extends StatefulWidget {
  const GroupCardWidget({super.key, required GroupOrder this.groupOrder});

  final GroupOrder groupOrder;

  @override
  State<GroupCardWidget> createState() => _GroupCardWidget();
}

class _GroupCardWidget extends State<GroupCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(margin: EdgeInsets.fromLTRB(30, 90, 0, 0)),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Icon(
              Icons.circle,
              size: 70,
              color: Colors.blue[300],
            ),
            DecoratedIcon(
              Icons.account_circle_outlined,
              color: Colors.yellow,
              size: 30,
              shadows: [
                Shadow(
                    blurRadius: 20, offset: Offset(1, 0), color: Colors.brown)
              ],
            ),
          ],
        ),
      ),
      Container(margin: EdgeInsets.fromLTRB(30, 90, 0, 0)),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Column(
          children: <Widget>[
            Text(' '),
          ],
        ),
        Column(
          children: <Widget>[
            Text(' '),
          ],
        ),
        SizedBox(
            width: 225,
            child: Text("Store: ${widget.groupOrder.merchant}",
                style: TextStyle(fontSize: 25, fontFamily: 'BreeSerif'))),
        SizedBox(
            width: 225,
            child: Text("Discount: ${widget.groupOrder.discount}",
                style: TextStyle(
                  fontSize: 25,
                ))),
        TextButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (ctx) {
                String? order;
                double? cost;
                return AlertDialog(
                  content: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'What is your order?',
                        ),
                        onChanged: (value) => order = value,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Cost',
                        ),
                        onChanged: (value) => cost = double.parse(value),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Order'),
                      onPressed: () async {
                        if (order != null && cost != null) {
                          await Nessie.transferMoney(
                            User.account,
                            widget.groupOrder.shopper,
                            cost!,
                          );
                          await GroupOrder.addOrderToGroup(
                            widget.groupOrder,
                            User.account,
                            order!,
                          );
                          if (mounted) Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                );
              },
            );
          },
          child: const Text('Join Order'),
        ),
      ])
    ]);
  }
}
