import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackutd9/screens/add_deal.dart';
import 'package:hackutd9/services/group_order.dart';
import 'package:hackutd9/services/deal.dart';
import 'package:decorated_icon/decorated_icon.dart';

class GroupCardWidget extends StatefulWidget {
  const GroupCardWidget({super.key, required GroupOrder this.groupOrder});

  final GroupOrder groupOrder;

  @override
  State<GroupCardWidget> createState() => _GroupCardWidget();
}

class _GroupCardWidget extends State<GroupCardWidget> {



  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[

          Container(
              margin: EdgeInsets.fromLTRB(30, 90, 0, 0)
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
                  Icons.account_circle_outlined,
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
                        "Merchant: ${widget.groupOrder.merchant}",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'BreeSerif'
                        )
                    )
                ),
                SizedBox(
                    width: 225,
                    child: Text(
                        "Shopper: ${widget.groupOrder.shopper}",
                        style: TextStyle(
                          fontSize: 25,
                        )
                    )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () => {},
                        child: Text('Join Order'),
                    ),
                  ),
                ),

              ]
          )

        ]

    )
    ;
  }
}

