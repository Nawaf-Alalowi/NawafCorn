import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constance.dart';

class PageStructure extends StatefulWidget {
  Widget child;
  String pageTitle;
  bool appbar;
  bool pageInPage;
  PageStructure(
      {this.child,
      this.pageTitle = '',
      this.appbar = false,
      this.pageInPage = false});

  @override
  _PageStructureState createState() => _PageStructureState();
}

class _PageStructureState extends State<PageStructure> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: widget.appbar == true
                ? AppBar(
                    toolbarHeight: 60.h,
                    leadingWidth: 90.w,
                    backgroundColor: BACKGROOUND_COLOR,
                    elevation: 0,
                    centerTitle: true,
                    leading: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 21, 16, 0),
                      child: Text(
                        widget.pageTitle,
                        style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.white,
                            fontFamily: 'nawar'),
                      ),
                    ),
                    actions: [
                      widget.pageInPage == true
                          ? backIcon(context)
                          : homeIcons(),
                    ],
                  )
                : null,
            backgroundColor: BACKGROOUND_COLOR,
            body: SingleChildScrollView(
                child: SafeArea(
              child: widget.child,
            ))));
  }
}

Widget homeIcons() {
  return Row(
    children: [
      Padding(padding: EdgeInsets.all(12), child: Icon(Icons.search)),
      Padding(padding: EdgeInsets.all(12), child: Icon(Icons.more_horiz))
    ],
  );
}

Widget backIcon(context) {
  return Padding(
      padding: EdgeInsets.all(12),
      child: IconButton(
        icon: Icon(Icons.arrow_forward_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ));
}

class _onItemTapped {}
