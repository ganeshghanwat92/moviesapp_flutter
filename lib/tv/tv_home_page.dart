import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Utils.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/model/tvshow/tvresponse.dart';
import 'package:movies_app/model/tvshow/tvresults.dart';
import 'package:movies_app/tv/bloc/on_air_tvshow_bloc.dart';
import 'package:movies_app/tv/bloc/popular_tvshow_bloc.dart';
import 'package:movies_app/tv/bloc/top_rated_tvshow_bloc.dart';
import 'package:movies_app/tv/search_tv_show.dart';
import 'package:movies_app/tv/tv_show_details_page.dart';

class TVShowHomePage extends StatefulWidget {
  @override
  _TVShowHomePageState createState() => _TVShowHomePageState();
}

class _TVShowHomePageState extends State<TVShowHomePage> {
  OnAirTVShowBLoC _onAirTVShowBLoC;
  PopularTVShowBLoC _popularTVShowBLoC;
  TopRatedTVShowsBLoC _topRatedTVShowsBLoC;

  TextEditingController _searchTVShowTextController;

  @override
  void initState() {
    _onAirTVShowBLoC = OnAirTVShowBLoC();
    _popularTVShowBLoC = PopularTVShowBLoC();
    _topRatedTVShowsBLoC = TopRatedTVShowsBLoC();

    _searchTVShowTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (BuildContext buildContext, BoxConstraints boxConstraints){
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:  boxConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  _searchWidget(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("On Air",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),),
                  ),

                  Expanded(
                    child: Container(
                      height: 180,
                      child: _getOnAirTVShows(),
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
                      child:_getPopularTVShows(),
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
                      child: _getTopRatedTVShows(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _onAirTVShowBLoC.dispose();
    _popularTVShowBLoC.dispose();
    _topRatedTVShowsBLoC.dispose();

    _searchTVShowTextController.dispose();
    super.dispose();
  }

  Widget _searchWidget(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
          /*  child:TextField(
              decoration: InputDecoration(
                labelText: "search your tv show here",
              ),
              controller: _searchTVShowTextController,
            ),*/
            child: TextField(
              style: TextStyle(
                fontSize: 12,
              ),
              decoration: InputDecoration(
                labelText:
                "search your tv show here",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon : Icon(Icons.clear),
                  onPressed: () {
                    _searchTVShowTextController.clear();
                    // hide keyboard
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    currentFocus.unfocus();

                  },),
              ),
              controller: _searchTVShowTextController,
              onSubmitted:(String str){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchTVShow(query : str)));
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
              String searchQuery = _searchTVShowTextController.text.toString();
              // navigate to search page
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchTVShow(query : searchQuery)));
            },
          )*/
        ],
      ),
    );
  }

  Widget _buildTVShowListRow(TVResults tvResults) {
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
                imageUrl: Utils.buildPosterImageUrl(tvResults.poster_path),
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TVShowDetailsPage(tv_id: tvResults.id)));
          },
        ),
      ),
    );
  }

  Widget _getOnAirTVShows() {
    return StreamBuilder<ResultWrapper<TVResponse>>(
      stream: _onAirTVShowBLoC.stream,
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
                    return _buildTVShowListRow(snapshot.data.data.results[i]);
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
                        onPressed: () => _onAirTVShowBLoC.getOnAirTVShows(),
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

  Widget _getPopularTVShows() {
    return StreamBuilder<ResultWrapper<TVResponse>>(
      stream: _popularTVShowBLoC.stream,
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
                    return _buildTVShowListRow(snapshot.data.data.results[i]);
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
                        onPressed: () => _popularTVShowBLoC.getPopularTVShows(),
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

  Widget _getTopRatedTVShows() {
    return StreamBuilder<ResultWrapper<TVResponse>>(
      stream: _topRatedTVShowsBLoC.stream,
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
                    return _buildTVShowListRow(snapshot.data.data.results[i]);
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
                        onPressed: () => _topRatedTVShowsBLoC.getTopRatedTVShows(),
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




}
