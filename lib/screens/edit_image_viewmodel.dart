import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttereditorimage/models/text_info_model.dart';
import 'package:fluttereditorimage/screens/edit_image_screen.dart';
import 'package:fluttereditorimage/utils/utils.dart';
import 'package:fluttereditorimage/widgets/button_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

abstract class EditImageViewModel extends State<EditImageScreen> {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  List<TextInfoModel> textList = [];
  int currentIndex = 0;

  saveImageToGalley(BuildContext context) {
    if (textList.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Saved!"),
        ));
      });
    }
  }

  saveImage(Uint8List bytes) async {
    final timestamp = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");
    final name = "image_editor_$timestamp";
    requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes,name: name);
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex == index;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Selected For Styling"),
    ));
  }

  changeTextColor(Color color) {
    setState(() {
      textList[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      textList[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      textList[currentIndex].fontSize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      textList[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignCenter() {
    setState(() {
      textList[currentIndex].textAlign = TextAlign.center;
    });
  }

  alignRight() {
    setState(() {
      textList[currentIndex].textAlign = TextAlign.right;
    });
  }

  textBold() {
    setState(() {
      if (textList[currentIndex].fontWeight == FontWeight.bold) {
        textList[currentIndex].fontWeight = FontWeight.normal;
      } else {
        textList[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  textItalic() {
    setState(() {
      if (textList[currentIndex].fontStyle == FontStyle.italic) {
        textList[currentIndex].fontStyle = FontStyle.normal;
      } else {
        textList[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addNewLinesToText() {
    setState(() {
      if (textList[currentIndex].text.contains("\n")) {
        textList[currentIndex].text =
            textList[currentIndex].text.replaceAll("\n", " ");
      } else {
        textList[currentIndex].text =
            textList[currentIndex].text.replaceAll(" ", "\n");
      }
    });
  }

  removeText(BuildContext context) {
    setState(() {
      textList.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Deleted"),
    ));
  }

  addNewText(BuildContext context) {
    setState(() {
      textList.add(TextInfoModel(
          text: textEditingController.text,
          left: 0,
          top: 0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          textAlign: TextAlign.left));

      Navigator.pop(context);
    });
  }

  addNewDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Add New Text "),
              content: TextField(
                controller: textEditingController,
                maxLines: 2,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    filled: true,
                    hintText: "Your Text Will Appear "),
              ),
              actions: [
                DefaultButtonWidget(
                    onPressed: Navigator.of(context).pop,
                    child: const Text("Back"),
                    color: Colors.deepOrange,
                    textColor: Colors.green),
                DefaultButtonWidget(
                    onPressed: () {
                      addNewText(context);
                    },
                    child: const Text("Add"),
                    color: Colors.red,
                    textColor: Colors.black),
              ],
            ));
  }
}
