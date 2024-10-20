import 'package:flutter/material.dart';
import 'package:real_estate_app/models/property.dart';
import 'package:real_estate_app/services/file_handler.dart';


class PropertyItem extends StatefulWidget {
  final Property property;
  final List<Property> properties;
  final FileHandler fileHandler;
  final Function(Property) onDelete;

  const PropertyItem({
    super.key,
    required this.property,
    required this.properties,
    required this.fileHandler,
    required this.onDelete,
  });

  @override
  PropertyItemState createState() => PropertyItemState();
}

class PropertyItemState extends State<PropertyItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              widget.property.picture,
              width: 100,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.property.address,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    '\$${widget.property.price}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.property.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
             onPressed: () => widget.onDelete(widget.property),
           ),
          ],
        ),
      ),
    );
  }
}