import 'package:flutter/material.dart';

class LoginTab extends StatelessWidget {
  final String logo;
  final String name;
  const LoginTab({super.key, required this.logo, required this.name});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logo,
              width: 24, // Set the desired logo width
              height: 24,
              fit: BoxFit.contain, // Set the desired logo height
            ),
            const SizedBox(width: 8), // Add space between the logo and text
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
