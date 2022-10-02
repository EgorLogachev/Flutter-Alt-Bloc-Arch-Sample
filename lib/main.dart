import 'package:flutter/material.dart';

import 'app_entry.dart';

void main() => runApp(AppEntry());

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}
