import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Utils.dart';
import 'package:movies_app/model/movie/movieresponse.dart';
import 'package:movies_app/model/movie/movieresults.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/movie/bloc/movie_search_bloc.dart';
import 'package:movies_app/movie/movie_details.dart';

class SearchMovie extends StatefulWidget {
  String query;

  SearchMovie({Key key, @required this.query}) : super(key: key);

  @override
  _SearchMovieState createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  final movieSearchTextController = TextEditingController();

  // List<MovieResults> movieList = List<MovieResults>();

  MovieSearchBLoC _bLoC;

  @override
  void initState() {
    super.initState();
    _bLoC = MovieSearchBLoC();
    if (widget.query != null) {
      movieSearchTextController.text = widget.query;
      _bLoC.searchMovie(widget.query);
    }
  }

  @override
  void dispose() {
    movieSearchTextController.dispose();
    _bLoC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Movie"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    /*child: TextField(
                      decoration: InputDecoration(
                        labelText: "search your movie here",
                      ),
                      controller: movieSearchTextController,
                    ),*/
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        labelText:
                        "search your movie here",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(),
                        ),
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon : Icon(Icons.clear),
                          onPressed: () {
                            movieSearchTextController.clear();
                            // hide keyboard
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            currentFocus.unfocus();

                          },),
                      ),
                      controller: movieSearchTextController,
                      onSubmitted:(String str){
                        _bLoC.searchMovie(str);                      },
                    ),
                  ),
                /*  IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      String query = movieSearchTextController.text.toString();
                      //  _getMovieData(query);
                      _bLoC.searchMovie(query);
                    },
                  )*/
                ],
              ),
              StreamBuilder<ResultWrapper<MovieResponse>>(
                stream: _bLoC.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        break;
                      case Status.SUCCESS:
                        if (snapshot.data.data.results.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: Text("data not available"),
                            ),
                          );
                        } else {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.data.results.length,
                              itemBuilder: (context, i) {
                                //     if (i.isOdd) return new Divider(); // notice color is added to style divider
                                return _buildMovieListRow(
                                    snapshot.data.data.results[i]);
                              },
                            ),
                          );
                        }
                        break;
                      case Status.FAILED:
                        return Expanded(
                          child: Center(
                              child: Text(
                            "Unable to fetch data :" + snapshot.data.message,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          )),
                        );
                        break;
                    }
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieListRow(MovieResults movie) {
    return Card(
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: Utils.buildBackdropImageUrl(movie.backdrop_path),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
              fadeInCurve: Curves.easeIn,
              fadeInDuration: Duration(seconds: 2),
              fadeOutCurve: Curves.easeOut,
              fadeOutDuration: Duration(seconds: 2),
            ),
            ListTile(
              title: Text(movie.title),
              subtitle: Text(movie.overview),
            )
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MovieDetailsPage(movieId: movie.id)));
        },
      ),
    );
  }
}
