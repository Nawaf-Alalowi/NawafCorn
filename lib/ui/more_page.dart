import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movies_app/api/fetch_data.dart';
import 'package:movies_app/api/models/movieModel.dart';
import 'package:movies_app/constance.dart';

import 'package:movies_app/widgets/movie_card.dart';
import 'package:movies_app/widgets/pages_starcture.dart';

class MorePage extends StatefulWidget {
  bool dataFunction;
  MorePage({@required this.dataFunction});

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  int pageNew = 1;
  bool isLoading = false;

  ScrollController _sc = new ScrollController();
  @override
  void initState() {
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        setState(() {
          pageNew++;
        });
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildProgressIndicator() {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Opacity(
            opacity: isLoading ? 1.0 : 00,
            child: new CircularProgressIndicator(),
          ),
        ),
      );
    }

    return PageStructure(
      appbar: true,
      pageTitle: 'المزيد',
      pageInPage: true,
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Container(
              height: 0.85.sh,
              child: FutureBuilder(
                  future: widget.dataFunction == false
                      ? fetchTrendingWeak(pageNew)
                      : fetchTopRated(pageNew + 1),
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
                        return StaggeredGridView.countBuilder(
                          controller: _sc,
                          crossAxisCount: 4,
                          itemCount: movies.length + 1,
                          itemBuilder: (BuildContext context, int i) {
                            if (i == movies.length) {
                              return _buildProgressIndicator();
                            } else {
                              return new Container(
                                height: 140,
                                child: MovieCard(
                                  movie: movies[i],
                                ),
                              );
                            }
                          },
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.count(2, 3),
                          mainAxisSpacing: 0.5,
                          crossAxisSpacing: 0.5,
                        );
                        break;
                    }
                  }))
        ],
      ),
    );
  }
}
