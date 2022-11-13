import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackutd9/screens/add_deal.dart';
import 'package:hackutd9/services/deal.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required Deal this.deal});

  final Deal deal;

  @override
  State<CardWidget> createState() => _CardWidget();
}

 class _CardWidget extends State<CardWidget> {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 225,
          child: Text(
            widget.deal.price.toString(),
          )
        ),
        SizedBox(
          width: 225,
          child: Text(
            widget.deal.id,
          )
        ),
        SizedBox(
          width: 225,
          child: Text(
            widget.deal.discount,
          )
        )
      ]
    );
  }
}

