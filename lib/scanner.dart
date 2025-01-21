import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Scanner extends StatelessWidget {
  const Scanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(onPressed: () {}, child: Text('Choose file')),
        ElevatedButton(onPressed: () {}, child: Text('Cancel')),
      ],
    );
  }
}
