import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  void _getUser() {
    if (_controller.text == '') {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(
                  'https://img.icons8.com/fluent/2x/ffffff/github.png',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Github',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 130,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.1)),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Github username',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {},
              padding: EdgeInsets.all(20),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Align(
                child: Text(
                  'Get Your Follower Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
