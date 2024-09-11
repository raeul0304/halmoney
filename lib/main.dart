import 'package:flutter/material.dart';
import 'package:halmoney/pages/login_page.dart';
import 'package:halmoney/screens/resume/step1_hello.dart';
import 'package:halmoney/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //final String id ='sumin1234';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ko', 'KR'),

      title: 'Flutter Demo',
      theme: theme(context),
      //datepicker 날짜 한국어 변환
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        //Locale('en', ''), //English, no country code
        Locale('ko', ''), //Korean, no country code
      ],
      debugShowCheckedModeBanner:  false,

      //원래 로그인 페이지로 연결
      home: LoginPage(),
      // 아래는 테스트용으로 원하는 페이지 연결용
      // git에 올릴때 반드시 수정
      // home: StepHelloPage(id: "silver"),

      // initialRoute: "/login",
      // routes: {
      //   "/login" : (context) => LoginPage(),
      //   "/signup" : (context) => SignupPage()
      // },
      /*home: Scaffold(
        appBar: AppBar(
          title: Text('할MONEY'),

        ),
        body: Center(
          child: Text(
            '할MONEY',
            style: TextStyle(
              fontSize: 50,
              color: Colors.indigo,
            ),
          )
        ),
      ),*/
    );
  }
}