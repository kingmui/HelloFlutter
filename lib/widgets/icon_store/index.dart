import 'package:flutter/material.dart';

class IconStore extends Icon {
  final String fontFamily;
  final int codePoint;
  final double size;
  final Color color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  IconStore({
    Key? key,
    required this.codePoint,
    this.fontFamily = 'iconstore',
    this.size = 20,
    this.color = Colors.black,
    this.semanticLabel,
    this.textDirection,
  }) : super(
          IconData(
            codePoint,
            fontFamily: fontFamily,
            matchTextDirection: true,
          ),
          key: key,
          size: size,
          color: color,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );
}
