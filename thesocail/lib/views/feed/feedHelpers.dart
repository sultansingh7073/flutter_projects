import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:thesocail/constant/Constantcolors%20(1).dart';
import 'package:thesocail/services/authentication.dart';
import 'package:thesocail/utils/postOptions.dart';
import 'package:thesocail/utils/uploadPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesocail/views/altProfile/alt_profile.dart';

class FeedHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: constantColors.darkColor.withOpacity(0.6),
      actions: [
        IconButton(
            icon: Icon(
              Icons.add_a_photo,
              color: constantColors.greenColor,
            ),
            onPressed: () {
              Provider.of<UploadPost>(context, listen: false)
                  .selectPostImageType(context);
            })
      ],
      centerTitle: true,
      title: RichText(
        text: TextSpan(
            text: 'Social',
            style: TextStyle(
                color: constantColors.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: 'Feed',
                style: TextStyle(
                    color: constantColors.blueColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ]),
      ),
    );
  }

  Widget feedBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18))),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return loadPosts(context, snapshot);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget loadPosts(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
      children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
        Provider.of<PostFunctions>(context, listen: false)
            .showTimeAgo(documentSnapshot.data()['time']);
        return Column(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              if (documentSnapshot.data()['useruid'] !=
                                  Provider.of<Authentication>(context,
                                          listen: false)
                                      .getuserUid) {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: AltProfile(
                                          userUid: documentSnapshot
                                              .data()['useruid'],
                                        ),
                                        type: PageTransitionType.bottomToTop));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: CircleAvatar(
                                backgroundColor: constantColors.redColor,
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    documentSnapshot.data()['userimage']),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (documentSnapshot.data()['useruid'] !=
                                  Provider.of<Authentication>(context,
                                          listen: false)
                                      .getuserUid) {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: AltProfile(
                                          userUid: documentSnapshot
                                              .data()['useruid'],
                                        ),
                                        type: PageTransitionType.bottomToTop));
                              }
                            },
                            child: Text(
                              documentSnapshot.data()['username'],
                              style: TextStyle(
                                  fontSize: 16,
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(
                          ' ,${Provider.of<PostFunctions>(context, listen: false).getImageTimePosted.toString()}',
                          style: TextStyle(
                            color: constantColors.lightColor.withOpacity(0.8),
                          ),
                        ),
                        Spacer(),
                        Provider.of<Authentication>(context, listen: false)
                                    .getuserUid ==
                                documentSnapshot.data()['useruid']
                            ? IconButton(
                                icon: Icon(
                                  EvaIcons.moreVertical,
                                  color: constantColors.whiteColor,
                                  size: 22,
                                ),
                                onPressed: () {
                                  Provider.of<PostFunctions>(context,
                                          listen: false)
                                      .showPostMenu(context,
                                          documentSnapshot.data()['caption']);
                                })
                            : Container(
                                height: 0,
                                width: 0,
                              )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .45,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      documentSnapshot.data()['postimage'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print('add likes..');
                                  Provider.of<PostFunctions>(context,
                                          listen: false)
                                      .addLike(
                                          context,
                                          documentSnapshot.data()['caption'],
                                          Provider.of<Authentication>(context,
                                                  listen: false)
                                              .getuserUid);
                                },
                                onLongPress: () {
                                  Provider.of<PostFunctions>(context,
                                          listen: false)
                                      .showLikes(context,
                                          documentSnapshot.data()['caption']);
                                },
                                child: Icon(
                                  FontAwesomeIcons.heart,
                                  color: constantColors.redColor,
                                  size: 22,
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(documentSnapshot.data()['caption'])
                                      .collection('likes')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Provider.of<PostFunctions>(context,
                                                    listen: false)
                                                .showLikes(
                                                    context,
                                                    documentSnapshot
                                                        .data()['caption']);
                                          },
                                          child: Text(
                                            snapshot.data.docs.length
                                                .toString(),
                                            style: TextStyle(
                                                color:
                                                    constantColors.whiteColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      );
                                    }
                                  })
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Provider.of<PostFunctions>(context,
                                          listen: false)
                                      .showCommentsSheet(
                                          context,
                                          documentSnapshot,
                                          documentSnapshot.data()['caption']);
                                },
                                child: Icon(
                                  FontAwesomeIcons.comment,
                                  color: constantColors.yellowColor,
                                  size: 22,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('posts')
                                          .doc(documentSnapshot
                                              .data()['caption'])
                                          .collection('comments')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              snapshot.data.docs.length
                                                  .toString(),
                                              style: TextStyle(
                                                  color:
                                                      constantColors.whiteColor,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          );
                                        }
                                      })),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  FontAwesomeIcons.award,
                                  color: constantColors.blueColor,
                                  size: 22,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  '0',
                                  style: TextStyle(
                                      color: constantColors.whiteColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5),
                    child: Row(
                      children: [
                        Text(
                          "${documentSnapshot.data()["username"]} :- ",
                          style: TextStyle(
                              fontSize: 16,
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${documentSnapshot.data()['caption']}",
                          maxLines: 3,
                          style: TextStyle(
                            color: constantColors.lightColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Divider(
                color: constantColors.whiteColor.withOpacity(0.2),
              ),
            )
          ],
        );
      }).toList(),
    );
  }
}
