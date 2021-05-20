import 'package:flutter/material.dart';
import 'package:news_webapp/constant.dart';

class CategoryTile extends StatelessWidget {
  final String title;

  const CategoryTile({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration:
          BoxDecoration(color: grey, borderRadius: BorderRadius.circular(20)),
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: Colors.white70, fontSize: 12),
      )),
    );
  }
}

class MobileNews extends StatelessWidget {
  final String title, imageUrl;
  const MobileNews({required this.title, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height / 4,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Image.network(imageUrl),
              ),
              Column(
                children: [Text(""), Text(title)],
              )
            ],
          )
        ],
      ),
    );
  }
}
