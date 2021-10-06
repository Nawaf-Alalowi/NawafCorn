import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:movies_app/api/fetch_data.dart';
import 'package:movies_app/api/models/actor_model.dart';
import 'package:movies_app/api/models/movieModel.dart';
import 'package:movies_app/constance.dart';
import 'package:movies_app/ui/home_page.dart';
import 'package:movies_app/widgets/movie_card.dart';
import 'package:movies_app/widgets/pages_starcture.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  MovieModel movie;
  DetailsPage({this.movie});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: BACKGROOUND_COLOR,
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 7.h,
                  ),
                  Container(
                    height: 0.66.sh,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: BACKGROOUND_COLOR,
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            BACKGROOUND_COLOR.withOpacity(0.88),
                            BlendMode.darken),
                        image: NetworkImage(
                            NETWORK_IMAGES_PATH + widget.movie.backdropPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildArrowBack(),
                          Image.network(
                            NETWORK_IMAGES_PATH + widget.movie.posterPath,
                            width: 180.w,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "${widget.movie.originalTitle} (${widget.movie.releaseDate.substring(0, 4)})",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontFamily: 'nawar'),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                                  child: Text(
                                    widget.movie.originalLanguage == 'en'
                                        ? '🇬🇧'
                                        : widget.movie.originalLanguage,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontFamily: 'nawar'),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                                  child: Container(
                                    color: Colors.white,
                                    width: 1.w,
                                    height: 24.h,
                                  ),
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                                    child: Center(
                                      child: RatingBar(
                                        rating: (widget.movie.voteAverage / 2),
                                        icon: Icon(
                                          Icons.star,
                                          size: 15.sp,
                                          color: Colors.grey,
                                        ),
                                        starCount: 5,
                                        spacing: 1.0,
                                        size: 12.sp,
                                        isIndicator: true,
                                        allowHalfRating: true,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                                  child: Container(
                                    color: Colors.white,
                                    width: 1.w,
                                    height: 24.h,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                                  child: Text(
                                    widget.movie.mediaType != null
                                        ? widget.movie.mediaType
                                        : 'movie',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontFamily: 'nawar'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 5.h),
                    child: Text(
                      'نبذة',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontFamily: 'nawar'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.w, 5.h, 18.w, 10.h),
                    child: Text(
                      widget.movie.overview,
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        height: 1.3,
                        color: Colors.grey,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 5.h),
                    child: Text(
                      'افلام مشابهة',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontFamily: 'nawar'),
                    ),
                  ),
                  Container(
                      height: 260.h,
                      child: FutureBuilder(
                          future: fetchSimilarMovies(widget.movie.id),
                          builder: (context, snapshot) {
                            var data = snapshot.data;
                            List<MovieModel> movies = data;

                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: PRIMARY_COLOR,
                                  ),
                                );
                                break;
                              case ConnectionState.active:
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: PRIMARY_COLOR,
                                  ),
                                );
                                break;

                              case ConnectionState.none:
                                return Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Icon(Icons.error_outline,
                                              color: Colors.red),
                                          Text(
                                            'خطاء في الاتصال',
                                            style: TextStyle(fontSize: 22.sp),
                                          )
                                        ],
                                      )),
                                );
                                break;

                              case ConnectionState.done:
                                return ListView.builder(
                                    itemCount: movies.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return MovieCard(movie: movies[i]);
                                    });
                            }
                          })),
                ],
              )),
            )));
  }

  Padding buildArrowBack() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
