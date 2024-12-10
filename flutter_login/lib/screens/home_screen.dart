import 'package:flutter/material.dart';
import 'package:flutter_login/models/movie_model.dart';
import 'package:flutter_login/models/tv_series_model.dart';
import 'package:flutter_login/services/api_services.dart';
import 'package:flutter_login/widgets/custom_carousel.dart';
import 'package:flutter_login/widgets/movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<MovieModel> upcomingFuture;
  late Future<MovieModel> nowPlayingFuture;
  late Future<TvSeriesModel> topRatedSeries;
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    upcomingFuture = apiServices.getUpcomingMovies();
    nowPlayingFuture = apiServices.getNowPlayingMovies();
    topRatedSeries = apiServices.getTopRatedSeries();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset(
            "assets/logo.png",
            height: 50,
            width: 120,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.notifications,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.blue,
                height: 27,
                width: 25,
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: topRatedSeries,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CustomCarouselSlider(data: snapshot.data!);
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
              SizedBox(
                height: 220,
                child: MovieCardWidget(
                    future: upcomingFuture, headLineText: "Upcoming Movies"),
              ),
              SizedBox(
                height: 220,
                child: MovieCardWidget(
                    future: nowPlayingFuture,
                    headLineText: "Now Playing Movies"),
              ),
            ],
          ),
        ));
  }
}
