import 'package:explorergocustomer/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'consts/consts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: whiteColor,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: highEmphasis,
            fontFamily: semibold,
            fontSize: 18,
          ),
          backgroundColor: whiteColor,
          elevation: 1,
          iconTheme: IconThemeData(
            color: darkFontGrey,
          )
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}

