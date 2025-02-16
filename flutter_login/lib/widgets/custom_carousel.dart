import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/common/utils.dart';
import 'package:flutter_login/models/tv_series_model.dart';

class CustomCarouselSlider extends StatelessWidget {
  final TvSeriesModel data;
  const CustomCarouselSlider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.20 < 200) ? 350 : size.height * 0.20,
      child: CarouselSlider.builder(
          itemCount: data.results.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            var url = data.results[index].backdropPath.toString();
            return GestureDetector(
                child: Column(
              children: [
                CachedNetworkImage(imageUrl: "$imageUrl$url"),
                const SizedBox(
                  height: 16,
                ),
                Text(data.results[index].name)
              ],
            ));
          },
          options: CarouselOptions(
              height: (size.height * 0.33 < 400) ? 400 : size.height * 0.33,
              aspectRatio: 22 / 9,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal)),
    );
  }
}
