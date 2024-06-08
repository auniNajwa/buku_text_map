import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String id;
  final String userId;
  final double rating;
  final String comment;
  final DateTime timestamp;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.timestamp,
  });

  // Factory constructor to create a FeedbackModel from Firestore data
  factory FeedbackModel.fromFirestore(Map<String, dynamic> data) {
    return FeedbackModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      rating: data['rating'] as double,
      comment: data['comment'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Method to convert a FeedbackModel to a Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'timestamp':
          Timestamp.fromDate(timestamp), // Convert DateTime to Timestamp
    };
  }
}
