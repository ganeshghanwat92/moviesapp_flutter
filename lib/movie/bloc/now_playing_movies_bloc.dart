import 'dart:async';

import 'package:movies_app/model/movie/movieresponse.dart';
import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';

class NowPlayingMoviesBLoC{

  Repository _repository;
  StreamController<ResultWrapper<MovieResponse>> _streamController;

  NowPlayingMoviesBLoC(){

    _repository = Repository();
    _streamController = StreamController<ResultWrapper<MovieResponse>>();

    getNowPlayingMovies();
  }

  StreamSink<ResultWrapper<MovieResponse>> get streamSink => _streamController.sink;

  Stream<ResultWrapper<MovieResponse>> get stream => _streamController.stream;

  getNowPlayingMovies() async{

    streamSink.add(ResultWrapper.loading());

    var result = await  _repository.getNowPlayingMovies();

    streamSink.add(result);


  }

  dispose(){
    _streamController?.close();
  }



}