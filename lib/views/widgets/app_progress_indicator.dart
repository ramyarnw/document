import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator(
      {super.key, this.alignment, this.color, this.size, required this.width});

  final Alignment? alignment;
  final Color? color;
  final double? size;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: width,
      ),
    );
  }
}
