import 'package:flutter/material.dart';

class MyBlank extends StatefulWidget {
  const MyBlank({super.key});

  @override
  State<MyBlank> createState() => _MyBlankState();
}

class _MyBlankState extends State<MyBlank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('sk'),),
      body: Container(),
    );
  }
}