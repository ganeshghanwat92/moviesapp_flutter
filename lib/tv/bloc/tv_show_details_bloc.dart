import 'dart:async';

import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/model/tvshow/tv_show_details.dart';


class TVShowDetailsBLoC{

  Repository _repository;
  StreamController<ResultWrapper<TvShowDetails>> _streamController;

  StreamSink<ResultWrapper<TvShowDetails>> get dataSink => _streamController.sink;

  Stream<ResultWrapper<TvShowDetails>> get stream => _streamController.stream;

  TVShowDetailsBLoC(int tvId){

    _repository = Repository();

    _streamController = StreamController<ResultWrapper<TvShowDetails>>();

    getShowDetails(tvId);

  }

  getShowDetails(int tvId) async{

    dataSink.add(ResultWrapper.loading());

    var res = await _repository.getTVShowsDetails(tvId);

    dataSink.add(res);

  }

  dispose(){

    _streamController?.close();
  }

}