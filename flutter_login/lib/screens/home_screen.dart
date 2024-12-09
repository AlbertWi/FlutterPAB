import 'package:flutter/material.dart';
import 'package:flutter_login/common/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgoundColor,
        title :Image.asset(
          "assets/logo.png",
          height: 50,
          width: 120,
        ),
        actions: [
          InkWell(child: Icon(Icons.search,color: Colors.white,))
        ],
      ),
      body: Center(
        child: Text("Hi Im Home Screen"),
      ),
    );
  }
}