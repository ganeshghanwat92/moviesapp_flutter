import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Utils.dart';
import 'package:movies_app/model/movie/movie_details.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/movie/bloc/movie_details_bloc.dart';

class MovieDetailsPage extends StatefulWidget {
  MovieDetailsPage({Key key, @required this.movieId}) : super(key: key);

  final int movieId;

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {

  MovieDetailsBLoC _bLoC;

  @override
  void initState() {
    super.initState();

    _bLoC = MovieDetailsBLoC(widget.movieId);
  }

  @override
  void dispose() {
    _bLoC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: _getMovieDetails(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Refresh",
        child: Icon(Icons.refresh),
        onPressed: () {
          //  movieDataFuture = Repository().getMovieDetails(movieId);
          _bLoC.fetchMovieDetails(widget.movieId);
        },
      ),
    );
  }

  Widget _getMovieDetails() {
    return StreamBuilder<ResultWrapper<MovieDetails>>(
        stream: _bLoC.dataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.SUCCESS:
                return Column(
                  children: [
                    CachedNetworkImage(
                      //  height: 200,
                      imageUrl: Utils.buildBackdropImageUrl(
                          snapshot.data.data.backdrop_path),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fill,
                      fadeInCurve: Curves.easeIn,
                      fadeInDuration: Duration(seconds: 2),
                      fadeOutCurve: Curves.easeOut,
                      fadeOutDuration: Duration(seconds: 2),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data.data.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data.data.overview,
                      //  textAlign: TextAlign.left,
                      //  overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    )
                  ],
                );
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
                        onPressed: () => _bLoC.fetchMovieDetails(widget.movieId),
                      )
                    ],
                ));
                break;
              case Status.LOADING:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
            }
          }
          return Center(
            child: Container(),
          );
        });
  }
}
