import 'package:talkify/utils/exports.dart';

final AppTextStyle _textStyle = AppTextStyle.instance;

ThemeData lightMode = ThemeData(
  fontFamily: "Poppins",
  appBarTheme: AppBarTheme(backgroundColor: Palettes.transparentColor),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Palettes.bgColor,
  primaryColor: Palettes.primaryColor,
  colorScheme: ColorScheme.light(
      primary: Palettes.primaryColor,
      secondary: Palettes.secondaryColor,
      tertiary: Palettes.blackColor,
      primaryContainer: Palettes.greyTxtColor,
      outline: Palettes.outlineColor),
  textTheme: TextTheme(
    displayLarge: _textStyle.displayLarge,
    displayMedium: _textStyle.displayMedium,
    displaySmall: _textStyle.displaySmall,
    headlineLarge: _textStyle.headlineLarge,
    headlineMedium: _textStyle.headlineMedium,
    headlineSmall: _textStyle.headlineSmall,
    titleLarge: _textStyle.titleLarge,
    titleSmall: _textStyle.titleSmall,
    titleMedium: _textStyle.titleMedium,
    labelLarge: _textStyle.labelLarge,
    labelMedium: _textStyle.labelMedium,
    labelSmall: _textStyle.labelSmall,
    bodyLarge: _textStyle.bodyLarge,
    bodyMedium: _textStyle.bodyMedium,
    bodySmall: _textStyle.bodySmall,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.zero,
    focusedErrorBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    border: InputBorder.none,
  ),
);
