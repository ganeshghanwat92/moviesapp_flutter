import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Utils.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/model/tvshow/tvresponse.dart';
import 'package:movies_app/model/tvshow/tvresults.dart';
import 'package:movies_app/tv/bloc/search_tvshow_bloc.dart';

class SearchTVShow extends StatefulWidget {
  String query;
  SearchTVShow({Key key, @required this.query}) : super(key: key);

  @override
  _SearchTVShowState createState() => _SearchTVShowState();
}

class _SearchTVShowState extends State<SearchTVShow> {
  final tvSearchTextController = TextEditingController();

//  List<TVResults> tvShowList = List<TVResults>();

  SearchTVShowBLoC _bLoC;

  @override
  void initState() {
    _bLoC = SearchTVShowBLoC();
    if (widget.query != null) {
      tvSearchTextController.text = widget.query;
      _bLoC.searchTVShow(widget.query);
    }
    super.initState();
  }

  @override
  void dispose() {
    tvSearchTextController.dispose();
    _bLoC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search TV Show"),
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
                        labelText: "search your tv show here",
                      ),
                      controller: tvSearchTextController,
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
                            tvSearchTextController.clear();
                            // hide keyboard
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            currentFocus.unfocus();

                          },),
                      ),
                      controller: tvSearchTextController,
                      onSubmitted:(String str){
                        _bLoC.searchTVShow(str);                      },
                    ),

                  ),
                 /* IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      String query = tvSearchTextController.text.toString();
                      //_getTVShowData(query);
                      _bLoC.searchTVShow(query);
                    },
                  )*/
                ],
              ),
              StreamBuilder<ResultWrapper<TVResponse>>(
                stream: _bLoC.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Expanded(
                            child: Center(
                          child: CircularProgressIndicator(),
                        ));
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
                                return _buildTVShowListRow(
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

              /* child: ListView.builder(
                itemCount: tvShowList.length,
                itemBuilder: (context, i) {
                  //     if (i.isOdd) return new Divider(); // notice color is added to style divider

                  return _buildTVShowListRow(tvShowList[i]);
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  /*Future _getTVShowData(String query) async {
    TVResponse res = await network.ApiProvider().searchTVShow(query);
    setState(() {
      tvShowList.clear();
      tvShowList.addAll(res.results);
    });
  }*/

  Widget _buildTVShowListRow(TVResults tvShow) {
    return Card(
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CachedNetworkImage(
              height: 200,
              imageUrl: Utils.buildBackdropImageUrl(tvShow.backdrop_path),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
              fadeInCurve: Curves.easeIn,
              fadeInDuration: Duration(seconds: 2),
              fadeOutCurve: Curves.easeOut,
              fadeOutDuration: Duration(seconds: 2),
            ),
            ListTile(
              title: Text(tvShow.original_name),
              subtitle: Text(tvShow.overview),
            )
          ],
        ),
        onTap: () {
          // TODO move to details view
        },
      ),
    );
  }
}
