import 'package:flutter/material.dart';
import 'package:kiimstar/utilities/constants.dart';
import 'package:kiimstar/utilities/news.dart';
import 'package:kiimstar/screens/webscreen.dart';

class NewsFeedBuilder extends StatelessWidget {
  final AsyncSnapshot<List<News>> snapshot;

  NewsFeedBuilder({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Webscreen(
                  url: snapshot.data[index].sourceURl,
                  title: snapshot.data[index].source,
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kSecAppColour,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.network(
                      snapshot.data[index].imageURL ?? noImageURL),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: Text(
                    snapshot.data[index].heading ?? ' ',
                    textAlign: TextAlign.center,
                    style: kHeadingTextStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    snapshot.data[index].description ?? ' ',
                    textAlign: TextAlign.center,
                    style: kDescriptionTextStyle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      snapshot.data[index].source ?? ' ',
                      style: kBottomTextStyle,
                    ),
                    Text(
                      snapshot.data[index].time ?? ' ',
                      style: kBottomTextStyle,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
