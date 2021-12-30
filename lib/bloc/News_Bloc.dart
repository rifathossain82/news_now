import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/News_Info.dart';

enum newsAction{Fetch,Delete}

class News_Bloc{
  final _stateStreamController=StreamController<List<Articles>>();
  StreamSink<List<Articles>> get _newsSink=>_stateStreamController.sink;
  Stream<List<Articles>> get newsStream=>_stateStreamController.stream;


  final _eventStreamController=StreamController<newsAction>();
  StreamSink<newsAction> get eventSink=>_eventStreamController.sink;
  Stream<newsAction> get eventStream=>_eventStreamController.stream;



  News_Bloc(){
    eventStream.listen((event) async {
      if(event==newsAction.Fetch){
        try {
          var news=await getNews();
          if(news!=null){
            var articles = news.articles;
          _newsSink.add(articles!);
          }
          else{
            _newsSink.addError('Something went worng.');
          }
          
        } on Exception catch (e) {
          _newsSink.addError('Something went worng.');
        }
      }
    });
  }

  Future<NewsModel> getNews()async{
    var client=http.Client();
    var news_model=null;

    try {
      var response=await client.get(Uri.parse("https://newsapi.org/v2/everything?domains=wsj.com&apiKey=c5e766b1d1dc41679345d1b64eeda872"));

      if(response.statusCode==200){
        var jsonString=response.body;
        var jsonMap=jsonDecode(jsonString);

        news_model=NewsModel.fromJson(jsonMap);
      }

    } on Exception catch (e) {
      return news_model;
    }
    return news_model;
  }
}