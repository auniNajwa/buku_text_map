import 'package:bukutextly_admins/components/my_button.dart';
import 'package:bukutextly_admins/utils/feedback_model.dart';
import 'package:bukutextly_admins/utils/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Page',
      theme: ThemeData(primaryColor: const Color(0xFF885A3A)
          //primarySwatch: Colors.blue,
          ),
      home: const FeedbackPage(),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 3.0;
  String _comment = '';

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final feedback = FeedbackModel(
        id: const Uuid().v4(),
        userId: FirebaseAuth.instance.currentUser!.uid,
        rating: _rating,
        comment: _comment,
        timestamp: DateTime.now(),
      );
      FirestoreService().addFeedback(feedback);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback Submitted!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Page'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'C:\Users\budak\OneDrive\Desktop\PROJECTMAP\buku_text_map\BukuTextLy_admins\bukutextly_admins\assets\images\Feedback-cuate.png', // Replace with your image URL or asset
                      width: 350,
                      height: 350,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Please Rate Me',
                    style: TextStyle(fontSize: 16),
                  ),
                  StarRating(
                    rating: _rating,
                    onRatingChanged: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Your Comment',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    maxLines: isMobile ? 3 : 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your comment here',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your comment';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _comment = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: MyButton(
                      onTap: _submitFeedback,
                      textInButton: "Submit",
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final void Function(double) onRatingChanged;

  const StarRating({
    super.key,
    this.starCount = 5,
    this.rating = 0,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(starCount, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 40.0, // Set the size of the star icon
          ),
          onPressed: () {
            onRatingChanged(index + 1.0);
          },
        );
      }),
    );
  }
}
