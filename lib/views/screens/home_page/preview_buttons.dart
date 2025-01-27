import '../../../ui.dart';

class PreviewButtons extends StatelessWidget {
  const PreviewButtons(
      {super.key, required this.onAccept, required this.onReject, required this.isProcessing});

  final void Function() onAccept;
  final void Function() onReject;

  final bool  isProcessing;
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(child: SizedBox.shrink(),),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple
          ),
          onPressed: isProcessing?null:onAccept,
          label: isProcessing?CircularProgressIndicator():
          const Text('Accept'),
          icon: const Icon(Icons.save),
        ),
        SizedBox(
          width: 32,
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple
          ),
          onPressed: onReject,
          label:const Text('Reject'),
          icon: const Icon(Icons.delete_forever),
        ),
        Expanded(child: SizedBox.shrink(),),
      ],
    );
  }
}
