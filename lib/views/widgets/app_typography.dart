import '../../ui.dart';
import '../../utils/app_constants.dart';

class AppTypography {
  AppTypography(this.appColors);

  final AppColors appColors;
  static const String _fontFamily = 'OpenSans';

  TextStyle? get appHeader => TextStyle(
        fontSize: 22,
        color: appColors.white,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w500,
        height: 1.2, //16px
      );

  TextStyle? get appBoldHeader => TextStyle(
        fontSize: 22,
        color: appColors.white,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w800,
        height: 1.2, //16px
      );

  TextStyle? get appTitle => TextStyle(
        fontSize: 18,
        color: appColors.white,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w500,
      );

  TextStyle? get appBoldTitle => TextStyle(
        fontSize: 18,
        color: appColors.white,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get appSubTitle => TextStyle(
        fontSize: 14,
        color: appColors.white,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        height: 1, //16px
      );

  TextStyle? get appBodyBoldLarge => TextStyle(
        fontSize: 16,
        color: appColors.white,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
        height: 1.7, //24px
      );
  TextStyle? get appBody => TextStyle(
        fontSize: 12,
        color: appColors.white,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        height: 1.7, //24px
      );

  TextStyle? get appBodyBold => TextStyle(
        fontSize: 12,
        color: appColors.white,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
        height: 1.7, //24px
      );
}
