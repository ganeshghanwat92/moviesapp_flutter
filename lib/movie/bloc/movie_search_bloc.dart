import 'dart:async';

import 'package:movies_app/model/movie/movieresponse.dart';
import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';

class MovieSearchBLoC {
  Repository _repository;
  StreamController<ResultWrapper<MovieResponse>> _streamController;

  MovieSearchBLoC() {
    _repository = Repository();
    _streamController = StreamController<ResultWrapper<MovieResponse>>();
  }

  StreamSink<ResultWrapper<MovieResponse>> get dataSink =>
      _streamController.sink;

  Stream<ResultWrapper<MovieResponse>> get stream => _streamController.stream;

  searchMovie(String search_key) async {
    dataSink.add(ResultWrapper.loading());

    var res = await _repository.searchMovie(search_key);

    dataSink.add(res);
  }

  dispose() {
    _streamController?.close();
  }
}
