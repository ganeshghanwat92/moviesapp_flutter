import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/model/custom_exception.dart';
import 'package:movies_app/model/multisearch/MultiSearchResponse.dart';


class ApiProvider{

  static const String baseUrl = "api.themoviedb.org";

  static const String API_KEY = "5b43064688877f072a019cc2c3a8c632";

  Future<dynamic> searchMovie(String search_key) async{

    http.Response response;
    var jsonData;

    var params = {
      "api_key" : API_KEY,
      "query" : search_key
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/search/movie", params);

      response = await http.get(uri);

      jsonData = _parseResponse(response);

    //  MovieResponse res = MovieResponse.fromJsonMap(jsonData);

      debugPrint("res = " + response.body.toString());
    }on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+e.message);
    }

    return jsonData;

  }

  Future<dynamic> searchTVShow(String search_key) async{

    http.Response response;

    var jsonData;

    var params = {
      "api_key" : API_KEY,
      "query" : search_key
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/search/tv", params);

      response = await http.get(uri);

      jsonData = _parseResponse(response);

      // TVResponse res = TVResponse.fromJsonMap(jsonData);

      debugPrint("res = " + response.body.toString());

    } on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+e.message);
    }

    return jsonData;

  }

  Future<dynamic> getMovieDetails(int movieId) async{

    var jsonData;

    var params = {
      "api_key" : API_KEY
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/movie/$movieId", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

     //   MovieDetails movieDetails = MovieDetails.fromJsonMap(jsonData);

        debugPrint("res = " + response.body.toString());

    //    return movieDetails;

    } on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+ e.message);
    }

    return jsonData;

  }

  Future<dynamic> getPopularMovies() async{

    var jsonData ;

    var params = {
      "api_key" : API_KEY
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/movie/popular", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

      debugPrint("res = " + response.body.toString());

    } on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+e.toString());
    }

    return jsonData;




  }

  Future<dynamic> getTopRatedMovies() async{

    var jsonData ;

    var params = {
      "api_key" : API_KEY
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/movie/top_rated", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

      debugPrint("res = " + response.body.toString());

    } on SocketException catch(e) {
      throw FetchDataException(" No Internet Connection "+e.message);
    }

    return jsonData;




  }

  Future<dynamic> getUpcomingMovies() async{

    var jsonData ;

    var params = {
      "api_key" : API_KEY
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/movie/upcoming", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

      debugPrint("res = " + response.body.toString());

    } on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+e.message);
    }

    return jsonData;

  }

  Future<dynamic> getNowPlayingMovies() async{

    var jsonData ;

    var params = {
      "api_key" : API_KEY
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/movie/now_playing", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

      debugPrint("res = " + response.body.toString());

    } on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+e.toString());
    }

    return jsonData;

  }


  Future<dynamic> getTopRatedTVShows() async{

    var jsonData ;

    var params = {
      "api_key" : API_KEY
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/tv/top_rated", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

      debugPrint("res = " + response.body.toString());

    } on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+e.toString());
    }

    return jsonData;

  }

  Future<dynamic> getPopularTVShows() async{

    var jsonData ;

    var params = {
      "api_key" : API_KEY
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/tv/popular", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

      debugPrint("res = " + response.body.toString());

    } on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+e.toString());
    }

    return jsonData;

  }

  Future<dynamic> getOnTheAirTVShows() async{

    var jsonData ;

    var params = {
      "api_key" : API_KEY
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/tv/on_the_air", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

      debugPrint("res = " + response.body.toString());

    } on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+e.toString());
    }

    return jsonData;

  }

  Future<dynamic> getTVShowsDetails(int tv_id) async{

    var jsonData ;

    var params = {
      "api_key" : API_KEY,
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/tv/$tv_id", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

      debugPrint("res = " + response.body.toString());

    } on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+e.toString());
    }

    return jsonData;

  }

  Future<dynamic> multiSearch(String query) async{

    var jsonData ;

    var params = {
      "api_key" : API_KEY,
      "query" : query,
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/search/multi", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

      debugPrint("res = " + response.body.toString());

    } on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+e.toString());
    }

    return jsonData;
  }


  Future<dynamic> multiSearchTemp(String query) async{

    var jsonData ;

    var params = {
      "api_key" : API_KEY,
      "query" : query,
    };



      Uri uri = Uri.https(baseUrl, "/3/search/multi", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

      debugPrint("res = " + response.body.toString());

    MultiSearchResponse results = MultiSearchResponse.fromJsonMap(jsonData);
  }

  Future<dynamic> getPeopleDetails(int id) async{

    var jsonData ;

    var params = {
      "api_key" : API_KEY,
    };

    try {

      Uri uri = Uri.https(baseUrl, "/3/person/$id", params);

      debugPrint("uri = " + uri.toString());

      http.Response response = await http.get(uri);

      jsonData = _parseResponse(response);

      debugPrint("res = " + response.body.toString());

    } on SocketException catch(e){
      throw FetchDataException(" No Internet Connection "+e.toString());
    }

    return jsonData;
  }



  dynamic _parseResponse(http.Response response){

    switch(response.statusCode){
      case 200 :
        var jsonData = json.decode(response.body.toString());
        return jsonData;
      case 201 :
        var jsonData = json.decode(response.body.toString());
        return jsonData;
      case 400 :
        throw BadRequestException(response.body);
      case 401 :
        throw UnauthorizedException(response.body);
      case 403 :
        throw ForbiddenException(response.body);
      case 404 :
        throw NotFoundException(response.body);
      case 500 :
        throw InternalServerException(response.body);
      case 501 :
        throw NotImplementedException(response.body);
      case 502 :
        throw BadGatewayException(response.body);
      default :
        throw FetchDataException(response.body);
    }

  }
}
