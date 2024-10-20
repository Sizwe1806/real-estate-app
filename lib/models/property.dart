 

// A list of currently available properties
List<Property> properties = [
  Property(
    address: '123 Main St, New York, NY 10001',
    price: 500000,
    picture: 'assets/Property1.jpg',
    description: 'Luxury apartment in Manhattan',
  ),
  Property(
    address: '456 Elm St, Los Angeles, CA 90001',
    price: 750000,
    picture: 'assets/Property2.jpg',
    description: 'Modern villa in Beverly Hills',
  ),
  Property(
    address: '789 Oak St, Chicago, IL 60601',
    price: 300000,
    picture: 'assets/Property3.jpg',
    description: 'Cozy townhouse in downtown Chicago',
  ),
    
];


class Property {
  String address;
  double price;
  String picture;
  String description;

  Property({required this.address, required this.price, required this.picture, required this.description});

  factory Property.fromJSON(Map<String, dynamic> json) {
    return Property(
      address: json['address'],
      price: json['price'],
      picture: json['picture'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'address': address,
      'price': price,
      'picture': picture,
      'description': description,
    };
  }

  factory Property.fromCSV(String csv) {
    final parts = csv.split(',');
    return Property(
      address: parts[0],
      price: double.parse(parts[1]),
      picture: parts[2],
      description: parts[3],
    );
  }

  String toCSV() {
    return '$address,$price,$picture,$description';
  }
}

