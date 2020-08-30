import 'dart:async';

import 'package:movies_app/model/movie/movieresponse.dart';
import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';

class UpcomingMoviesBLoC{

  Repository _repository;
  StreamController<ResultWrapper<MovieResponse>> _streamController;

  UpcomingMoviesBLoC(){

    _repository = Repository();
    _streamController = StreamController<ResultWrapper<MovieResponse>>();

    getUpcomingMovies();
  }

  StreamSink<ResultWrapper<MovieResponse>> get streamSink => _streamController.sink;

  Stream<ResultWrapper<MovieResponse>> get stream => _streamController.stream;

  getUpcomingMovies() async{

    streamSink.add(ResultWrapper.loading());

    var result = await  _repository.getUpcomingMovies();

    streamSink.add(result);

    
  }

dispose(){
  _streamController?.close();
}



}