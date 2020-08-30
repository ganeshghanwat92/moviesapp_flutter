import 'dart:async';

import 'package:movies_app/model/movie/movie_details.dart';
import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';

class MovieDetailsBLoC {

  Repository _repository;
  StreamController _streamController;

  StreamSink<ResultWrapper<MovieDetails>> get dataSink => _streamController.sink;

  Stream<ResultWrapper<MovieDetails>> get dataStream => _streamController.stream;

  MovieDetailsBLoC(int movieId){
    _repository = Repository();
    _streamController = StreamController<ResultWrapper<MovieDetails>>();
    fetchMovieDetails(movieId);
  }

  fetchMovieDetails(int movieId) async {

    dataSink.add(ResultWrapper.loading());

    var movieDetailsResult = await _repository.getMovieDetails(movieId);

    dataSink.add(movieDetailsResult);

  }

  dispose(){
    _streamController?.close();
  }


}