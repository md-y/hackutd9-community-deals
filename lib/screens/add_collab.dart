import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackutd9/services/categories.dart';
import 'package:hackutd9/services/group_order.dart';
import 'package:hackutd9/services/user.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddCollab extends StatefulWidget {
  const AddCollab({super.key});

  @override
  State<AddCollab> createState() => _AddCollabState();
}

class _AddCollabState extends State<AddCollab> {
  final _formKey = GlobalKey<FormState>();

  late String _merchant, _discount;
  late int _price;
  late DateTime _endDate;
  Map<String, String> _orders = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _submit(),
        child: const Icon(Icons.save),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Merchant'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the seller/merchant';
                  }
                  return null;
                },
                onSaved: (newValue) => _merchant = newValue!,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Discount'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the discount';
                  }
                  return null;
                },
                onSaved: (newValue) => _discount = newValue!,
              ),
              InputDatePickerFormField(
                fieldLabelText: 'When does this order end?',
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 5),
                onDateSaved: (value) => _endDate = value,
              ),
              ElevatedButton(
                onPressed: () => {},
                child: const Text('Select Categories'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    var deal = await GroupOrder.addGroupOrder(
      merchant: _merchant,
      shopper: User.account,
      discount: _discount,
      orders: _orders,
      orderDeadline: Timestamp.fromDate(_endDate),
    );
    if (mounted) Navigator.of(context).pop(deal);
  }
}
