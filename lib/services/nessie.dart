import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

class Nessie {
  static String? _apiKey;

  static List<Map<String, dynamic>> _fixResponseData(List<dynamic>? resList) {
    return resList?.map((e) => e as Map<String, dynamic>).toList() ?? [];
  }

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
    return _fixResponseData(res.data);
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
  }

  static Future<void> resetData(String category) async {
    var apiKey = await getAPIKey();
    await Dio().fetch(
      RequestOptions(
        path: 'http://api.nessieisreal.com/data',
        queryParameters: {
          'key': apiKey,
          'type': category,
        },
        method: 'DELETE',
      ),
    );
  }

  static Future<List<Map<String, dynamic>>> getAllTansfers(
      String account) async {
    var apiKey = await getAPIKey();
    var res = await Dio().fetch(
      RequestOptions(
        path: 'http://api.nessieisreal.com/accounts/$account/transfers',
        queryParameters: {
          'key': apiKey,
        },
      ),
    );
    return _fixResponseData(res.data);
  }
}
