import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  static final pageName = 'alert';

  @override
  _alertPageState createState() => _alertPageState();
}

class _alertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alertas'),
      ),
    );
  }
}
