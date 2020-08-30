import 'dart:async';

import 'package:movies_app/model/movie/movieresponse.dart';
import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';

class TopRatedMoviesBLoC{

  Repository _repository;
  StreamController<ResultWrapper<MovieResponse>> _streamController;

  TopRatedMoviesBLoC(){
  _repository = Repository();
  _streamController = StreamController<ResultWrapper<MovieResponse>>();

  getTopRatedMovies();

  }

  StreamSink<ResultWrapper<MovieResponse>> get streamSink => _streamController.sink;

  Stream<ResultWrapper<MovieResponse>> get stream => _streamController.stream;

  getTopRatedMovies() async{

  streamSink.add(ResultWrapper.loading());

  var res = await _repository.getTopRatedMovies();

  streamSink.add(res);

  }

  dispose(){
  _streamController?.close();

  }

}