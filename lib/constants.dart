import 'package:flutter/material.dart';

enum ColorSelection {
  purple('Purple', Colors.purple),
  blue('Blue', Colors.blue),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  red('red', Colors.red);

  const ColorSelection(this.label, this.color);
  final String label;
  final Color color;
}
