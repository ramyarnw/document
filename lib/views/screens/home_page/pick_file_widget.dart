import 'package:document_scanner/views/mixin/threadMixin.dart';
import 'package:document_scanner/views/widgets/mixins.dart';

import '../../../ui.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_texts.dart';

class PickFileWidget extends StatefulWidget {
  const PickFileWidget({
    super.key,
    required this.pickFiles,
  });

  final void Function() pickFiles;

  @override
  State<PickFileWidget> createState() => _PickFileWidgetState();
}

class _PickFileWidgetState extends State<PickFileWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: FloatingActionButton.extended(
        onPressed:widget.pickFiles,
        label: AppBoldTitle('Pick files'),
        icon: const AppIcon(Icons.description),
      ),
    );
  }
}
