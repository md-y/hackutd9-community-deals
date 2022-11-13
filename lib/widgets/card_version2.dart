import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackutd9/screens/add_deal.dart';
import 'package:hackutd9/services/deal.dart';
import 'package:decorated_icon/decorated_icon.dart';

class Card2 extends StatefulWidget {
  const Card2({super.key, required Deal this.deal});

  final Deal deal;

  @override
  State<Card2> createState() => _Card2();
}

class _Card2 extends State<Card2> {



  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 189, 145, 112),
          borderRadius: BorderRadius.circular(15)
        ),

      child: Row(
        children: <Widget>[


          Container(
              margin: EdgeInsets.fromLTRB(20, 70, 0, 0)
          ),

          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                fit: BoxFit.fill
              )
            ),
          ),

          Container(
              margin: EdgeInsets.fromLTRB(30, 80, 0, 0)
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
                        "${widget.deal.item}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        )
                    )
                ),

                SizedBox(
                    width: 225,
                    child: Text(
                        "Original Price: \$${widget.deal.price.toString()}",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                        )
                    )
                ),

                SizedBox(
                    width: 225,
                    child: Text(
                        "Discount: ${widget.deal.discount}",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        )
                    )
                ),

                Container(
                    margin: EdgeInsets.fromLTRB(30, 20, 0, 0)
                ),
              ]
          )

        ]

    )
    );

  }
}

