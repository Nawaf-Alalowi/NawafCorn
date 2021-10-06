import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/api/models/movieModel.dart';
import 'package:movies_app/constance.dart';
import 'package:movies_app/ui/details_page.dart';

class MovieCard extends StatelessWidget {
  MovieModel movie;
  MovieCard({
    @required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailsPage(movie: movie)));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(9.w, 9.h, 25.w, 5.h),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                NETWORK_IMAGES_PATH + movie.posterPath,
                width: 130.w,
                height: 190.h,
              ),
            ),
            SizedBox(height: 3.h),
            Container(
              width: 110.w,
              height: 15.w,
              child: Text(
                movie.title,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(2.w, 2.h, 14.w, 2.h),
              width: 120.w,
              height: 15.h,
              child: Text(
                movie.voteAverage.toString(),
                maxLines: 1,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
