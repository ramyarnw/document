
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../ui.dart';

class AppMarkdown extends StatelessWidget {
  const AppMarkdown({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data:text,
    );
  }
}
