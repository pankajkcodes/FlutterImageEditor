import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttereditorimage/screens/edit_image_viewmodel.dart';
import 'package:fluttereditorimage/widgets/image_text_widget.dart';
import 'package:screenshot/screenshot.dart';

class EditImageScreen extends StatefulWidget {
  final String selectedImage;

  const EditImageScreen({Key? key, required this.selectedImage})
      : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: _appBar,
        ),
        body: Screenshot(
          controller: screenshotController,
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Stack(
                children: [
                  _selectedImage,
                  for (int i = 0; i < textList.length; i++)
                    Positioned(
                      left: textList[i].left,
                      top: textList[i].top,
                      child: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            currentIndex = i;
                            removeText(context);
                          });
                        },
                        onTap: () {
                          setCurrentIndex(context, i);
                        },
                        child: Draggable(
                          feedback: ImageTextWidget(textInfoModel: textList[i]),
                          child: ImageTextWidget(textInfoModel: textList[i]),
                          onDragEnd: (drag) {
                            final renderBox =
                                context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);
                            setState(() {
                              textList[i].top = off.dy;
                              textList[i].left = off.dx;
                            });
                          },
                        ),
                      ),
                    ),
                  creatorText.text.isNotEmpty
                      ? Positioned(
                          left: 0,
                          bottom: 0,
                          child: Text(
                            creatorText.text,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.3)),
                          ))
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: _addNewFloatingButton);
  }

  Widget get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                onPressed: () {
                  saveImageToGalley(context);
                },
                icon: const Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                tooltip: "Save Image",
              ),
              IconButton(
                onPressed: () {
                  increaseFontSize();
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                tooltip: "Increase Font Size",
              ),
              IconButton(
                onPressed: () {
                  decreaseFontSize();
                },
                icon: const Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                tooltip: "Decrease Font Size",
              ),
              IconButton(
                onPressed: () {
                  alignLeft();
                },
                icon: const Icon(
                  Icons.format_align_left,
                  color: Colors.black,
                ),
                tooltip: "Align Left",
              ),
              IconButton(
                onPressed: () {
                  alignCenter();
                },
                icon: const Icon(
                  Icons.format_align_center,
                  color: Colors.black,
                ),
                tooltip: "Align Center",
              ),
              IconButton(
                onPressed: () {
                  alignRight();
                },
                icon: const Icon(
                  Icons.format_align_right,
                  color: Colors.black,
                ),
                tooltip: "Align Right",
              ),
              IconButton(
                onPressed: () {
                  textBold();
                },
                icon: const Icon(
                  Icons.format_bold,
                  color: Colors.black,
                ),
                tooltip: "Bold",
              ),
              IconButton(
                onPressed: () {
                  textItalic();
                },
                icon: const Icon(
                  Icons.format_italic,
                  color: Colors.black,
                ),
                tooltip: "Italic",
              ),
              IconButton(
                onPressed: () {
                  addNewLinesToText();
                },
                icon: const Icon(
                  Icons.space_bar,
                  color: Colors.black,
                ),
                tooltip: "Add New Line",
              ),
              Tooltip(
                message: "red",
                child: GestureDetector(
                  onTap: () {
                    changeTextColor(Colors.red);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "white",
                child: GestureDetector(
                  onTap: () {
                    changeTextColor(Colors.white);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "black",
                child: GestureDetector(
                  onTap: () {
                    changeTextColor(Colors.black);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "blue",
                child: GestureDetector(
                  onTap: () {
                    changeTextColor(Colors.blue);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "green",
                child: GestureDetector(
                  onTap: () {
                    changeTextColor(Colors.green);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "yellow",
                child: GestureDetector(
                  onTap: () {
                    changeTextColor(Colors.yellow);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "orange",
                child: GestureDetector(
                  onTap: () {
                    changeTextColor(Colors.orange);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "pink",
                child: GestureDetector(
                  onTap: () {
                    changeTextColor(Colors.pink);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      );

  Widget get _selectedImage => Center(
        child: Image.file(File(widget.selectedImage),
            fit: BoxFit.fill, width: MediaQuery.of(context).size.width),
      );

  Widget get _addNewFloatingButton => FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: "Add New Text",
        onPressed: () {
          addNewDialog(context);
        },
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );
}
