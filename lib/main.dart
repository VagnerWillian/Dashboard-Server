import 'package:flutter/material.dart';
import 'package:servidordashboard/screens/login_screen/splash.login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Painel do Servidor',
      home: SplashLoginScreen(),
    );
  }
}
