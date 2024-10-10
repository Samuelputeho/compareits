import 'dart:io'; // For handling file images
import 'package:flutter/material.dart';

class Propic extends StatelessWidget {
  final String? image; // Nullable to handle no image case
  final File? fileImage; // A new field to accept file images

  const Propic({super.key, this.image, this.fileImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: fileImage != null
            ? Image.file(
                fileImage!,
                fit: BoxFit.cover,
              )
            : Image.asset(
                image ??
                    "lib/features/assets/propic.png", // Default image if none is provided
                fit: BoxFit
                    .cover, // Ensures the image fills the circular container
              ),
      ),
    );
  }
}
