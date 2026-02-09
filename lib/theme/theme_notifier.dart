import 'package:flutter/material.dart';

/// Global theme notifier. Default = light.
/// Update this from any widget: themeNotifier.value = ThemeMode.dark;
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
