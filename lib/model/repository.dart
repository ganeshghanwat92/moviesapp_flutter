import 'package:movies_app/model/movie/movieresponse.dart';
import 'package:movies_app/model/multisearch/MultiSearchResponse.dart';
import 'package:movies_app/model/network.dart';
import 'package:movies_app/model/people/People.dart';
import 'package:movies_app/model/result_wrapper.dart';
import 'package:movies_app/model/tvshow/tv_show_details.dart';
import 'package:movies_app/model/tvshow/tvresponse.dart';

import 'movie/movie_details.dart';

class Repository {

  ApiProvider apiProvider = ApiProvider();

  Future<ResultWrapper<MovieDetails>> getMovieDetails(int movieId) async{
    
    ResultWrapper<MovieDetails> result;
    
    try{

      var res = await apiProvider.getMovieDetails(movieId);

      MovieDetails movieDetails = MovieDetails.fromJsonMap(res);
      
      result = ResultWrapper.success(movieDetails);

    }catch(e){

      result = ResultWrapper.failed(e.toString());
      print(e);
    }

   return result;
  }

  Future<ResultWrapper<MovieResponse>> searchMovie(String search_key) async{

    ResultWrapper<MovieResponse> result;

    try{

      var res = await apiProvider.searchMovie(search_key);

      MovieResponse movieResponse = MovieResponse.fromJsonMap(res);

      result = ResultWrapper.success(movieResponse);

    }catch(e){
      result = ResultWrapper.failed(e.toString());
      print(e);
    }

    return result;
  }

  Future<ResultWrapper<TVResponse>> searchTVShow(String search_key) async{

    ResultWrapper<TVResponse> result;

    try{

      var res = await apiProvider.searchTVShow(search_key);

      TVResponse tvResponse = TVResponse.fromJsonMap(res);

      result = ResultWrapper.success(tvResponse);

    }catch(e){
      result = ResultWrapper.failed(e.toString());
      print(e);
    }
    return result;
  }

  Future<ResultWrapper<MovieResponse>> getPolularMovies() async{

    ResultWrapper<MovieResponse> result;

    try{

      var res = await apiProvider.getPopularMovies();

      MovieResponse movieResponse = MovieResponse.fromJsonMap(res);

      result = ResultWrapper.success(movieResponse);

    }catch(e){

      result = ResultWrapper.failed(e.toString());
      print(e);
    }

    return result;

  }

  Future<ResultWrapper<MovieResponse>> getTopRatedMovies() async{

    ResultWrapper<MovieResponse> result;

    try{

      var res = await apiProvider.getTopRatedMovies();

      MovieResponse movieResponse = MovieResponse.fromJsonMap(res);

      result = ResultWrapper.success(movieResponse);

    }catch(e){

      result = ResultWrapper.failed(e.toString());
      print(e);
    }
    return result;

  }

  Future<ResultWrapper<MovieResponse>> getUpcomingMovies() async{

    ResultWrapper<MovieResponse> result;

    try{

      var res = await apiProvider.getUpcomingMovies();

      MovieResponse movieResponse = MovieResponse.fromJsonMap(res);

      result = ResultWrapper.success(movieResponse);

    }catch(e){

      result = ResultWrapper.failed(e.toString());
      print(e);
    }

    return result;

  }

  Future<ResultWrapper<MovieResponse>> getNowPlayingMovies() async{

    ResultWrapper<MovieResponse> result;

    try{

      var res = await apiProvider.getNowPlayingMovies();

      MovieResponse movieResponse = MovieResponse.fromJsonMap(res);

      result = ResultWrapper.success(movieResponse);

    }catch(e){

      result = ResultWrapper.failed(e.toString());
      print(e);
    }

    return result;

  }


  Future<ResultWrapper<TVResponse>> getPopularTVShows() async{

    ResultWrapper<TVResponse> result;

    try{

      var res = await apiProvider.getPopularTVShows();

      TVResponse tvResponse = TVResponse.fromJsonMap(res);

      result = ResultWrapper.success(tvResponse);

    }catch(e){

      result = ResultWrapper.failed(e.toString());
      print(e);
    }

    return result;

  }

  Future<ResultWrapper<TVResponse>> getTopRatedTVShows() async{

    ResultWrapper<TVResponse> result;

    try{

      var res = await apiProvider.getTopRatedTVShows();

      TVResponse tvResponse = TVResponse.fromJsonMap(res);

      result = ResultWrapper.success(tvResponse);

    }catch(e){

      result = ResultWrapper.failed(e.toString());
      print(e);
    }

    return result;

  }

  Future<ResultWrapper<TVResponse>> getOnTheAirTVShows() async{

    ResultWrapper<TVResponse> result;

    try{

      var res = await apiProvider.getOnTheAirTVShows();

      TVResponse tvResponse = TVResponse.fromJsonMap(res);

      result = ResultWrapper.success(tvResponse);

    }catch(e){

      result = ResultWrapper.failed(e.toString());
      print(e);
    }

    return result;

  }

  Future<ResultWrapper<TvShowDetails>> getTVShowsDetails(int tv_id) async{

    ResultWrapper<TvShowDetails> result;

    try{

      var res = await apiProvider.getTVShowsDetails(tv_id);

      TvShowDetails tvShowDetails = TvShowDetails.fromJsonMap(res);

      result = ResultWrapper.success(tvShowDetails);

    }catch(e){

      result = ResultWrapper.failed(e.toString());
      print(e);
    }

    return result;

  }

  Future<ResultWrapper<MultiSearchResponse>> multiSearch(String query) async{

    ResultWrapper<MultiSearchResponse> result;

    try{

      var res = await apiProvider.multiSearch(query);

      MultiSearchResponse multiSearch = MultiSearchResponse.fromJsonMap(res);

      result = ResultWrapper.success(multiSearch);

    }catch(e){

      result = ResultWrapper.failed(e.toString());
      print(e);
    }

    return result;

  }

  Future<ResultWrapper<People>> getPeopleDetails(int id) async{

    ResultWrapper<People> result;

    try{

      var res = await apiProvider.getPeopleDetails(id);

      People people = People.fromJsonMap(res);

      result = ResultWrapper.success(people);

    }catch(e){

      result = ResultWrapper.failed(e.toString());
      print(e);
    }

    return result;

  }


}