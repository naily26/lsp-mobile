import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class BlankData extends StatefulWidget {
  const BlankData({super.key});

  @override
  State<BlankData> createState() => _BlankDataState();
}

class _BlankDataState extends State<BlankData> {
  var UserId;
   Future _getAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserId = prefs.getInt('UserId');
   }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}