import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// Import the image picker package
import 'dart:io';

import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import 'widgets/propic.dart';
import 'widgets/tile.dart'; // For handling the picked file

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image; // Variable to store the picked image

  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image =
            File(pickedImage.path); // Update the state with the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          // GestureDetector allows tapping on the profile picture to change it
          GestureDetector(
            onTap: _pickImage, // Call the image picker function when tapped
            child: Center(
              child: Propic(
                fileImage: _image, // Use the selected image if available
                image: "assets/propic.png", // Default profile picture
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text("Rox"),
          const SizedBox(height: 5),
          const Text(
            "samuelputeho5@gmail.com",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Tile(
            leadingIcon: Icons.person,
            text: 'Privacy',
            lastIcon: Icons.arrow_circle_right_rounded,
          ),
          const SizedBox(height: 10),
          Tile(
            leadingIcon: Icons.question_mark,
            text: 'Help & Support',
            lastIcon: Icons.arrow_circle_right_rounded,
          ),
          const SizedBox(height: 10),
          Tile(
            leadingIcon: Icons.settings,
            text: 'Settings',
            lastIcon: Icons.arrow_circle_right_rounded,
          ),
          Tile(
            leadingIcon: Icons.people,
            text: 'Invite a Friend',
            lastIcon: Icons.arrow_circle_right_rounded,
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              context.read<SignInBloc>().add(
                  const SignOutRequired()); // Add your logout functionality here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
