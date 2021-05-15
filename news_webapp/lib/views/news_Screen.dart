import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_webapp/constant.dart';
import 'package:news_webapp/models/category_model.dart';
import 'package:news_webapp/viewModel/category_data.dart';
import 'package:news_webapp/viewModel/news_article_list_viewModel.dart';
import 'package:news_webapp/views/widget.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<CategoryModel> category = <CategoryModel>[];
  @override
  void initState() {
    super.initState();
    var data = Provider.of<NewsArticleListViewModel>(context, listen: false);
    data.topHeadlines();
    category = getCategory();
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel =
        Provider.of<NewsArticleListViewModel>(context, listen: false);
    print(listViewModel.getArticles);
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                color: black,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 20),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Friday, June 18th",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Daily feed",
                              style: GoogleFonts.poppins(
                                  fontSize: 35,
                                  color: white,
                                  fontWeight: FontWeight.w400)),
                          Icon(
                            Icons.edit_outlined,
                            size: 25,
                            color: pink,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 40,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(height: 4, width: 1, color: Colors.grey),
                        itemCount: category.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                              title: category[index].categoryName);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                color: black,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.trending_up_outlined,
                            color: pink,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Popular News",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Consumer<NewsArticleListViewModel>(
                      builder: (context, value, child) => Container(
                        height: MediaQuery.of(context).size.height * 0.67,
                        child: ListView.separated(
                          itemCount: listViewModel.articles.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(height: 2, color: Colors.grey),
                          itemBuilder: (context, index) {
                            return MobileNews(
                                title: listViewModel.articles.length.toString(),
                                imageUrl:
                                    listViewModel.articles[index].urlToImage);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
