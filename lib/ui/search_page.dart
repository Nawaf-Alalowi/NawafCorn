import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movies_app/api/fetch_data.dart';
import 'package:movies_app/api/models/movieModel.dart';
import 'package:movies_app/constance.dart';

import 'package:movies_app/widgets/movie_card.dart';
import 'package:movies_app/widgets/pages_starcture.dart';

class SearchPage extends StatefulWidget {
  bool dataFunction;
  SearchPage({@required this.dataFunction});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return PageStructure(
      appbar: true,
      pageTitle: 'البحث',
      pageInPage: true,
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
        ],
      ),
    );
  }
}
