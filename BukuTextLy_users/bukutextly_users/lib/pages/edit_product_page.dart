import 'package:flutter/material.dart';
import 'package:bukutextly_users/utils/firestore_service.dart';

class EditProductPage extends StatefulWidget {
  final String productId;

  const EditProductPage({
    super.key,
    required this.productId,
  });

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  late Future<Product> _productFuture;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _conditionController;
  late TextEditingController _priceController;
  //late TextEditingController _imageUrlController;
  BookCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _productFuture = _firestoreService.getProductById(widget.productId);
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _conditionController = TextEditingController();
    _priceController = TextEditingController();
    //_imageUrlController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _conditionController.dispose();
    _priceController.dispose();
    //_imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      await _firestoreService.updateProduct(
        productId: widget.productId,
        name: _nameController.text,
        description: _descriptionController.text,
        condition: _conditionController.text,
        price: double.parse(_priceController.text),
        category: _selectedCategory!,
      );
      Navigator.of(context).pop(); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: FutureBuilder<Product>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading product details'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Product not found'));
          } else {
            final product = snapshot.data!;
            _nameController.text = product.name;
            _descriptionController.text = product.description;
            _conditionController.text = product.condition;
            _priceController.text = product.price.toString();
            //_imageUrlController.text = product.imageUrl;
            _selectedCategory = product.category;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the product name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the product description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _conditionController,
                      decoration: const InputDecoration(labelText: 'Condition'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the product condition';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the product price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<BookCategory>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(labelText: 'Category'),
                      items: BookCategory.values.map((BookCategory category) {
                        return DropdownMenuItem<BookCategory>(
                          value: category,
                          child: Text(category.toString().split('.').last),
                        );
                      }).toList(),
                      onChanged: (BookCategory? newValue) {
                        setState(() {
                          _selectedCategory = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: _imageUrlController,
                    //   decoration: const InputDecoration(labelText: 'Image URL'),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter the product image URL';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _updateProduct,
                      child: const Text('Update Product'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
