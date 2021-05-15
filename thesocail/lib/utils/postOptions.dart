import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:thesocail/constant/Constantcolors%20(1).dart';
import 'package:thesocail/services/authentication.dart';
import 'package:thesocail/services/firebaseoperation.dart';
import 'package:thesocail/views/altProfile/alt_profile.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class PostFunctions with ChangeNotifier {
  TextEditingController commentController = TextEditingController();
  TextEditingController updatedCaptionController = TextEditingController();
  ConstantColors constantColors = ConstantColors();

  String imageTimePosted;
  String get getImageTimePosted => imageTimePosted;
  showTimeAgo(dynamic timeData) {
    Timestamp time = timeData;
    DateTime dateTime = time.toDate();
    imageTimePosted = timeAgo.format(dateTime);
    print(imageTimePosted);
    notifyListeners();
  }

  Future addLike(BuildContext context, String postId, String subDocId) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(subDocId)
        .set({
      'likes': FieldValue.increment(1),
      'username': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserName,
      'userimage': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserImage,
      'useremail': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserEmail,
      'useruid': Provider.of<Authentication>(context, listen: false).userUid,
      'time': Timestamp.now()
    });
  }

  Future addComment(BuildContext context, String postId, String comment) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(comment)
        .set({
      'comment': comment,
      'username': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserName,
      'userimage': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserImage,
      'useremail': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserEmail,
      'useruid': Provider.of<Authentication>(context, listen: false).userUid,
      'time': Timestamp.now()
    });
  }
  ///////////-------------------show comment sheet-----------------------------///

  showCommentsSheet(
      BuildContext context, DocumentSnapshot snapshot, String docId) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: constantColors.blueGreyColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    child: Divider(
                      color: constantColors.whiteColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: constantColors.whiteColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        'Comments',
                        style: TextStyle(
                            color: constantColors.blueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(docId)
                          .collection('comments')
                          .orderBy('time')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView(
                            children: snapshot.data.docs
                                .map((DocumentSnapshot documentSnapshot) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 8),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  PageTransition(
                                                      child: AltProfile(
                                                          userUid:
                                                              documentSnapshot
                                                                      .data()[
                                                                  'useruid']),
                                                      type: PageTransitionType
                                                          .leftToRight));
                                            },
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundColor:
                                                  constantColors.darkColor,
                                              backgroundImage: NetworkImage(
                                                  documentSnapshot
                                                      .data()['userimage']),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            child: Text(
                                              documentSnapshot
                                                  .data()['username'],
                                              style: TextStyle(
                                                  color:
                                                      constantColors.whiteColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 200,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                    FontAwesomeIcons.arrowUp,
                                                    color: constantColors
                                                        .blueColor,
                                                    size: 12,
                                                  ),
                                                  onPressed: () {}),
                                              Text(
                                                '0',
                                                style: TextStyle(
                                                    color: constantColors
                                                        .blueColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IconButton(
                                                  icon: Icon(
                                                    FontAwesomeIcons.reply,
                                                    color: constantColors
                                                        .yellowColor,
                                                    size: 14,
                                                  ),
                                                  onPressed: () {}),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: constantColors.blueColor,
                                              size: 12,
                                            ),
                                            onPressed: () {}),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.72,
                                          child: Text(
                                            documentSnapshot.data()['comment'],
                                            style: TextStyle(
                                                color: constantColors.blueColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              FontAwesomeIcons.trashAlt,
                                              color: constantColors.redColor,
                                              size: 16,
                                            ),
                                            onPressed: () {}),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 20,
                            width: 280,
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: commentController,
                              decoration: InputDecoration(
                                  hintText: 'add comment...',
                                  hintStyle: TextStyle(
                                      color: constantColors.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            addComment(context, snapshot.data()['caption'],
                                    commentController.text)
                                .whenComplete(() {
                              commentController.clear();
                              notifyListeners();
                            });
                          },
                          backgroundColor: constantColors.greenColor,
                          child: Icon(
                            FontAwesomeIcons.comment,
                            color: constantColors.whiteColor,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
//!----------------------------------------------show likes---------------------///

  showLikes(BuildContext context, String postId) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    color: constantColors.whiteColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: constantColors.whiteColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Likes',
                      style: TextStyle(
                          color: constantColors.blueColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: 400,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(postId)
                        .collection('likes')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot documentSnapshot) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              color: constantColors.blueColor.withOpacity(0.01),
                              child: ListTile(
                                  leading: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                              child: AltProfile(
                                                  userUid: documentSnapshot
                                                      .data()['useruid']),
                                              type: PageTransitionType
                                                  .leftToRight));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: constantColors.redColor,
                                      backgroundImage: NetworkImage(
                                        documentSnapshot.data()['userimage'],
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    documentSnapshot.data()['username'],
                                    style: TextStyle(
                                        color: constantColors.whiteColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Provider.of<Authentication>(context,
                                                  listen: false)
                                              .getuserUid ==
                                          documentSnapshot.data()['useruid']
                                      ? Container(
                                          height: 0,
                                          width: 0,
                                        )
                                      : GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            'Follow',
                                            style: TextStyle(
                                                color: constantColors.blueColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  //todo-------------post side menu---------------------//
  showPostMenu(BuildContext context, String postId) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    color: constantColors.whiteColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () {
//? ----------------for edit caption--------------------
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Container(
                                      height: 300,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 300,
                                              height: 50,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    hintText: 'Add new caption',
                                                    hintStyle: TextStyle(
                                                        fontSize: 16,
                                                        color: constantColors
                                                            .whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: constantColors
                                                        .whiteColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                controller:
                                                    updatedCaptionController,
                                              ),
                                            ),
                                            FloatingActionButton(
                                              onPressed: () {
                                                Provider.of<FirebaseOperations>(
                                                        context,
                                                        listen: false)
                                                    .updatedCaption(postId, {
                                                  'caption':
                                                      updatedCaptionController
                                                          .text
                                                });
                                              },
                                              backgroundColor:
                                                  constantColors.redColor,
                                              child: Icon(
                                                FontAwesomeIcons.arrowCircleUp,
                                                size: 20,
                                                color:
                                                    constantColors.whiteColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          color: constantColors.blueColor,
                          child: Text(
                            'Edit Caption',
                            style: TextStyle(
                                fontSize: 16,
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: constantColors.darkColor,
                                    title: Text(
                                      'Delete This Post?',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: constantColors.whiteColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  constantColors.whiteColor,
                                              fontSize: 16,
                                              color: constantColors.whiteColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          Provider.of<FirebaseOperations>(
                                                  context,
                                                  listen: false)
                                              .deleteUserData(postId, 'posts')
                                              .whenComplete(
                                                  () => Navigator.pop(context));
                                        },
                                        color: constantColors.redColor,
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: constantColors.whiteColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          color: constantColors.redColor,
                          child: Text(
                            'Delete Post',
                            style: TextStyle(
                                fontSize: 16,
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
