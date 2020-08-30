import 'dart:async';

import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/model/tvshow/tvresponse.dart';

class OnAirTVShowBLoC{

  Repository _repository;
  StreamController<ResultWrapper<TVResponse>> _streamController;

  OnAirTVShowBLoC(){
    _repository = Repository();
    _streamController = StreamController<ResultWrapper<TVResponse>>();
    getOnAirTVShows();
  }

  StreamSink<ResultWrapper<TVResponse>> get sink => _streamController.sink;

  Stream<ResultWrapper<TVResponse>> get stream => _streamController.stream;

  getOnAirTVShows() async{

    sink.add(ResultWrapper.loading());

    var res = await _repository.getOnTheAirTVShows();

    sink.add(res);

  }

  dispose(){
    _streamController?.close();
  }


}