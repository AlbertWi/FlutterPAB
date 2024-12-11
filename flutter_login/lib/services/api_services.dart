import 'dart:convert';
import 'dart:developer';

import 'package:flutter_login/common/utils.dart';
import 'package:flutter_login/models/movie_model.dart';
import 'package:flutter_login/models/movie_recomendation.dart';
import 'package:flutter_login/models/search_model.dart';
import 'package:flutter_login/models/tv_series_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;

class ApiServices {
  Future<MovieModel> getUpcomingMovies() async {
    endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Succes response :${response.body}");
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load upcoming movies');
  }

  Future<MovieModel> getNowPlayingMovies() async {
    endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Succes response :${response.body}");
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<TvSeriesModel> getTopRatedSeries() async {
    endPoint = 'tv/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Succes response :${response.body}");
      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load top rated tvseries');
  }

  Future<SearchModel> getSearchedMovie(String searchText) async {
    endPoint = 'search/movie?query=$searchText';
    final url = '$baseUrl$endPoint';
    (url);
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNjg2YTYxYjdkZjQ1NmJlYTYxMWU2MTg3ZDZhOTg0NiIsIm5iZiI6MTczMzc2NTY5OS4wOTYsInN1YiI6IjY3NTcyYTQzOTk3ZDk1NjQyMmY0NjczOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YBKcjHezBDsAgZdOl4KoEN5cIz9lXu9s4PiX3icarbc"
    });
    if (response.statusCode == 200) {
      log("Succes response");
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load searched Movies');
  }

  Future<MovieRecommendationsModel> getPopularMovies() async {
    endPoint = 'movie/popular';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Succes response ");
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load popilar Movies');
  }
}
