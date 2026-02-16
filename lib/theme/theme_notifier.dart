import 'package:flutter/material.dart';

// A global ValueNotifier to hold the current ThemeMode
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

// Optional helper to toggle theme
// void toggleTheme() {
//   themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
// }
