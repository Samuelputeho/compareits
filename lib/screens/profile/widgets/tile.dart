import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final IconData leadingIcon;
  final String text;
  final IconData lastIcon;

  const Tile({
    super.key,
    required this.leadingIcon,
    required this.text,
    required this.lastIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey.shade300),
                child: Icon(
                  leadingIcon,
                  size: 24,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 40),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Icon(
            lastIcon,
            size: 24,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
