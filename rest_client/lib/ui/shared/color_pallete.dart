import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPalette {
  static final Color primaryBlue = Color(0xFF6473FF);
  static final Color secondaryBlue = Color(0xFFE0E3FF);
  static final Color tertiaryBlue = Color(0xFFF1F9FF);
  static final Color primaryTeal = Color(0xFF00FFFE);
  static final Color primaryBlueOne = Color(0xFF2F3352);
  static final Color primaryGrey = Color(0xFFF7F7F7);
  static final Color secondaryGrey = Color(0xFFC4C4C4);
  static final Color tertiaryGrey = Color(0xFFE0E0E0);
  static final Color Success = Colors.green[300];
  static final Color Warning = Colors.amber[300];
  static final Color primaryError = Color(0xFFFF533C);

  static final ColorShader Blue = ColorShader(
    P50: Color(0xFFF0F6FC),
    P100: Color(0xFFD2E4F8),
    P200: Color(0xFFB5D2F4),
    P300: Color(0xFF97C1F0),
    P400: Color(0xFF7AAFEC),
    P500: Color(0xFF5D9EE8),
    P600: Color(0xFF4D82BE),
    P700: Color(0xFF3C6594),
    P800: Color(0xFF223A55),
    P900: Color(0xFF1A2C40),
  );

  static final ColorShader Green = ColorShader(
    P50: Color(0xFFE8F5E9),
    P100: Color(0xFFC8E6C9),
    P200: Color(0xFFA5D6A7),
    P300: Color(0xFF81C784),
    P400: Color(0xFF66BB6A),
    P500: Color(0xFF4CAF50),
    P600: Color(0xFF43A047),
    P700: Color(0xFF388E3C),
    P800: Color(0xFF2E7D32),
    P900: Color(0xFF1B5E20),
  );

  static final ColorShader Grey = ColorShader(
    P50: Color(0xFFFAFAFA),
    P100: Color(0xFFF5F5F5),
    P200: Color(0xFFEEEEEE),
    P300: Color(0xFFE0E0E0),
    P400: Color(0xFFBDBDBD),
    P500: Color(0xFF9E9E9E),
    P600: Color(0xFF757575),
    P700: Color(0xFF616161),
    P800: Color(0xFF424242),
    P900: Color(0xFF212121),
  );
}

class ColorShader {
  final Color P50;
  final Color P100;
  final Color P200;
  final Color P300;
  final Color P400;
  final Color P500;
  final Color P600;
  final Color P700;
  final Color P800;
  final Color P900;

  ColorShader(
      {this.P50,
        this.P100,
        this.P200,
        this.P300,
        this.P400,
        this.P500,
        this.P600,
        this.P700,
        this.P800,
        this.P900});
}
