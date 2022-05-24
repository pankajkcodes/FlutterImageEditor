
import 'package:flutter/cupertino.dart';

class TextInfoModel {
  String text;
  double left;
  double top;
  Color color;
  FontWeight fontWeight;
  FontStyle fontStyle;
  double fontSize;
  TextAlign textAlign;

  TextInfoModel(
      {required this.text,
      required this.left,
      required this.top,
      required this.color,
      required this.fontWeight,
      required this.fontStyle,
      required this.fontSize,
      required this.textAlign});
}
