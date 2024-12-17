import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Map<String, dynamic>> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedMovies = prefs.getStringList('favoriteMovies') ?? [];

    setState(() {
      favoriteMovies = savedMovies
          .map((movie) => jsonDecode(movie) as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _removeFavorite(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteMovies.removeAt(index);
    });

    List<String> updatedFavorites =
        favoriteMovies.map((movie) => jsonEncode(movie)).toList();
    await prefs.setStringList('favoriteMovies', updatedFavorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarks")),
      body: favoriteMovies.isEmpty
          ? const Center(child: Text("No bookmarks yet"))
          : ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return ListTile(
                  leading: Image.network(
                    "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
                    width: 50,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie['title'] ?? 'No Title'),
                );
              },
            ),
    );
  }
}
