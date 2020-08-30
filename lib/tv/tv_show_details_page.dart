import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Utils.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/model/tvshow/tv_show_details.dart';
import 'package:movies_app/tv/bloc/tv_show_details_bloc.dart';

class TVShowDetailsPage extends StatefulWidget {

  int tv_id;
  TVShowDetailsPage({Key key,@required this.tv_id}) : super(key : key);

  @override
  _TVShowDetailsPageState createState() => _TVShowDetailsPageState();
}

class _TVShowDetailsPageState extends State<TVShowDetailsPage> {

  TVShowDetailsBLoC _tvShowDetailsBLoC;

  @override
  void initState() {

    _tvShowDetailsBLoC = TVShowDetailsBLoC(widget.tv_id);

    super.initState();
  }

  @override
  void dispose() {

    _tvShowDetailsBLoC.dispose();

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
          padding: EdgeInsets.all(8.0),
          child: _getTVShowDetails(),
        ),
      ),
    );
  }

  _getTVShowDetails(){

    return StreamBuilder<ResultWrapper<TvShowDetails>>(
      stream: _tvShowDetailsBLoC.stream,
      builder: (context, snapshot){
        if(snapshot.hasData){
         switch(snapshot.data.status){

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
                       onPressed: () => _tvShowDetailsBLoC.getShowDetails(widget.tv_id),
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

}