import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;

  const DefaultButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.child,
      required this.color,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(color: textColor),
          ),
        ));
  }
}
