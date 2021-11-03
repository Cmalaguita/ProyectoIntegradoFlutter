import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'add_alert': Icons.add_alert,
  'accessibility': Icons.accessibility,
  'folder_open': Icons.folder_open,
  'home_page': Icons.house
};

Icon getIcon(String nombreIcon) {
  return Icon(_icons[nombreIcon]);
}
