import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:thesocail/constant/Constantcolors%20(1).dart';
import 'package:thesocail/services/authentication.dart';
import 'package:thesocail/services/firebaseoperation.dart';

class UploadPost with ChangeNotifier {
  TextEditingController captionController = TextEditingController();
  ConstantColors constantColors = ConstantColors();
  final picker = ImagePicker();
  File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  String uploadPostImageUrl;
  String get getuploadPostImageUrl => uploadPostImageUrl;
  UploadTask imagePostUploadTask;

//Pick Images to gallery or camera---------------------------------------------------
  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final uploadPostImageVal = await picker.getImage(source: source);
    uploadPostImageVal == null
        ? print('select image')
        : uploadPostImage = File(uploadPostImageVal.path);
    print(uploadPostImage.path);

    uploadPostImage != null
        ? showPostImage(context)
        : print('image upload error!');
  }
  //------------upload to firestorage-----------------------------------------//

  Future uploadPostImageToFirebase() async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}');
    imagePostUploadTask = imageReference.putFile(uploadPostImage);
    await imagePostUploadTask.whenComplete(() => print('post image uploaded'));
    imageReference.getDownloadURL().then((imageUrl) {
      uploadPostImageUrl = imageUrl;
      print(uploadPostImageUrl);
    });
    notifyListeners();
  }

//----------------------------------------------------------------------------
  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: constantColors.blueGreyColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4,
                    color: constantColors.whiteColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          pickUploadPostImage(context, ImageSource.gallery);
                        },
                        color: constantColors.blueColor,
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                              fontSize: 16,
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          pickUploadPostImage(context, ImageSource.camera);
                        },
                        color: constantColors.greenColor,
                        child: Text(
                          'Camera',
                          style: TextStyle(
                              fontSize: 16,
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

//----------------------------------------------------------------------------------------
  showPostImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: constantColors.blueGreyColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4,
                    color: constantColors.whiteColor,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: 380,
                  child: Image.file(
                    uploadPostImage,
                    fit: BoxFit.contain,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        selectPostImageType(context);
                      },
                      color: constantColors.blueColor,
                      child: Text(
                        'Reselect',
                        style: TextStyle(
                            fontSize: 16,
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        uploadPostImageToFirebase().whenComplete(() {
                          editPostSheet(context);
                          print('image uploaded!!');
                        });
                      },
                      color: constantColors.greenColor,
                      child: Text(
                        'Comfirm Image',
                        style: TextStyle(
                            fontSize: 16,
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  //------------edit post sheet------------//
  editPostSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4,
                    color: constantColors.whiteColor,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.image_aspect_ratio,
                                  color: constantColors.greenColor,
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(
                                  Icons.fit_screen,
                                  color: constantColors.yellowColor,
                                ),
                                onPressed: () {})
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 300,
                        child: Image.file(
                          uploadPostImage,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset('assets/sunflower.png'),
                      ),
                      Container(
                        height: 110,
                        width: 5,
                        color: constantColors.blueColor,
                      ),
                      Container(
                        height: 120,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextField(
                            maxLength: 100,
                            maxLines: 5,
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100)
                            ],
                            maxLengthEnforced: true,
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            controller: captionController,
                            decoration: InputDecoration(
                                hintText: 'Add Captions...',
                                hintStyle: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                    onPressed: () {
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .uploadPostData(captionController.text, {
                        'caption': captionController.text,
                        'username': Provider.of<FirebaseOperations>(context,
                                listen: false)
                            .getInitUserName,
                        'postimage': getuploadPostImageUrl,
                        'userimage': Provider.of<FirebaseOperations>(context,
                                listen: false)
                            .getInitUserImage,
                        'useruid':
                            Provider.of<Authentication>(context, listen: false)
                                .getuserUid,
                        'time': Timestamp.now(),
                        'useremail': Provider.of<FirebaseOperations>(context,
                                listen: false)
                            .getInitUserEmail,
                      }).whenComplete(() => Navigator.pop(context));
                    },
                    color: constantColors.blueColor,
                    child: Text(
                      'Share Post',
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          );
        });
  }
}
