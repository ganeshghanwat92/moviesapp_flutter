import 'dart:async';

import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/model/tvshow/tvresponse.dart';


class SearchTVShowBLoC{

  Repository _repository;
  StreamController<ResultWrapper<TVResponse>> _streamController;

  StreamSink<ResultWrapper<TVResponse>> get dataSink => _streamController.sink;

  Stream<ResultWrapper<TVResponse>> get stream => _streamController.stream;

  SearchTVShowBLoC(){

    _repository = Repository();

    _streamController = StreamController<ResultWrapper<TVResponse>>();

  }

  searchTVShow(String searchKey) async{

    dataSink.add(ResultWrapper.loading());

    var res = await _repository.searchTVShow(searchKey);

    dataSink.add(res);

  }

  dispose(){

    _streamController?.close();
  }

}