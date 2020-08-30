import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/playground.dart';
// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Start name generator',
      home: RandomWords(),
      theme: ThemeData(primaryColor: Colors.blue),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair wordPair) {
    final alreadySaved = _saved.contains(wordPair);

    return ListTile(
      title: Text(
        wordPair.asCamelCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup name generator"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Next",
        onPressed: _navigateToNextPage,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      final tiles = _saved.map(
        (WordPair wordPair) {
          return ListTile(
            title: Text(
              wordPair.asCamelCase,
              style: _biggerFont,
            ),
          );
        },
      );

      final divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text("Saved Suggestions"),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

  void _navigateToNextPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SecondPage()));
  }
}
