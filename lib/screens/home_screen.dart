import 'package:flutter/material.dart';
import 'package:real_estate_app/home_screen_body.dart';
import 'package:real_estate_app/models/property.dart';
import 'package:real_estate_app/screens/add_property_screen.dart';
import 'package:real_estate_app/services/file_handler.dart';


class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Property> properties = []; 
  final FileHandler _fileHandler = FileHandler(); 


  void deleteProperty(Property property) {
    setState(() {
      properties.remove(property);
      _fileHandler.writeProperties(properties);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Property deleted successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fileHandler.readProperties(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Real Estate App'),
              backgroundColor: Colors.blueAccent,
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpeg'), 
                  fit: BoxFit.cover,
                ),
              ),
              child: HomeScreenBody(
                properties: snapshot.data!, 
                fileHandler: _fileHandler,
                onDelete: deleteProperty,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPropertyScreen()),
                );
              },
              tooltip: 'Add Property',
              child: const Icon(Icons.add),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}