import '../../../ui.dart';
import '../../widgets/app_texts.dart';

class FileViewer extends StatelessWidget {
  const FileViewer({
    super.key,
    this.image,
  });

  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppText('Preview:'),
        if (image != null) Image.memory(image!),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}