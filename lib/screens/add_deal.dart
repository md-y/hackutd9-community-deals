import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackutd9/services/categories.dart';
import 'package:hackutd9/services/deal.dart';
import 'package:hackutd9/services/user.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddDeal extends StatefulWidget {
  const AddDeal({super.key});

  @override
  State<AddDeal> createState() => _AddDealState();
}

class _AddDealState extends State<AddDeal> {
  final _formKey = GlobalKey<FormState>();

  late String _item, _discount;
  late int _price;
  late double _latitude, _longitude;
  late DateTime _endDate;
  List<String> _categories = [];

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
                decoration: const InputDecoration(hintText: 'What\'s on Sale?'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (newValue) => _item = newValue!,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Discount'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a discount';
                  }
                  return null;
                },
                onSaved: (newValue) => _discount = newValue!,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Original Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (newValue) => _price = int.parse(newValue!),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Latitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the latitude';
                  }
                  return null;
                },
                onSaved: (newValue) => _latitude = double.parse(newValue!),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Longitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a longitude';
                  }
                  return null;
                },
                onSaved: (newValue) => _longitude = double.parse(newValue!),
              ),
              InputDatePickerFormField(
                fieldLabelText: 'When does this sale end?',
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 5),
                onDateSaved: (value) => _endDate = value,
              ),
              ElevatedButton(
                onPressed: _showMultiSelect,
                child: const Text('Select Categories'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMultiSelect() async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          listType: MultiSelectListType.CHIP,
          items: Categories.values.map((cat) {
            return MultiSelectItem(cat, cat.toUpperCase());
          }).toList(),
          initialValue: const <String>[],
          onConfirm: (values) {
            _categories = values;
          },
          maxChildSize: 0.8,
        );
      },
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    var deal = await Deal.addDeal(
      item: _item,
      discount: _discount,
      endDate: Timestamp.fromDate(_endDate),
      location: GeoPoint(_latitude, _longitude),
      creationTime: Timestamp.now(),
      posterName: User.username,
      categories: _categories,
      price: _price,
    );
    if (mounted) Navigator.of(context).pop(deal);
  }
}
