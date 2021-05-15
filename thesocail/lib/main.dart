import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocail/constant/Constantcolors%20(1).dart';
import 'package:thesocail/views/landingPage/landinghelper.dart';
import 'package:thesocail/services/authentication.dart';
import 'package:thesocail/views/splashScreen/splashScreen.dart';
import 'package:thesocail/views/landingPage/landingServices.dart';
import 'package:thesocail/services/firebaseoperation.dart';
import 'package:thesocail/views/landingPage/landingutils.dart';
import 'package:thesocail/views/homepage/HomepageHelpers.dart';
import 'package:thesocail/views/Profile/profilehelpers.dart';
import 'package:thesocail/utils/uploadPost.dart';
import 'package:thesocail/views/feed/feedHelpers.dart';
import 'package:thesocail/utils/postOptions.dart';
import 'package:thesocail/views/altProfile/alt_profile_helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              accentColor: constantColors.blueColor,
              canvasColor: Colors.transparent),
          home: SplashScreen(),
        ),
        providers: [
          ChangeNotifierProvider(create: (_) => AltProfilehelpers()),
          ChangeNotifierProvider(create: (_) => PostFunctions()),
          ChangeNotifierProvider(create: (_) => FeedHelpers()),
          ChangeNotifierProvider(create: (_) => UploadPost()),
          ChangeNotifierProvider(create: (_) => ProfileHelpers()),
          ChangeNotifierProvider(create: (_) => HomepageHelpers()),
          ChangeNotifierProvider(create: (_) => LandingUtils()),
          ChangeNotifierProvider(create: (_) => FirebaseOperations()),
          ChangeNotifierProvider(create: (_) => Authentication()),
          ChangeNotifierProvider(create: (_) => LandingService()),
          ChangeNotifierProvider(create: (_) => LandingHelpers()),
        ]);
  }
}
