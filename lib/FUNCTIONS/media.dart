import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

// PICK MEDIA
Future<File?> function_PickMedia() async {
  final picker = ImagePicker();
  try {
    // Pick an image or video from gallery
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No file selected.');
      return null;
    }
  } catch (e) {
    print('Error picking media: $e');
    return null; // Handle error gracefully
  }
}

// PICK MULTUPLE MEDIA
Future<List<File>?> function_PickMultipleMedia() async {
  final picker = ImagePicker();
  try {
    // Pick multiple images from the gallery
    final List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      return pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    } else {
      print('No files selected.');
      return null;
    }
  } catch (e) {
    print('Error picking media: $e');
    return null; // Handle error gracefully
  }
}

// CHECK TYPE
String function_CheckType(File file) {
  // Use the mime package to determine the MIME type
  final mimeType = lookupMimeType(file.path);
  if (mimeType != null) {
    return mimeType
        .split('/')
        .first; // Return the primary type (e.g., 'image', 'video', 'application', etc.)
  } else {
    return 'Unknown'; // Handle case where MIME type cannot be determined
  }
}

// TAKE PHOTO
Future<File?> function_TakePhoto() async {
  final ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    print('No image selected.');
    return null;
  }
}
