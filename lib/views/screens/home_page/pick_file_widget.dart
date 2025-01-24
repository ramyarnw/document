import '../../../ui.dart';

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
          label: Text('Pick files'),
          icon: const Icon(Icons.description)),
    );
  }
}
