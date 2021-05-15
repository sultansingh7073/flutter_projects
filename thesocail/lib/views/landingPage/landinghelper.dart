import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:thesocail/constant/Constantcolors%20(1).dart';
import 'package:thesocail/services/authentication.dart';

import 'package:thesocail/views/homepage/homepage.dart';
import 'package:thesocail/views/landingPage/landingServices.dart';
import 'package:thesocail/views/landingPage/landingutils.dart';

class LandingHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget bodyImage(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          'assets/bodyimage.png',
        ),
      )),
    );
  }

  Widget taglineText(BuildContext context) {
    return Positioned(
        top: 450,
        left: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("You are on",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: constantColors.whiteColor,
                )),
            Text("Socail ?",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                  color: constantColors.blueColor,
                ))
          ],
        ));
  }

  Widget tagButton(BuildContext context) {
    return Positioned(
        top: 580,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  emailAuthSheet(context);
                },
                child: Container(
                  width: 80,
                  height: 40,
                  child: Icon(
                    EvaIcons.emailOutline,
                    color: constantColors.yellowColor,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.yellowColor),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('google signIn!!');
                  Provider.of<Authentication>(context, listen: false)
                      .signInWithGoogle()
                      .whenComplete(() => Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: HomePage(),
                              type: PageTransitionType.leftToRight)));
                },
                child: Container(
                  width: 80,
                  height: 40,
                  child: Icon(
                    EvaIcons.google,
                    color: constantColors.redColor,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.redColor),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 80,
                  height: 40,
                  child: Icon(
                    EvaIcons.facebook,
                    color: constantColors.blueColor,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.blueColor),
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ));
  }

  Widget privacyText(BuildContext context) {
    return Positioned(
        top: 670,
        left: 20,
        right: 20,
        child: Container(
          color: Colors.black12,
          width: MediaQuery.of(context).size.width - 40,
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "By continuing you agree theSocial's Terms of",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                "Services & privacy policy",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ));
  }

  emailAuthSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4,
                    color: constantColors.whiteColor,
                  ),
                ),
                Provider.of<LandingService>(context, listen: false)
                    .passwordLessSignIn(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      color: constantColors.blueColor,
                      child: Text(
                        "SignIn",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: constantColors.whiteColor),
                      ),
                      onPressed: () {
                        Provider.of<LandingService>(context, listen: false)
                            .loginSheet(context);
                      },
                    ),
                    MaterialButton(
                      color: constantColors.redColor,
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: constantColors.whiteColor),
                      ),
                      onPressed: () {
                        Provider.of<LandingUtils>(context, listen: false)
                            .selectAvatarOptionsSheet(context);
                      },
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
