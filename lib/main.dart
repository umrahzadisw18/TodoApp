import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/screens/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
   const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      home: Home(),
    );
  }
}
