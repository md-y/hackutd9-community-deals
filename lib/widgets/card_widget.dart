import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackutd9/screens/add_deal.dart';
import 'package:hackutd9/services/deal.dart';
import 'package:decorated_icon/decorated_icon.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required Deal this.deal});

  final Deal deal;

  @override
  State<CardWidget> createState() => _CardWidget();
}

 class _CardWidget extends State<CardWidget> {



  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        Container(
            margin: EdgeInsets.fromLTRB(50, 90, 0, 0)
        ),

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
                Icons.star,
                color: Colors.yellow,
                size: 30,
                shadows: [Shadow(blurRadius: 20, offset: Offset(1, 0), color: Colors.brown)],
              ),


            ],
          ),
        ),

        Container(
            margin: EdgeInsets.fromLTRB(30, 90, 0, 0)
        ),

        Column(
          children: <Widget>[

            Column(
              children: <Widget>[
                Text(
                    ' '
                ),
              ],
            ),

            SizedBox(
                width: 225,
                child: Text(
                    "Price: \$${widget.deal.price.toString()}",
                    style: TextStyle(
                      fontSize: 25,
                    )
                )
            ),
            SizedBox(
                width: 225,
                child: Text(
                    "Item: ${widget.deal.item}",
                    style: TextStyle(
                      fontSize: 25,
                    )
                )
            ),
            SizedBox(
                width: 225,
                child: Text(
                    "Discount: ${widget.deal.discount}",
                    style: TextStyle(
                      fontSize: 25,
                    )
                )
            )
          ]
        )

      ]

    )
    ;
  }
}

