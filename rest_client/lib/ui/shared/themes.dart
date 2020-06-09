import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_pallete.dart';

final _lightThemeData = ThemeData.light();
final _darkThemeData = ThemeData.dark();

final primaryMaterialTheme = _lightThemeData.copyWith(
  brightness: Brightness.light,
  primaryColor: ColorPalette.primaryBlue,
  accentColor: ColorPalette.primaryGrey,
  typography: Typography.material2018(
      platform: TargetPlatform.android
  ),
  textTheme: _lightThemeData.textTheme.apply(
      fontFamily: 'Avenir',
      bodyColor: Colors.black,
      displayColor: Colors.black
  ),
);
final darkMaterialTheme = _darkThemeData.copyWith(
  brightness: Brightness.dark,
  primaryColor: ColorPalette.primaryBlue,
  accentColor: ColorPalette.primaryGrey,
  typography: Typography.material2018(
      platform: TargetPlatform.android
  ),
  textTheme: _darkThemeData.textTheme.apply(
      fontFamily: 'Avenir',
      bodyColor: Colors.white,
      displayColor: Colors.white
  ),
);