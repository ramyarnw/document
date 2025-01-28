import '../../../ui.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_texts.dart';

class PickFileWidget extends StatelessWidget {
  const PickFileWidget({
    super.key,
    required this.pickFile,
  });

  final void Function() pickFile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: FloatingActionButton.extended(
        onPressed: () {
          pickFile();
        },
        label: AppBoldTitle('Pick files'),
        icon: const AppIcon(Icons.description),
      ),
    );
  }
}
