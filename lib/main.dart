import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_app/nav.dart';
import 'package:qr_code_app/pages/login.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    // ignore: avoid_print
    print('baglantı oldu');
  } catch (e) {
    // ignore: avoid_print
    print('hata');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
