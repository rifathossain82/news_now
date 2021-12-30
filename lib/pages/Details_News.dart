import 'package:flutter/material.dart';
import 'package:my_news_apps/model/News_Info.dart';

class Details_news extends StatelessWidget {

  List<Articles>? news;
  int index;

  Details_news(this.news,this.index);





  @override
  Widget build(BuildContext context) {
    return Text("${news![index].title}");
  }
}
