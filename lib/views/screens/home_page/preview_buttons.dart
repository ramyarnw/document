import '../../../ui.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_progress_indicator.dart';
import '../../widgets/app_texts.dart';

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
          label: isProcessing?AppProgressIndicator(size: 12,color: Colors.white, width: 12,):
          const AppText('Accept'),
          icon: const AppIcon(Icons.save),
        ),
        SizedBox(
          width: 32,
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple
          ),
          onPressed: onReject,
          label:const AppText('Reject'),
          icon: const AppIcon(Icons.delete_forever),
        ),
        Expanded(child: SizedBox.shrink(),),
      ],
    );
  }
}
