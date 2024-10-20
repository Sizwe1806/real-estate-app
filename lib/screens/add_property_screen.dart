import 'package:flutter/material.dart';
import 'package:real_estate_app/models/property.dart';
import 'package:real_estate_app/services/file_handler.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  AddPropertyScreenState createState() => AddPropertyScreenState();
}

class AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _address;
  late double _price;
  late String _description;
  late String _picture;

  final List<String> _pictures = [
    'assets/property1.jpg',
    'assets/property2.jpg',
    'assets/property3.jpg',
    'assets/property4.jpg',
    'assets/property5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Property'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
                onSaved: (value) => _address = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 16),
              const Text('Select a picture:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _pictures
                    .map((picture) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _picture = picture;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: _picture == picture
                                  ? Border.all(color: Colors.blue)
                                  : null,
                            ),
                            child: Image.asset(
                              picture,
                              width: 100,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              ButtonTheme(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final property = Property(
                        address: _address,
                        price: _price,
                        picture: _picture,
                        description: _description,
                      );
                      FileHandler().writeProperties([property]);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Property'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}