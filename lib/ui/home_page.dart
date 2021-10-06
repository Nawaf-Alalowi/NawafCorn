import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:movies_app/api/fetch_data.dart';
import 'package:movies_app/api/models/actor_model.dart';
import 'package:movies_app/api/models/movieModel.dart';
import 'package:movies_app/constance.dart';
import 'package:movies_app/ui/details_page.dart';
import 'package:movies_app/ui/more_page.dart';
import 'package:movies_app/widgets/movie_card.dart';
import 'package:movies_app/widgets/pages_starcture.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys('a78a8bf243fae3d26b50151c98fd6a43', 'apiReadAccessTokenv4'),
    logConfig: ConfigLogger(
      showLogs: true, //must be true than only all other logs will be shown
      showErrorLogs: true,
    ),
  );
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageStructure(
      appbar: true,
      pageTitle: 'اقتراحات',
      child: Padding(
          padding: EdgeInsets.fromLTRB(0, 18.h, 0, 19.h),
          child: Column(
            children: [
              Container(
                child: FutureBuilder(
                  future: fetchTrendingDay(),
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
                                  Icon(Icons.error_outline, color: Colors.red),
                                  Text(
                                    'خطاء في الاتصال',
                                    style: TextStyle(fontSize: 22.sp),
                                  )
                                ],
                              )),
                        );
                        break;

                      case ConnectionState.done:
                        return Directionality(
                          textDirection: TextDirection.ltr,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 240.h,
                              width: 0.90.sw,
                              child: Swiper(
                                itemWidth: 0.90.sw,
                                itemHeight: 240,
                                autoplay: true,
                                autoplayDelay: 13000,
                                itemBuilder: (BuildContext context, int i) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                  movie: movies[i])));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6.r),
                                      child: Image.network(
                                        NETWORK_IMAGES_PATH +
                                            movies[i].backdropPath,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 6,
                                indicatorLayout: PageIndicatorLayout.COLOR,
                                pagination: SwiperPagination(
                                    builder: SwiperPagination.dots),
                                layout: SwiperLayout.STACK,
                              ),
                            ),
                          ),
                        );
                        break;
                    }
                  },
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                child: buildTabAndTitle('ترند الاسبوع'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MorePage(
                                dataFunction: false,
                              )));
                },
              ),
              Container(
                  height: 260.h,
                  child: FutureBuilder(
                      future: fetchTrendingWeak(),
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
              InkWell(
                child: buildTabAndTitle('اعلى الافلام تقيم'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MorePage(
                                dataFunction: true,
                              )));
                },
              ),
              Container(
                  height: 260.h,
                  child: FutureBuilder(
                      future: fetchTopRated(),
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
              buildTabAndTitle('اشهر الممثلين'),
              Container(
                  height: 240.h,
                  child: FutureBuilder(
                      future: fetchPopularPersons(),
                      builder: (context, snapshot) {
                        var data = snapshot.data;
                        List<ActorModel> actors = data;

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
                                itemCount: actors.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 120.w,
                                          height: 190.h,
                                          child: Image.network(
                                            NETWORK_IMAGES_PATH +
                                                actors[i].profilePath,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            actors[i].name,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                        }
                      })),
              SizedBox(
                height: 30.h,
              ),
              Text('برمج بود من قبل نواف محمد 👌',
                  style: TextStyle(color: Colors.white, fontFamily: 'nawar')),
            ],
          )),
    );
  }

  Widget buildTabAndTitle(title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.all(18),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 15.sp,
                  fontFamily: 'nawar'),
            )),
        Container(
          padding: EdgeInsets.all(18),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
            size: 19.sp,
          ),
        ),
      ],
    );
  }
}
