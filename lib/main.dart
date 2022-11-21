import 'package:flutter/material.dart';
import 'package:perpustakaansekolah/helpers/user_info.dart';
import 'package:perpustakaansekolah/ui/login_page.dart';
import 'package:perpustakaansekolah/ui/buku_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = BukuPage();
      });
    } else {
      setState(() {
        page = LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Sekolah',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}