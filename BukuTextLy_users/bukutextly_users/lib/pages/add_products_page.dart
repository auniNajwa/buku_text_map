import 'package:bukutextly_users/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:bukutextly_users/helper/firestore_services.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  BookCategory selectedCategory = BookCategory.computerscience; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // MyTextfield(
              //   controller: nameController,
              //   hintText: 'Name',
              //   obscureText: false,
              // ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: conditionController,
                decoration: const InputDecoration(labelText: 'Condition'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              DropdownButton<BookCategory>(
                value: selectedCategory,
                onChanged: (BookCategory? newValue) {
                  setState(() {
                    if (newValue != null) {
                      selectedCategory = newValue;
                    }
                  });
                },
                items: BookCategory.values.map((BookCategory category) {
                  return DropdownMenuItem<BookCategory>(
                    value: category,
                    child: Text(category.toString().split('.').last),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  final String name = nameController.text;
                  final String description = descriptionController.text;
                  final String condition = conditionController.text;
                  final double price = double.parse(priceController.text);

                  firestoreService
                      .addProduct(
                    name: name,
                    description: description,
                    condition: condition,
                    price: price,
                    category: selectedCategory,
                  )
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Product added successfully!')),
                    );
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add product: $error')),
                    );
                  });
                },
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
