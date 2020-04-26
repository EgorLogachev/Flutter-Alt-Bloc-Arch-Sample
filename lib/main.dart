import 'package:flutter/material.dart';

import 'app.dart';

/// TODO-list
/// - add dependency injection
/// - create few repositories
/// - add network layer
/// - add APIs

void main() => runApp(SampleApp());

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}
