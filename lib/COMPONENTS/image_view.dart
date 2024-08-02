import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double radius;

  const ImageView(
      {super.key,
      required this.imagePath,
      this.width = 100.0, // Default width
      this.height = 100.0, // Default height
      this.radius = 0});

  bool isUrl(String path) {
    return Uri.tryParse(path)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius), // Set border radius here
      child: isUrl(imagePath)
          ? Image.network(
              imagePath,
              width: width,
              height: height,
              fit: BoxFit.cover, // Adjust the fit as per your requirement
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Text(
                    'Failed to load image'); // Replace with your error handling widget
              },
            )
          : Image.asset(
              imagePath,
              width: width,
              height: height,
              fit: BoxFit.cover, // Adjust the fit as per your requirement
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Text(
                    'Failed to load image'); // Replace with your error handling widget
              },
            ),
    );
  }
}
