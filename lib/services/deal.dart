import 'package:cloud_firestore/cloud_firestore.dart';

typedef Doc = QueryDocumentSnapshot<Map<String, dynamic>>;

class Deal {
  String id, item, discount, posterName;
  int price;
  List<String> categories;
  DateTime endDate;
  GeoPoint location;
  Timestamp creationTime;

  Deal({
    required this.id,
    required this.item,
    required this.discount,
    required this.price,
    required this.endDate,
    required this.location,
    required this.creationTime,
    required this.posterName,
    required this.categories,
  });

  factory Deal.fromDoc(Doc doc) {
    var data = doc.data();

    List<dynamic> listDynamic = data['categories'];
    List<String> listString = listDynamic.map((e) => e.toString()).toList();

    return Deal(
      id: doc.id,
      categories: listString,
      creationTime: data['creationTime'],
      discount: data['discount'],
      endDate: data['endDate'],
      item: data['item'],
      location: data['location'],
      posterName: data['posterName'],
      price: data['price'],
    );
  }

  static CollectionReference<Map<String, dynamic>> _getDealCollection() {
    return FirebaseFirestore.instance.collection('deals');
  }

  static Future<Deal> addDeal({
    required String item,
    required String discount,
    required DateTime endDate,
    required GeoPoint location,
    required Timestamp creationTime,
    required String posterName,
    required List<String> categories,
    required int price,
  }) async {
    var res = await _getDealCollection().add({
      'item': item,
      'discount': discount,
      'endDate': endDate,
      'location': location,
      'creationTime': creationTime,
      'posterName': posterName,
      'categories': categories,
      'price': price,
    });
    return Deal(
      id: res.id,
      item: item,
      discount: discount,
      endDate: endDate,
      location: location,
      creationTime: creationTime,
      posterName: posterName,
      categories: categories,
      price: price,
    );
  }

  static Future<List<Deal>> getDeals({
    List<String> categories = const [],
    GeoPoint? centerLoc,
    int? radius,
  }) async {
    var query = _getDealCollection().where(
      'categories',
      arrayContainsAny: categories,
    );
    var res = await query.get();
    var docs = res.docs;

    List<Doc> nearbyDocs = [];
    if (centerLoc == null || radius == null) {
      nearbyDocs = docs;
    } else {
      for (var doc in docs) {
        var data = doc.data();
        var loc = data['location'] as GeoPoint;
        var latDif = centerLoc.latitude - loc.latitude;
        var longDif = centerLoc.longitude - loc.longitude;
        var distSquared = latDif * latDif + longDif * longDif;
        var radiusSquared = radius * radius;
        if (distSquared <= radiusSquared) {
          nearbyDocs.add(doc);
        }
      }
    }
    return nearbyDocs.map((e) => Deal.fromDoc(e)).toList();
  }
}
