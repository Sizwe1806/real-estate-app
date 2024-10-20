import 'package:flutter/material.dart';
import 'package:real_estate_app/models/property.dart';
import '../services/file_handler.dart';

class PropertyDetailScreen extends StatefulWidget {
  final Property property;
  final FileHandler fileHandler;

  const PropertyDetailScreen({
    super.key,
    required this.property,
    required this.fileHandler,
  });

  @override
  PropertyDetailScreenState createState() => PropertyDetailScreenState();
}

class PropertyDetailScreenState extends State<PropertyDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String _address = '';
  double _price = 0.0;
  String _description = '';

  @override
  void initState() {
    super.initState();
    _address = widget.property.address;
    _price = widget.property.price;
    _description = widget.property.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _address,
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onSaved: (value) => _address = value!,
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
                onSaved: (value) => _price = double.parse(value!),
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.property.address = _address;
                    widget.property.price = _price;
                    widget.property.description = _description;
                    widget.fileHandler.writeProperties([widget.property]);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}