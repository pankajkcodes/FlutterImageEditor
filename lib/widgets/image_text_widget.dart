import 'package:flutter/cupertino.dart';
import 'package:fluttereditorimage/models/text_info_model.dart';

class ImageTextWidget extends StatelessWidget {
  final TextInfoModel textInfoModel;

  const ImageTextWidget({Key? key, required this.textInfoModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfoModel.text,
      textAlign: textInfoModel.textAlign,
      style: TextStyle(
          fontSize: textInfoModel.fontSize,
          fontWeight: textInfoModel.fontWeight,
          fontStyle: textInfoModel.fontStyle,
          color: textInfoModel.color),
    );
  }
}
