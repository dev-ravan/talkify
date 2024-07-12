import 'package:talkify/utils/exports.dart';

final AppTextStyle _textStyle = AppTextStyle.instance;

ThemeData darkMode = ThemeData(
  fontFamily: "Poppins",
  appBarTheme: AppBarTheme(backgroundColor: Palettes.transparentColor),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Palettes.bgColor,
  primaryColor: Palettes.primaryColor,
  colorScheme: ColorScheme.light(
      primary: Palettes.primaryColor,
      secondary: Palettes.darkMenuColor,
      tertiary: Palettes.blackColor,
      outline: Palettes.outlineColor),
  textTheme: TextTheme(
    displayLarge: _textStyle.displayLarge.copyWith(color: Palettes.bgColor),
    displayMedium: _textStyle.displayMedium.copyWith(color: Palettes.bgColor),
    displaySmall: _textStyle.displaySmall.copyWith(color: Palettes.bgColor),
    headlineLarge: _textStyle.headlineLarge.copyWith(color: Palettes.bgColor),
    headlineMedium: _textStyle.headlineMedium.copyWith(color: Palettes.bgColor),
    headlineSmall: _textStyle.headlineSmall.copyWith(color: Palettes.bgColor),
    titleLarge: _textStyle.titleLarge.copyWith(color: Palettes.bgColor),
    titleSmall: _textStyle.titleSmall.copyWith(color: Palettes.bgColor),
    titleMedium: _textStyle.titleMedium.copyWith(color: Palettes.whiteTxtColor),
    labelLarge: _textStyle.labelLarge.copyWith(color: Palettes.bgColor),
    labelMedium: _textStyle.labelMedium.copyWith(color: Palettes.bgColor),
    labelSmall: _textStyle.labelSmall.copyWith(color: Palettes.bgColor),
    bodyLarge: _textStyle.bodyLarge.copyWith(color: Palettes.bgColor),
    bodyMedium: _textStyle.bodyMedium.copyWith(color: Palettes.bgColor),
    bodySmall: _textStyle.bodySmall.copyWith(color: Palettes.bgColor),
  ),
);
