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
    if (image != null) {
      return Image.memory(
        image!,
      );
    }
    return Container();
  }
}
