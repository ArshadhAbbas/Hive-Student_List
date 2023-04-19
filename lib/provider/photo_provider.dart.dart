import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WidgetFunctionProvider extends ChangeNotifier {
  String? photo;
  Future<void> getPhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      photo = image.path;
    }
    notifyListeners();
  }
}
