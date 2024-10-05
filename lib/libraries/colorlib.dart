import 'dart:ui';

import 'package:flutter/material.dart';

abstract class ColorLib {
  abstract final String displayName;

  abstract final List<Enum> index;

  List<(Enum, double)> getClosest(Color color, {int amount = 5});
}
