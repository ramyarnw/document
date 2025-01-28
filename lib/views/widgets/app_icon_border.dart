import 'package:document_scanner/utils/extensions.dart';

import '../../ui.dart';
import 'app_icon.dart';

class AppIconBorder extends StatelessWidget {
  const AppIconBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border:
        Border.all(color: context.colors.onPrimaryColor, width: 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: AppIcon(
          icons.file,
          color: context.colors.onPrimaryColor,
          size: 12,
        ),
      ),
    );
  }
}
