import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Utils.dart';
import 'package:movies_app/model/movie/movieresponse.dart';
import 'package:movies_app/model/movie/movieresults.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/movie/bloc/now_playing_movies_bloc.dart';
import 'package:movies_app/movie/bloc/popular_movies_bloc.dart';
import 'package:movies_app/movie/bloc/top_rated_movies_bloc.dart';
import 'package:movies_app/movie/bloc/upcoming_movie_bloc.dart';
import 'package:movies_app/movie/movie_details.dart';
import 'package:movies_app/movie/search_movie.dart';

class MovieHomePage extends StatefulWidget {
  @override
  _MovieHomePageState createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  PopularMoviesBLoC _popularMoviesBLoC;
  TopRatedMoviesBLoC _topRatedMoviesBLoC;
  UpcomingMoviesBLoC _upcomingMoviesBLoC;
  NowPlayingMoviesBLoC _nowPlayingMoviesBLoC;

  final _searchMovieTextController = TextEditingController();


  @override
  void initState() {
    _popularMoviesBLoC = PopularMoviesBLoC();
    _topRatedMoviesBLoC = TopRatedMoviesBLoC();
    _upcomingMoviesBLoC = UpcomingMoviesBLoC();
    _nowPlayingMoviesBLoC = NowPlayingMoviesBLoC();
    super.initState();
  }

  @override
  void dispose() {
    _popularMoviesBLoC.dispose();
    _topRatedMoviesBLoC.dispose();
    _upcomingMoviesBLoC.dispose();
    _nowPlayingMoviesBLoC.dispose();

    _searchMovieTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  _searchMovieWidget(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Now Playing",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),),
                  ),
                  Expanded(
                    child: Container(
                      height: 180,
                      child: _getNowPlayingMovies(),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Upcoming",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),),
                  ),

                  Expanded(
                    child: Container(
                      height: 180,
                      child: _getUpcomingMovies(),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Popular",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),),
                  ),

                  Expanded(
                    child: Container(
                      height: 180,
                      child: _getPopularMovies(),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Top Rated",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),),
                  ),

                  Expanded(
                    child: Container(
                      height: 180,
                      child: _getTopRatedMovies(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }

  Widget _getNowPlayingMovies() {
    return StreamBuilder<ResultWrapper<MovieResponse>>(
      stream: _nowPlayingMoviesBLoC.stream,
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
                return Expanded(
                  child: Center(
                    child: Text("data not available"),
                  ),
                );
              } else {
                //   return Expanded(child:
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.data.results.length,
                  itemBuilder: (context, i) {
                    //     if (i.isOdd) return new Divider(); // notice color is added to style divider
                    return _buildMovieListRow(snapshot.data.data.results[i]);
                  },
                  //    ),
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
                    onPressed: () =>
                        _nowPlayingMoviesBLoC.getNowPlayingMovies(),
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

  Widget _getPopularMovies() {
    return StreamBuilder<ResultWrapper<MovieResponse>>(
      stream: _popularMoviesBLoC.stream,
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
                return Expanded(
                  child: Center(
                    child: Text("data not available"),
                  ),
                );
              } else {
                //   return Expanded(child:
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.data.results.length,
                  itemBuilder: (context, i) {
                    //     if (i.isOdd) return new Divider(); // notice color is added to style divider
                    return _buildMovieListRow(snapshot.data.data.results[i]);
                  },
                  //     ),
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
                    onPressed: () => _popularMoviesBLoC.getPopularMovies(),
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

  Widget _getTopRatedMovies() {
    return StreamBuilder<ResultWrapper<MovieResponse>>(
      stream: _topRatedMoviesBLoC.stream,
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
                return Expanded(
                  child: Center(
                    child: Text("data not available"),
                  ),
                );
              } else {
                //   return Expanded(child:
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.data.results.length,
                  itemBuilder: (context, i) {
                    //     if (i.isOdd) return new Divider(); // notice color is added to style divider
                    return _buildMovieListRow(snapshot.data.data.results[i]);
                  },
                  //    ),
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
                    onPressed: () => _topRatedMoviesBLoC.getTopRatedMovies(),
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

  Widget _getUpcomingMovies() {
    return StreamBuilder<ResultWrapper<MovieResponse>>(
      stream: _upcomingMoviesBLoC.stream,
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
                return Expanded(
                  child: Center(
                    child: Text("data not available"),
                  ),
                );
              } else {
                //    return Expanded( child:
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.data.results.length,
                  itemBuilder: (context, i) {
                    //     if (i.isOdd) return new Divider(); // notice color is added to style divider
                    return _buildMovieListRow(snapshot.data.data.results[i]);
                  },
                  //     ),
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
                    onPressed: () => _upcomingMoviesBLoC.getUpcomingMovies(),
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

  Widget _buildMovieListRow(MovieResults movie) {
    return Center(
      child: Card(
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CachedNetworkImage(
                height: 170,
                width: 110,
                imageUrl: Utils.buildPosterImageUrl(movie.poster_path),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill,
                fadeInCurve: Curves.easeIn,
                fadeInDuration: Duration(seconds: 2),
                fadeOutCurve: Curves.easeOut,
                fadeOutDuration: Duration(seconds: 2),
              ),
              //   Text(movie.title),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MovieDetailsPage(movieId: movie.id)));
          },
        ),
      ),
    );
  }

  Widget _searchMovieWidget(){

    return Container(
      padding: EdgeInsets.all(10),
        child: Row(
          children: [
           Expanded(
            /* child:TextField(
               decoration: InputDecoration(
                 labelText: "search your movie here",
               ),
               controller: _searchMovieTextController,
             ),*/
             child: TextField(
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
                     _searchMovieTextController.clear();
                     // hide keyboard
                     FocusScopeNode currentFocus = FocusScope.of(context);
                     currentFocus.unfocus();

                   },),
               ),
               controller: _searchMovieTextController,
               onSubmitted:(String str){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchMovie(query : str)));
               },
             ),
           ),
          /*  SizedBox(
              width: 15,
            ),
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.lightBlueAccent,
              onPressed: () {
                String searchQuery = _searchMovieTextController.text.toString();
                // navigate to search page
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchMovie(query : searchQuery)));
              },
            )*/
          ],
        ),
    );
  }
}
