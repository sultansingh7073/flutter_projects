import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:thesocail/constant/Constantcolors%20(1).dart';
import 'package:thesocail/services/authentication.dart';
import 'package:thesocail/views/Profile/profilehelpers.dart';

class Profile extends StatelessWidget {
  final ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constantColors.blueGreyColor.withOpacity(0.4),
        leading: IconButton(
          icon: Icon(
            EvaIcons.settings2Outline,
            color: constantColors.blueColor,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(EvaIcons.logOutOutline),
            onPressed: () {
              Provider.of<ProfileHelpers>(context, listen: false)
                  .logOutDialog(context);
            },
            color: constantColors.greenColor,
          )
        ],
        centerTitle: true,
        title: RichText(
          text: TextSpan(
              text: 'My',
              style: TextStyle(
                  color: constantColors.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: 'Profile',
                  style: TextStyle(
                      color: constantColors.blueColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(15)),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(Provider.of<Authentication>(context, listen: false)
                      .getuserUid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: [
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .headerProfile(context, snapshot.data),
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .divider(),
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .middleProfile(context, snapshot),
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .footerProfile(context, snapshot),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
