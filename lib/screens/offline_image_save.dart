import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transactions/boxes.dart';
import 'package:transactions/model/images_model.dart';

class ImagesDemoScreen extends StatefulWidget {
  const ImagesDemoScreen({Key? key}) : super(key: key);

  @override
  State<ImagesDemoScreen> createState() => _ImagesDemoScreenState();
}

class _ImagesDemoScreenState extends State<ImagesDemoScreen> {
  File? displayImage;
  @override
  void dispose() {
    // Hive.close();
    Hive.box('images').close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getImageFromLocal();
  }

  getImageFromLocal() {
    final box = Boxes.getImages();
    var image = box.get('imagePath');
    displayImage = File(image!.path);
  }

  final ImagePicker _picker = ImagePicker();

  saveImage() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    File image = File(photo!.path);
    String imgPathDb = '$appDocPath/filename.jpg';
    await image.copy(imgPathDb);
    savePathToDb(imgPathDb);
    setState(() {
      displayImage = image;
    });
  }

  savePathToDb(String path) {
    final images = Images()..path = path;
    final box = Boxes.getImages();
    box.add(images);
  }

  getImage() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline image demo'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: saveImage, child: const Text('Capture Image')),
            const SizedBox(height: 25),
            displayImage != null ? Image.file(displayImage!) : Container()
          ],
        ),
      ),
    );
  }
}
