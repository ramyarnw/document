import '../../../ui.dart';

class PreviewButtons extends StatelessWidget {
  const PreviewButtons(
      {super.key, required this.onAccept, required this.onReject});

  final void Function() onAccept;
  final void Function() onReject;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox.shrink(),),
        ElevatedButton.icon(
          onPressed: onAccept,
          label: const Text('Accept'),
          icon: const Icon(Icons.save),
        ),
        SizedBox(
          width: 32,
        ),
        ElevatedButton.icon(
          onPressed: onReject,
          label: const Text('Reject'),
          icon: const Icon(Icons.delete_forever),
        ),
        Expanded(child: SizedBox.shrink(),),
      ],
    );
  }
}
