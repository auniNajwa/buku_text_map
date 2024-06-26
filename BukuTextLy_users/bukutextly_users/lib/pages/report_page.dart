import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  final String userUsername;
  final String date;
  final int totalListings;

  const ReportsPage({
    super.key,
    required this.userUsername,
    required this.date,
    required this.totalListings,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Report Details',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(thickness: 2),
                const SizedBox(height: 16),
                _buildInfoRow('User Username:', userUsername),
                const Divider(thickness: 1),
                const SizedBox(height: 8),
                _buildInfoRow('Date:', date),
                const Divider(thickness: 1),
                const SizedBox(height: 8),
                _buildInfoRow('Total Sales:', "RM$totalListings"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
