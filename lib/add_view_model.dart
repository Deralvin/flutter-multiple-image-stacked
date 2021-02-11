import 'package:image_picker/image_picker.dart';
import 'package:mulltiple_image/base_model.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class AddViewModel extends BaseModel{
  bool uploading = false;
  double val = 0;
  List<File> image = [];
  final picker = ImagePicker();

  void chooseImage() async {
    setBusy(true);
    final pickedFile = await picker.getImage(source: ImageSource.camera);

      image.add(File(pickedFile?.path));
    if (pickedFile.path == null) retrieveLostData();
    setBusy(false);
  }

  Future<void> retrieveLostData() async {
    setBusy(true);
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
        image.add(File(response.file.path));

    } else {
      print(response.file);
    }
    setBusy(false);
  }
}