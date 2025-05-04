import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductUploadScreen extends StatefulWidget {
  const ProductUploadScreen({Key? key}) : super(key: key);

  @override
  State<ProductUploadScreen> createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String image = '';
  String description = '';
  String category = '';
  int price = 0;
  int stock = 0;

  Future<void> submitProduct() async {
    final url = Uri.parse('http://10.0.2.2:5000/api/products'); // Use 10.0.2.2 for Android emulator

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": name,
        "image": image,
        "description": description,
        "price": price,
        "category": category,
        "stock": stock,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Product Added Successfully')),
      );
    } else {
      print('Error: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed to Add Product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField('Name', (val) => name = val),
              buildTextField('Image URL', (val) => image = val),
              buildTextField('Description', (val) => description = val),
              buildTextField('Category', (val) => category = val),
              buildTextField('Price', (val) => price = int.parse(val)),
              buildTextField('Stock', (val) => stock = int.parse(val)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitProduct();
                  }
                },
                child: const Text('Add Product'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Enter $label' : null,
        onChanged: onChanged,
      ),
    );
  }
}
