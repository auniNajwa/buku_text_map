import 'dart:io';

import 'package:bukutextly_users/utils/firestore_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            IconButton(
              onPressed: () async {
                //nak pick image
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                print('${file?.path}');

                if (file == null) return;

                //nama unique
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();

                //upload to firebase storage untuk simpan gamba

                //get a reference storage root
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');

                //create a new reference for the image to be stored
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                //Handle error/success
                try {
                  //Store File/image
                  await referenceImageToUpload.putFile(File(file!.path));

                  //Success : get download url
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (e) {
                  //error : get download url
                }
              },
              icon: const Icon(Icons.camera_alt_rounded),
            ),
            ElevatedButton(
              onPressed: () {
                final String name = nameController.text;
                final String description = descriptionController.text;
                final String condition = conditionController.text;
                final double price = double.parse(priceController.text);

                if (imageUrl.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please upload an image")));

                  return;
                }

                firestoreService
                    .addProduct(
                  name: name,
                  description: description,
                  condition: condition,
                  price: price,
                  category: selectedCategory,
                  imageUrl: imageUrl,
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
    );
  }
}
