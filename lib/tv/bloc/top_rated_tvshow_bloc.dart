import 'dart:async';

import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/model/tvshow/tvresponse.dart';

class TopRatedTVShowsBLoC{

  Repository _repository;
  StreamController<ResultWrapper<TVResponse>> _streamController;

  TopRatedTVShowsBLoC(){
    _repository = Repository();
    _streamController = StreamController<ResultWrapper<TVResponse>>();
    getTopRatedTVShows();
  }

  StreamSink<ResultWrapper<TVResponse>> get sink => _streamController.sink;

  Stream<ResultWrapper<TVResponse>> get stream => _streamController.stream;

  getTopRatedTVShows() async{

    sink.add(ResultWrapper.loading());

    var res = await _repository.getTopRatedTVShows();

    sink.add(res);

  }

  dispose(){
    _streamController?.close();
  }


}