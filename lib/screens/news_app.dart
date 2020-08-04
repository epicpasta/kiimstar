import 'package:flutter/material.dart';
import 'package:kiimstar/utilities/constants.dart';
import 'package:kiimstar/utilities/lists.dart';
import 'package:kiimstar/utilities/news.dart';
import 'package:kiimstar/utilities/news_data.dart';
import 'package:kiimstar/widgets/news_feed_builder.dart';

class NewsApp extends StatefulWidget {
  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  NewsData newsData = NewsData();
  String country = 'us';
  String category = 'general';

  Future<List<News>> getNews() async {
    var newsDataDecoded = await newsData.getNewsData(country, category);
    List<News> newsList = [];
    if (newsDataDecoded != null) {
      for (var i = 0; i < newsDataDecoded['articles'].length; i++) {
        // setState(() {
        News news = News(
          heading: newsDataDecoded['articles'][i]['title'].toUpperCase(),
          description: newsDataDecoded['articles'][i]['description'],
          source: newsDataDecoded['articles'][i]['source']['name'],
          time: newsDataDecoded['articles'][i]['publishedAt'],
          imageURL: newsDataDecoded['articles'][i]['urlToImage'],
          sourceURl: newsDataDecoded['articles'][i]['url'],
        );

        newsList.add(news);
        // });
      }
    }
    return newsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainAppColour,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50, left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Kiimstar! Real News',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                      DropdownButton(
                          value: category,
                          items: categoryList
                              .map<DropdownMenuItem<String>>((String newValue) {
                            return DropdownMenuItem<String>(
                              value: newValue,
                              child: Text(newValue.toUpperCase()),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              category = newValue;
                            });
                          }),
                      DropdownButton(
                        value: country,
                        items: countryCode.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value.toUpperCase()),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              country = value;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: FutureBuilder(
                future: getNews(),
                builder: (context, AsyncSnapshot<List<News>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Container(
                        child: Text('Loading...'),
                      ),
                    );
                  }
                  return NewsFeedBuilder(
                    snapshot: snapshot,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
