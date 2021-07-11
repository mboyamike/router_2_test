import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: const Text(
            'Looks like that page does not exist 🥲',
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
