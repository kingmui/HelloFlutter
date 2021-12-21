import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData = themeData(
    lightColorScheme,
    _lightFocusColor,
  );
  static ThemeData darkThemeData = themeData(
    darkColorScheme,
    _darkFocusColor,
  );

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(
          color: colorScheme.primary,
        ),
      ),
      iconTheme: IconThemeData(
        color: colorScheme.onPrimary,
      ),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      // textSelectionHandleColor: colorScheme.onPrimary,
      // cursorColor: colorScheme.onPrimary,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1?.apply(
          color: _darkFillColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onPrimary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onPrimary.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onPrimary,
          ),
        ),
        labelStyle: TextStyle(
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }

  // https://material.io/design/color/the-color-system.html

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0XFFEE6002),
    primaryVariant: Color(0XFFE54304),
    secondary: Color(0XFF2196F3),
    secondaryVariant: Color(0XFF1E88E5),
    surface: Color(0xFFFAFBFB),
    background: Color(0xFFE6EBEB),
    error: Color(0xFFFF3D00),
    onPrimary: Colors.white,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    onBackground: Colors.white,
    onError: _lightFillColor,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryVariant: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryVariant: Color(0xFF451B6F),
    surface: Color(0xFF1F1929),
    background: Color(0xFF241E30),
    error: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    onBackground: Color(0x0DFFFFFF), // White with 0.05 opacity
    onError: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headline4: GoogleFonts.montserrat(
      fontWeight: _bold,
      fontSize: 20.0,

      /// 应用在TextField -> style
      /// 解决中文placeholder光标对齐问题
      textBaseline: TextBaseline.alphabetic,
    ),
    caption: GoogleFonts.oswald(
      fontWeight: _semiBold,
      fontSize: 16.0,
    ),
    headline5: GoogleFonts.oswald(
      fontWeight: _medium,
      fontSize: 16.0,
    ),
    subtitle1: GoogleFonts.montserrat(
      fontWeight: _medium,
      fontSize: 16.0,
    ),
    overline: GoogleFonts.montserrat(
      fontWeight: _medium,
      fontSize: 12.0,
    ),
    bodyText1: GoogleFonts.montserrat(
      fontWeight: _regular,
      fontSize: 14.0,
    ),
    subtitle2: GoogleFonts.montserrat(
      fontWeight: _medium,
      fontSize: 14.0,
    ),
    bodyText2: GoogleFonts.montserrat(
      fontWeight: _regular,
      fontSize: 16.0,
    ),
    headline6: GoogleFonts.montserrat(
      fontWeight: _bold,
      fontSize: 16.0,
    ),
    button: GoogleFonts.montserrat(
      fontWeight: _semiBold,
      fontSize: 14.0,
    ),
  );
}
