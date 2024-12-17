import 'package:flutter/material.dart';
import 'package:flutter_login/common/utils.dart';
import 'package:flutter_login/models/movie_detail.dart';
import 'package:flutter_login/models/movie_recomendation.dart';
import 'package:flutter_login/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool _isFavorite = false;
  late MovieDetailModel? movieData;
  late Future<MovieDetailModel> movieDetail;
  ApiServices apiServices = ApiServices();
  late Future<MovieDetailModel> movieDetaill;
  late Future<MovieRecommendationsModel> movieRecommendationModel;

  @override
  void initState() {
    super.initState();
    _fetchMovieDetail();
  }

  Future<void> _fetchMovieDetail() async {
    movieDetail = apiServices.getMovieDetail(widget.movieId);
    movieDetail.then((data) {
      setState(() {
        movieData = data;
        _checkFavoriteStatus();
      });
    });
  }

  Future<void> _checkFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteMovies = prefs.getStringList('favoriteMovies') ?? [];
    setState(() {
      _isFavorite = favoriteMovies.any((movie) {
        final jsonData = jsonDecode(movie);
        return jsonData['id'] == movieData!.id;
      });
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteMovies = prefs.getStringList('favoriteMovies') ?? [];

    setState(() {
      if (_isFavorite) {
        favoriteMovies.removeWhere((movie) {
          final jsonData = jsonDecode(movie);
          return jsonData['id'] == movieData!.id;
        });
        _isFavorite = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${movieData!.title} removed from bookmark')),
        );
      } else {
        favoriteMovies.add(jsonEncode(movieData!.toJson()));
        _isFavorite = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${movieData!.title} added to bookmark')),
        );
      }
    });

    await prefs.setStringList('favoriteMovies', favoriteMovies);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<MovieDetailModel>(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            } else if (snapshot.hasData) {
              final movie = snapshot.data!;

              String genresText =
                  movie.genres.map((genre) => genre.name).join(', ');

              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("$imageUrl${movie.posterPath}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: _toggleFavorite,
                              icon: Icon(
                                _isFavorite
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                              ),
                              color: _isFavorite ? Colors.grey : null,
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Text(
                              genresText,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          movie.overview,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }
}
