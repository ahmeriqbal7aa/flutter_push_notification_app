import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  final id;
  DemoScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(id),
      ),
    );
  }
}
