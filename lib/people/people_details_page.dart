import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Utils.dart';
import 'package:movies_app/model/multisearch/known_for.dart';
import 'package:movies_app/model/multisearch/results.dart';
import 'package:movies_app/model/people/People.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/people/bloc/people_details_bloc.dart';

class PeopleDetailsPage extends StatefulWidget {
  int id;
  Results results;
  PeopleDetailsPage({Key key, @required this.id, this.results})
      : super(key: key);

  @override
  _PeopleDetailsPageState createState() => _PeopleDetailsPageState();
}

class _PeopleDetailsPageState extends State<PeopleDetailsPage> {
  PeopleDetailsBLoC _peopleDetailsBLoC;

  @override
  void initState() {
    _peopleDetailsBLoC = PeopleDetailsBLoC(widget.id);

    if(widget.results!=null)
    print("results list = "+widget.results.known_for.length.toString());

    super.initState();
  }

  @override
  void dispose() {
    _peopleDetailsBLoC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (BuildContext buildContext, BoxConstraints boxConstraints){
          return SingleChildScrollView(
            padding: EdgeInsets.all(12.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:  boxConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: _getPeopleDetails(),
              ),
            ),
          );
        }),
      ),
    );
  }

  _getPeopleDetails() {
    return StreamBuilder<ResultWrapper<People>>(
      stream: _peopleDetailsBLoC.dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case Status.SUCCESS:
              return Column(
                children: [
                  CachedNetworkImage(
                    //  height: 200,
                    imageUrl: Utils.buildBackdropImageUrl(
                        snapshot.data.data.profile_path),
                    placeholder: (context, url) => CircularProgressIndicator(),
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
                    snapshot.data.data.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data.data.known_for_department,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data.data.place_of_birth,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data.data.birthday,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data.data.biography,
                    //  textAlign: TextAlign.left,
                    //  overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                 if(widget.results!=null && widget.results.known_for.isNotEmpty)
                   Flexible(
                     child: Container(
                       height: 180,
                       child:_buildKnownForList(widget.results.known_for),
                     ),
                   ),

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
                    onPressed: () => _peopleDetailsBLoC.fetchDetails(widget.id),
                  )
                ],
              ));
              break;
          }
        }
        return Center(
          child: Container(),
        );
      },
    );
  }

  Widget _buildKnownForList(List<KnownFor> knownFor) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: knownFor.length,
      itemBuilder: (context, i) {
        return _buildListRow(knownFor[i]);
      },
    );
  }
}

Widget _buildListRow(KnownFor knownFor) {
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
              imageUrl: Utils.buildPosterImageUrl(knownFor.poster_path == null ? "" : knownFor.poster_path),
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
          //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieDetailsPage(movieId: movie.id)));
        },
      ),
    ),
  );
}
