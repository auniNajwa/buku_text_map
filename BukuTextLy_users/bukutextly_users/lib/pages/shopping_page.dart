import 'package:bukutextly_users/components/product_card.dart';
import 'package:flutter/material.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          children: [
            Text(
              'Shopping Page',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ProductCard(),
          ],
        ),
      ),
    );
  }
}
