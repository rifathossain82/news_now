import 'package:flutter/material.dart';
import 'package:my_news_apps/model/News_Info.dart';
import 'package:my_news_apps/pages/Details_News.dart';

import '../bloc/News_Bloc.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({ Key? key }) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

 final news_bloc=News_Bloc();

@override
void initState() {
    news_bloc.eventSink.add(newsAction.Fetch);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Now'),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<List<Articles>>(
          stream: news_bloc.newsStream,
          builder: (contex,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
            itemBuilder: (context,index){
              var article=snapshot.data![index];
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Details_news(snapshot.data,index)));
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: 100,
                  child: Row(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: AspectRatio(
                          aspectRatio: 1,
                        child: Image.network("${article.urlToImage}",fit: BoxFit.cover,),),
                      ),
                      SizedBox(width: 16,),
                      Flexible(
                        child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${article.title}",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                           SizedBox(height: 8,),
                            Expanded(child: Text("${article.description}",overflow: TextOverflow.ellipsis,maxLines: 3,)),
                          ],
                        ),
                      )
                    ],
                    ),
                  ),
              );
            }
            );
            }
            else if(snapshot.hasError){
              return Center(child: Text("${snapshot.error}"),);
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
            
          },
        ),
      ),
    );
  }
}