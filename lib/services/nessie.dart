import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

class Nessie {
  static String? _apiKey;

  static Future<String> getAPIKey() async {
    if (_apiKey != null) return _apiKey!;
    var query = FirebaseFirestore.instance.collection('meta').doc('secrets');
    var res = await query.get();
    var data = res.data();
    var key = data!['nessie'];
    _apiKey = key;
    return key;
  }

  static Future<List<Map<String, dynamic>>> getAllCustomers() async {
    var apiKey = await getAPIKey();
    var res = await Dio().fetch<List<dynamic>>(
      RequestOptions(
        path: 'http://api.nessieisreal.com/customers',
        queryParameters: {
          'key': apiKey,
        },
      ),
    );
    List<Map<String, dynamic>>? customers =
        res.data?.map((e) => e as Map<String, dynamic>).toList();
    return customers ?? [];
  }

  static Future<void> transferMoney(
    String payerAccount,
    String payeeAccount,
    double amount,
  ) async {
    var apiKey = await getAPIKey();
    await Dio().fetch(
      RequestOptions(
        path: 'http://api.nessieisreal.com/accounts/$payerAccount/transfers',
        queryParameters: {
          'key': apiKey,
        },
        method: 'POST',
        data: json.encode(
          {
            "medium": "balance",
            "payee_id": payeeAccount,
            "amount": amount,
          },
        ),
      ),
    );
    // print(res.data);
  }
}
