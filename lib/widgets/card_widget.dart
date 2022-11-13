import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String price;
  final String user;
  final int discount;

  const CardWidget({required this.price, required this.user,
  required this.discount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 225,
          child: Text(
            price,
          )
        )
      ]
    );
  }
}
