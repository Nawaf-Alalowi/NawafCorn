import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constance.dart';
import 'package:movies_app/ui/home_page.dart';
import 'package:movies_app/widgets/pages_starcture.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    print(ScreenUtil().screenWidth);
    print(ScreenUtil().screenHeight);
    return PageStructure(
      appbar: false,
      child: Container(
        padding: EdgeInsets.all(29),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 18.h, 0, 19.h),
              child: Image.asset(
                IMAGES_PATH + 'logo.png',
                width: 90.w,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 12.h),
                    child: Text(
                      'نورتنا ياقميل,',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontFamily: 'nawar'),
                    ),
                  ),
                  Text(
                    ' شرايك تسجل دخولك وتكمل استمتاع؟ صدقني فكرة .',
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13.sp,
                        letterSpacing: 1.8,
                        fontFamily: 'nawar'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(
                        labelText: 'البريد الالكتروني',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontFamily: 'nawar'),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.7), width: 3)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.7), width: 3)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.7),
                                width: 3))),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.max(context, 70),
                      FormBuilderValidators.email(context)
                    ]),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: InputDecoration(
                        labelText: 'كلمة السر',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontFamily: 'nawar'),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.7), width: 3)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.7), width: 3)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.7),
                                width: 3))),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.max(context, 70),
                      FormBuilderValidators.email(context)
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 17.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    boxShadow: <BoxShadow>[],
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [PRIMARY_COLOR, SECONDRY2_COLOR])),
                child: Text(
                  'سجل دخولك',
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.black,
                      fontFamily: 'nawar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
