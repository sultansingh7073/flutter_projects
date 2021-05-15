import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocail/constant/Constantcolors%20(1).dart';
import 'package:thesocail/views/altProfile/alt_profile_helpers.dart';

class AltProfile extends StatelessWidget {
  final ConstantColors constantColors = ConstantColors();
  final String userUid;
  AltProfile({@required this.userUid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Provider.of<AltProfilehelpers>(context, listen: false)
          .appBar(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: constantColors.blueGreyColor.withOpacity(0.6),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userUid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Provider.of<AltProfilehelpers>(context, listen: false)
                        .headerProfile(context, snapshot, userUid),
                    Provider.of<AltProfilehelpers>(context, listen: false)
                        .divider(),
                    Provider.of<AltProfilehelpers>(context, listen: false)
                        .middleProfile(context, snapshot),
                    Provider.of<AltProfilehelpers>(context, listen: false)
                        .footerProfile(context, snapshot),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
