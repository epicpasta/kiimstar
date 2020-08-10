import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          backgroundColor: Colors.black87,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    query = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'What are you looking for?',
                    hintStyle: TextStyle(color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, query);
                  },
                  child: Text(
                    'search',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black87,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
