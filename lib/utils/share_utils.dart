import 'package:share_plus/share_plus.dart';

class ShareUtils {
  Future<void> shareText({
    required String text,
  }) async {
    Share.share(text);
  }

  Future<void> shareFiles(
    String? text, {
    required List<XFile> files,
  }) async {
    Share.shareXFiles(
      files,
      text: text,
    );
  }
}
