import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Utils.dart';
import 'package:movies_app/model/multisearch/MultiSearchResponse.dart';
import 'package:movies_app/model/multisearch/results.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/movie/movie_details.dart';
import 'package:movies_app/people/people_details_page.dart';
import 'package:movies_app/search/multi_search_bloc.dart';
import 'package:movies_app/tv/tv_show_details_page.dart';

class SearchAllHomePage extends StatefulWidget {
  @override
  _SearchAllHomePageState createState() => _SearchAllHomePageState();
}

class _SearchAllHomePageState extends State<SearchAllHomePage> {
  MultiSearchBLoC _movieSearchBLoC;
  TextEditingController _textEditingController;

  var _filterArray = ["movie", "tv", "person"];
  int _selectedFilter = 0;

  @override
  void initState() {
    _movieSearchBLoC = MultiSearchBLoC();
    _textEditingController = TextEditingController();

   // ApiProvider().multiSearchTemp("lucifer");

    super.initState();
  }

  @override
  void dispose() {
    _movieSearchBLoC.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          labelText:
                              "search your movie, tv show, people etc. here",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(),
                          ),
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                              icon : Icon(Icons.clear),
                            onPressed: () {
                                _textEditingController.clear();
                                // hide keyboard
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                currentFocus.unfocus();

                            },),
                        ),
                        controller: _textEditingController,
                        onSubmitted:(String str){
                          _movieSearchBLoC.search(str);
                        },
                      ),
                    ),
                   /* IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.lightBlueAccent,
                      onPressed: () {
                        String query = _textEditingController.text.toString();
                        //  _getMovieData(query);
                        _movieSearchBLoC.search(query);
                      },
                    )*/
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: _buildFilters(),
                /* child: GridView.count(
                  shrinkWrap: true,
                  childAspectRatio: 3.0,
                  padding: EdgeInsets.all(5.0),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                  children: <Widget>[
                    GestureDetector(
                      child: _buildFilterWidget("Movies", 0),
                      onTap: () {
                          _movieSearchBLoC.filterByMovie();
                        setState(() {
                          _selectedFilter = 0;
                        });
                      },
                    ),
                    GestureDetector(
                      child: _buildFilterWidget("TV Shows", 1),
                      onTap: () {
                         _movieSearchBLoC.filterByTV();
                        setState(() {
                          _selectedFilter = 1;
                        });
                      },
                    ),
                    GestureDetector(
                      child: _buildFilterWidget("People", 2),
                      onTap: () {
                          _movieSearchBLoC.filterByPeople();
                        setState(() {
                          _selectedFilter = 2;
                        });
                      },
                    )
                  ],
                ),*/
              ),
              Expanded(
                child: _buildSearchList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterWidget(String title, int index) {
    bool isSelected = _selectedFilter == index;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: isSelected
                ? Colors.blue[300].withOpacity(0.8)
                : Colors.grey[700]),
        color: Colors.white,
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 12, color: isSelected ? Colors.blue[400] : Colors.black),
      ),
    );
  }

  Widget _buildSearchList() {
    return StreamBuilder<ResultWrapper<MultiSearchResponse>>(
      stream: _movieSearchBLoC.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case Status.SUCCESS:
              if (snapshot.data.data.results.isEmpty) {
                return Center(
                  child: Text("data not available"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.data.results.length,
                  itemBuilder: (context, i) {
                    //     if (i.isOdd) return new Divider(); // notice color is added to style divider
                    return _buildMultiSearchListRow(
                        snapshot.data.data.results[i]);
                  },
                );
              }
              break;
            case Status.FAILED:
              return Center(
                  child: Column(
                children: [
                  Text(
                    "Unable to fetch data : " + snapshot.data.message,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    child: Text("Retry"),
                    onPressed: () => _movieSearchBLoC
                        .search(_textEditingController.text.toString()),
                  )
                ],
              ));
              break;
          }
        }
        return Container();
      },
    );
  }

  Widget _buildMultiSearchListRow(Results results) {
    if (results.media_type == "movie")
      return _buildMovieItem(results);
    else if (results.media_type == "tv")
      return _buildTVShowItem(results);
    else if (results.media_type == "person") return _buildPersonItem(results);
  }

  _buildMovieItem(Results results) {
    return Card(
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: Utils.buildPosterImageUrl(results.backdrop_path),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
              fadeInCurve: Curves.easeIn,
              fadeInDuration: Duration(seconds: 2),
              fadeOutCurve: Curves.easeOut,
              fadeOutDuration: Duration(seconds: 2),
            ),
            ListTile(
              title: Text(results.title == null ? "null" : results.title),
              subtitle: Text(results.overview),
            )
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MovieDetailsPage(movieId: results.id)));
        },
      ),
    );
  }

  _buildTVShowItem(Results results) {
    return Card(
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: Utils.buildPosterImageUrl(results.backdrop_path),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
              fadeInCurve: Curves.easeIn,
              fadeInDuration: Duration(seconds: 2),
              fadeOutCurve: Curves.easeOut,
              fadeOutDuration: Duration(seconds: 2),
            ),
            ListTile(
              title: Text(results.name == null ? "null" : results.name),
              subtitle: Text(results.overview),
            )
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TVShowDetailsPage(tv_id: results.id)));
        },
      ),
    );
  }

  _buildPersonItem(Results results) {
    return Card(
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: Utils.buildPosterImageUrl(results.profile_path),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
              fadeInCurve: Curves.easeIn,
              fadeInDuration: Duration(seconds: 2),
              fadeOutCurve: Curves.easeOut,
              fadeOutDuration: Duration(seconds: 2),
            ),
            ListTile(
              title: Text(results.name == null ? "null" : results.name),
              subtitle:
                  Text(results.known_for_department == null ? "" : results.known_for_department),
            )
          ],
        ),
        onTap: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => PeopleDetailsPage(id: results.id, results: results,)));
        },
      ),
    );
  }

  _buildFilters() {
    int movie_count = 0;
    int tv_count = 0;
    int person_count = 0;

    return StreamBuilder<List<int>>(
      stream: _movieSearchBLoC.streamFilter,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          movie_count = snapshot.data[0];
          tv_count = snapshot.data[1];
          person_count = snapshot.data[2];
        }
        return GridView.count(
          shrinkWrap: true,
          childAspectRatio: 3.0,
          padding: EdgeInsets.all(5.0),
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
          children: <Widget>[
            GestureDetector(
              child: _buildFilterWidget("Movies ($movie_count)", 0),
              onTap: () {
                _movieSearchBLoC.filterByMovie();
                setState(() {
                  _selectedFilter = 0;
                });
              },
            ),
            GestureDetector(
              child: _buildFilterWidget("TV Shows ($tv_count)", 1),
              onTap: () {
                _movieSearchBLoC.filterByTV();
                setState(() {
                  _selectedFilter = 1;
                });
              },
            ),
            GestureDetector(
              child: _buildFilterWidget("People ($person_count)", 2),
              onTap: () {
                _movieSearchBLoC.filterByPeople();
                setState(() {
                  _selectedFilter = 2;
                });
              },
            )
          ],
        );
      },
    );
  }


}
