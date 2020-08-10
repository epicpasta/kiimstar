import 'package:flutter/material.dart';
import 'package:kiimstar/screens/search_screen.dart';
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
  String country = 'ng';
  String category = 'general';
  String query = '';
  int page = 1;

  Future<List<News>> getNews() async {
    var newsDataDecoded =
        await newsData.getNewsData(country, category, page, query);
    List<News> newsList = [];
    if (newsDataDecoded != null) {
      if (newsDataDecoded['articles'].length > 0) {
        for (var i = 0; i < newsDataDecoded['articles'].length; i++) {
          News news = News(
            heading: newsDataDecoded['articles'][i]['title'].toUpperCase(),
            description: newsDataDecoded['articles'][i]['description'],
            source: newsDataDecoded['articles'][i]['source']['name'],
            time: newsDataDecoded['articles'][i]['publishedAt'],
            imageURL: newsDataDecoded['articles'][i]['urlToImage'],
            sourceURl: newsDataDecoded['articles'][i]['url'],
          );

          newsList.add(news);
        }
      } else {
        return null;
      }
    }
    return newsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kiimstar! Real News',
          style: TextStyle(
            color: kSecAppColour,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: kMainAppColour,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                var popVariable = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
                if (popVariable != null) {
                  setState(() {
                    query = popVariable;
                  });
                }
              })
        ],
      ),
      backgroundColor: kMainAppColour,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton(
                        style: TextStyle(color: kSecAppColour),
                        dropdownColor: kMainAppColour,
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
                    SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                      style: TextStyle(color: kSecAppColour),
                      dropdownColor: kMainAppColour,
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
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Page: $page',
                      style: kInfoTextStyle,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: kMainAppColour,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: FutureBuilder(
                      future: getNews(),
                      builder: (context, AsyncSnapshot<List<News>> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Container(
                              child: Text(
                                'Loading...',
                                style: kInfoTextStyle,
                              ),
                            ),
                          );
                        }
                        return NewsFeedBuilder(
                          snapshot: snapshot,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                          child: Text('Prev Page'),
                          onPressed: () {
                            setState(() {
                              if (page == 1) {
                                return;
                              } else {
                                page--;
                              }
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                          child: Text('Reset'),
                          onPressed: () {
                            setState(() {
                              query = '';
                              page = 1;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                          child: Text('Next Page'),
                          onPressed: () {
                            setState(() {
                              page++;
                            });
                          }),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
