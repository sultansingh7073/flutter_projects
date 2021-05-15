import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thesocail/constant/Constantcolors%20(1).dart';
import 'package:thesocail/services/firebaseoperation.dart';
import 'package:thesocail/views/Profile/Profile.dart';
import 'package:thesocail/views/chatRoom/Chatroom.dart';
import 'package:thesocail/views/feed/Feed.dart';
import 'package:thesocail/views/homepage/HomepageHelpers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConstantColors constantColors = ConstantColors();
  final PageController homepageController = PageController();
  int pageIndex = 0;
  @override
  void initState() {
    Provider.of<FirebaseOperations>(context, listen: false)
        .initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constantColors.darkColor,
        body: PageView(
          controller: homepageController,
          children: [Feed(), Chatroom(), Profile()],
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              pageIndex = page;
            });
          },
        ),
        bottomNavigationBar:
            Provider.of<HomepageHelpers>(context, listen: false)
                .bottomNavBar(context, pageIndex, homepageController));
  }
}
