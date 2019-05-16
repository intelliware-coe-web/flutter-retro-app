import 'package:flutter/material.dart';

import 'login_signup_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RetroApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginSignUpPage(),
    );
  }
}
