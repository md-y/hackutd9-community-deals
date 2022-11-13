import 'package:cloud_firestore/cloud_firestore.dart';

typedef Doc = QueryDocumentSnapshot<Map<String, dynamic>>;

class GroupOrder {
  String merchant, shopper, id, discount;
  Map<String, String> orders;
  Timestamp orderDeadline;

  GroupOrder({
    required this.id,
    required this.merchant,
    required this.discount,
    required this.shopper,
    required this.orders,
    required this.orderDeadline,
  });

  factory GroupOrder.fromDocument(Doc doc) {
    var data = doc.data();
    Map<String, dynamic> dynamicMap = data['orders'];
    Map<String, String> stringMap = dynamicMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );

    return GroupOrder(
      id: doc.id,
      merchant: data['merchant'],
      shopper: data['shopper'],
      discount: data['discount'],
      orders: stringMap,
      orderDeadline: data['orderDeadline'],
    );
  }

  static CollectionReference<Map<String, dynamic>> _getGroupOrderCollection() {
    return FirebaseFirestore.instance.collection('group_orders');
  }

  static Future<GroupOrder> addGroupOrder({
    required String merchant,
    required String shopper,
    Map<String, String> orders = const {},
    required Timestamp orderDeadline,
    required String discount,
  }) async {
    var res = await _getGroupOrderCollection().add({
      'merchant': merchant,
      'shopper': shopper,
      'orders': orders,
      'orderDeadline': orderDeadline,
      'discount': discount
    });
    return GroupOrder(
      id: res.id,
      merchant: merchant,
      shopper: shopper,
      orders: orders,
      orderDeadline: orderDeadline,
      discount: discount,
    );
  }

  static Future<List<GroupOrder>> getGroupOrders() async {
    var query = _getGroupOrderCollection().where(
      'orderDeadline',
      isGreaterThanOrEqualTo: Timestamp.now(),
    );
    var res = await query.get();
    var docs = res.docs;
    return docs.map((e) => GroupOrder.fromDocument(e)).toList();
  }

  static Future<void> addOrderToGroup(
    GroupOrder groupOrder,
    String account,
    String order,
  ) async {
    Map<String, String> orders = groupOrder.orders;
    orders[account] = order;
    await _getGroupOrderCollection().doc(groupOrder.id).update({
      'orders': orders,
    });
  }
}
