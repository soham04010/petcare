import 'package:flutter/material.dart';
import '../colors.dart';

class ProductsScreen extends StatelessWidget {
  // Dummy list of products
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Dog Food',
      'price': '₹500',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Cat Toy',
      'price': '₹200',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Bird Cage',
      'price': '₹1500',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Fish Tank',
      'price': '₹2500',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Pet Shampoo',
      'price': '₹300',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Pet Bed',
      'price': '₹1200',
      'image': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Products',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.75, // Aspect ratio of each item
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductCard(
            name: product['name'],
            price: product['price'],
            image: product['image'],
          );
        },
      ),
    );
  }

  // Helper to build a product card
  Widget _buildProductCard({
    required String name,
    required String price,
    required String image,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          // Product Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Product Price
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          // Add to Cart Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              // Handle Add to Cart
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
