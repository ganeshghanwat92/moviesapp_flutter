import 'package:flutter/material.dart';
import 'package:movies_app/movie/movie_home_page.dart';
import 'package:movies_app/search/search_all_home_page.dart';
import 'package:movies_app/tv/tv_home_page.dart';

void main() => runApp(MyMoviesApp());

class MyMoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Movies App",
      theme: ThemeData(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String appBarText = "Movie App";
  int navigationSelectedIndex = 0;

  final List<Widget> _children = [MovieHomePage(), TVShowHomePage(), SearchAllHomePage()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText),
      ),
      //  body: _children[navigationSelectedIndex],
      body: IndexedStack(
        index: navigationSelectedIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getBottomNavigationBarContents(),
        selectedItemColor: Colors.amber,
        currentIndex: navigationSelectedIndex,
        onTap: (int index) {
          setState(() {
            navigationSelectedIndex = index;
          });
        },
      ),
    );
  }

  _getBottomNavigationBarContents() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        title: Text("Movies"),
        icon: Icon(Icons.movie),
      ),
      BottomNavigationBarItem(
        title: Text("TV Shows"),
        icon: Icon(Icons.tv),
      ),
      BottomNavigationBarItem(
        title: Text("Search"),
        icon: Icon(Icons.search),
      ),
    ];
  }
}




