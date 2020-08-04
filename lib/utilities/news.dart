import 'package:flutter/widgets.dart';

class News {
  String heading;
  String description;
  String source;
  String time;
  String imageURL;
  String sourceURl;

  News({
    @required this.description,
    @required this.heading,
    @required this.imageURL,
    @required this.source,
    @required this.sourceURl,
    @required this.time,
  });
}
