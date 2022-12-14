import 'package:flutter/material.dart';
import 'package:my_final/pages/view-pdf.dart';
import 'package:my_final/pages/auth/login.dart';
import 'package:my_final/pages/splash.dart';
import 'package:my_final/pages/skema.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          // centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/login': (context) => const MyLogin(),
        '/skema': (context) => const Skema(),
      },
      home: LogoApp(),
    );
  }
}