// lib/utils/feedback_model.dart

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

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'userId': userId,
  //     'rating': rating,
  //     'comment': comment,
  //     'timestamp': timestamp.toIso8601String(),
  //   };
  // }

  // static FeedbackModel fromMap(Map<String, dynamic> map) {
  //   return FeedbackModel(
  //     id: map['id'] as String,
  //     userId: map['userId'] as String,
  //     rating: map['rating'] as double,
  //     comment: map['comment'] as String,
  //     timestamp: DateTime.parse(map['timestamp'] as String),
  //   );
  // }

  factory FeedbackModel.fromFirestore(Map<String, dynamic> data) {
    return FeedbackModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      rating: data['rating'] as double,
      comment: data['comment'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
