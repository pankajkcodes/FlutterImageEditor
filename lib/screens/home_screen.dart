import 'package:flutter/material.dart';
import 'package:fluttereditorimage/screens/edit_image_screen.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.file_upload),
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              // Pick an image
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);

              if (image != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditImageScreen(selectedImage: image.path);
                }));
              }
            },
          ),
        ),
      ),
    );
  }
}
