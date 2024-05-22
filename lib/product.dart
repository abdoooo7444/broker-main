import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Images {
  final ImagePicker _picker = ImagePicker();

  Future<File?> getImageUrl() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return File(image.path);
    } catch (e) {
      throw Exception("Error picking image: $e");
    }
  }
}
