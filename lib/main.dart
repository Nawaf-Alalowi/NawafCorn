import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/ui/login_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: DevicePreview(
        builder: (context) => MyApp(), // Wrap your app
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(392.72727272727275, 812.7272727272727),
        builder: () => MaterialApp(
              title: 'NawafCorn',
              theme: ThemeData(
                textTheme: TextTheme(
                    //To support the following, you need to use the first initialization method
                    button: TextStyle(fontSize: 45.sp)),
              ),
              home: LoginPage(),
            ));
  }
}
