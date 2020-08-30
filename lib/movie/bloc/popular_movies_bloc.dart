import 'dart:async';

import 'package:movies_app/model/movie/movieresponse.dart';
import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';

class PopularMoviesBLoC {

  Repository _repository;
  StreamController<ResultWrapper<MovieResponse>> _streamController;

  PopularMoviesBLoC(){
    _repository = Repository();
    _streamController = StreamController<ResultWrapper<MovieResponse>>();

    getPopularMovies();
  }

  StreamSink<ResultWrapper<MovieResponse>> get streamSink => _streamController.sink;

  Stream<ResultWrapper<MovieResponse>> get stream => _streamController.stream;

  getPopularMovies() async{

    streamSink.add(ResultWrapper.loading());

    var res = await _repository.getPolularMovies();

    streamSink.add(res);

  }

  dispose(){
    _streamController?.close();

  }

}