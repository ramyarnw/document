import 'package:document_scanner/views/widgets/extensions.dart';

import '../../ui.dart';
import 'app_theme.dart';

extension _MaterialStateUtils on Set<MaterialState> {
  Set<MaterialState> get activeStates => <MaterialState>{
        MaterialState.pressed,
        MaterialState.selected,
      };

  bool get hasActiveStates {
    return intersection(activeStates).isNotEmpty;
  }

  bool get hasHovered => contains(MaterialState.hovered);
}

class AppButtonChild extends StatelessWidget {
  const AppButtonChild(
    this.text, {
    super.key,
    this.prefixIcon,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.suffixIcon,
  });

  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        if (prefixIcon != null) ...<Widget>[
          IconTheme(
            data: IconTheme.of(context).copyWith(size: 18),
            child: prefixIcon!,
          ),
          const SizedBox(width: 8),
        ],
        Text(text),
        if (suffixIcon != null) ...<Widget>[
          const SizedBox(width: 12),
          IconTheme(
            data: IconTheme.of(context).copyWith(size: 18),
            child: suffixIcon!,
          ),
        ],
      ],
    );
  }
}

/// Defines the base of the AppButton
abstract class _AppButton extends StatelessWidget {
  const _AppButton({
    super.key,
    this.onPressed,
    required this.child,
  });

  final AppButtonChild child;
  final VoidCallback? onPressed;

  AppButtonTheme getAppButtonTheme(BuildContext context) {
    return context.appTheme.primaryButtonTheme;
  }

  OutlinedBorder? resolveButtonShape(
      BuildContext context, Set<MaterialState> states) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    );
  }

  Color resolveOverlayColor(BuildContext context, Set<MaterialState> states) {
    return Colors.black12;
  }

  Color resolveBackgroundColor(
    BuildContext context,
    Set<MaterialState> states,
  ) {
    final AppButtonTheme appButtonTheme = getAppButtonTheme(context);
    Color? color;
    if (states.hasActiveStates) {
      color = appButtonTheme.activeColor;
    }
    if (states.hasHovered) {
      color = appButtonTheme.hoverColor;
    }

    color ??= appButtonTheme.defaultColor;
    return color;
  }

  Color resolveForegroundColor(
    BuildContext context,
    Set<MaterialState> states,
  ) {
    final AppButtonTheme appButtonTheme = getAppButtonTheme(context);
    Color? color;
    if (states.hasActiveStates) {
      color = appButtonTheme.activeTextColor;
    }
    if (states.hasHovered) {
      color = appButtonTheme.hoverTextColor;
    }

    color ??= appButtonTheme.defaultTextColor;
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: getButtonStyle(context),
      child: child,
    );
  }

  ButtonStyle getButtonStyle(BuildContext context) {
    return ButtonStyle(
      splashFactory: Theme.of(context).splashFactory,
      animationDuration: Duration.zero,
      shape: MaterialStateProperty.resolveWith(
        (Set<WidgetState> s) => resolveButtonShape(context, s),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 18,
        ),
      ),
      foregroundColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> s) => resolveForegroundColor(context, s)),
      overlayColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> s) => resolveOverlayColor(context, s)),
      backgroundColor: MaterialStateProperty.resolveWith(
        (Set<MaterialState> s) => resolveBackgroundColor(context, s),
      ),
    );
  }
}

class AppButton extends _AppButton {
  const AppButton({
    super.key,
    super.onPressed,
    required super.child,
  });

  @override
  AppButtonTheme getAppButtonTheme(BuildContext context) =>
      context.appTheme.primaryButtonTheme;
}

class AppPrimaryButton extends _AppButton {
  const AppPrimaryButton({
    super.key,
    super.onPressed,
    required super.child,
  });

  @override
  AppButtonTheme getAppButtonTheme(BuildContext context) =>
      context.appTheme.primaryButtonTheme;
}

class AppSecondaryButton extends _AppButton {
  const AppSecondaryButton({
    super.key,
    super.onPressed,
    required super.child,
  });

  @override
  AppButtonTheme getAppButtonTheme(BuildContext context) =>
      context.appTheme.secondaryButtonTheme;
}
