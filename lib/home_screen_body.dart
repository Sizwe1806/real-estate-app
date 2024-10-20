import 'package:flutter/material.dart';
import 'package:real_estate_app/models/property.dart';
import 'package:real_estate_app/property_item.dart';
import 'package:real_estate_app/screens/property_detail_screen.dart';
import 'package:real_estate_app/services/file_handler.dart';


class HomeScreenBody extends StatelessWidget {
  final List<Property> properties;
  final FileHandler fileHandler;
  final Function(Property) onDelete;

  const HomeScreenBody({
    super.key,
    required this.properties,
    required this.fileHandler,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Welcome to Getters Real Estate App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Browse and manage your dream properties. Search, add, edit and delete properties with ease.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.yellow,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyDetailScreen(
                        property: properties[index],
                        fileHandler: fileHandler,
                      ),
                    ),
                  );
                },
                child: PropertyItem(
                  property: properties[index],
                  properties: properties,
                  fileHandler: fileHandler,
                  onDelete: (property) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Property'),
                        content: const Text('Are you sure you want to delete this property?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              onDelete(properties[index]);
                              Navigator.pop(context);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    ).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Property deleted successfully'),
                          duration: Duration(seconds: 4),
                        ),
                      );
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}