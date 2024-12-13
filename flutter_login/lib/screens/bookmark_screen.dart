import 'package:flutter/material.dart';
import 'package:flutter_login/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<BookmarkScreen> {
  List<HomeScreen> _favoriteHomes = [];

  Future<void> _loadFavoriteHomes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteHomesNames =
        prefs.getStringList('favoriteHomes') ?? [];

    setState(() {
      _favoriteHomes = _favoriteHomes
          .where((HomeScreen) => favoriteHomesNames.contains(HomeScreen.key))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hi Im Download Screen"),
      ),
    );
  }
}
