import 'dart:async';

import 'package:movies_app/model/multisearch/MultiSearchResponse.dart';
import 'package:movies_app/model/multisearch/results.dart';
import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';

class MultiSearchBLoC {
  Repository _repository;
  StreamController<ResultWrapper<MultiSearchResponse>> _streamController;

  StreamController<List<int>> _streamControllerFilter;

  ResultWrapper<MultiSearchResponse> res;

  MultiSearchResponse multiSearchResponseOriginal;

  MultiSearchBLoC() {
    _repository = Repository();
    _streamController = StreamController.broadcast(); //<ResultWrapper<MultiSearchResponse>>();
    _streamControllerFilter = StreamController();
  }

  StreamSink<ResultWrapper<MultiSearchResponse>> get sink => _streamController.sink;

  Stream<ResultWrapper<MultiSearchResponse>> get stream => _streamController.stream;

  StreamSink<List<int>> get sinkFilter => _streamControllerFilter.sink;

  Stream<List<int>>  get streamFilter => _streamControllerFilter.stream;


  search(query) async {

    sink.add(ResultWrapper.loading());

    res = await _repository.multiSearch(query);

    multiSearchResponseOriginal = res.data;

    sink.add(res);

    getEachFiltersCount();
  }

  getEachFiltersCount(){

    List<int> _listFilter = [0,0,0];   // movie. tv, people

    List<Results> results = multiSearchResponseOriginal.results;

    results.forEach((element) {

      if(element.media_type == "movie"){
        _listFilter[0] = _listFilter[0] + 1;
      }else if(element.media_type == "tv"){
        _listFilter[1] = _listFilter[1] + 1;
      }else if(element.media_type == "person"){
        _listFilter[2] = _listFilter[2] + 1;
      }
    });

    sinkFilter.add(_listFilter);

  }

  filterByMovie() {

    sink.add(ResultWrapper.loading());

    print(" multiSearchResponseOriginal result list  = "+multiSearchResponseOriginal.results.toString());

    MultiSearchResponse multiSearch = MultiSearchResponse();
    multiSearch.page = multiSearchResponseOriginal.page;
    multiSearch.total_pages = multiSearchResponseOriginal.total_pages;
    multiSearch.total_results = multiSearchResponseOriginal.total_results;
    multiSearch.results =  List<Results>();

    List<Results> listToFilter = new List<Results>();
    listToFilter.addAll(multiSearchResponseOriginal.results);

    print("listToFilter = "+listToFilter.toString());

    List<Results> filteredList = listToFilter.where((element) {
      return element.media_type == "movie";
    }).toList();

    print("Filtered list = "+filteredList.toString());
    print("Filtered list size = "+filteredList.length.toString());

    // replace result list with new filtered list
    multiSearch.results.addAll(filteredList);

    sink.add(ResultWrapper.success(multiSearch));
  }

  filterByTV() {

    sink.add(ResultWrapper.loading());

    print(" multiSearchResponseOriginal result list  = "+multiSearchResponseOriginal.results.toString());

    MultiSearchResponse multiSearch = MultiSearchResponse();
    multiSearch.page = multiSearchResponseOriginal.page;
    multiSearch.total_pages = multiSearchResponseOriginal.total_pages;
    multiSearch.total_results = multiSearchResponseOriginal.total_results;
    multiSearch.results =  List<Results>();

    List<Results> listToFilter = new List<Results>();
    listToFilter.addAll(multiSearchResponseOriginal.results);

    print("listToFilter = "+listToFilter.toString());

    List<Results> filteredList = listToFilter.where((element) {
      return element.media_type == "tv";
    }).toList();

    print("Filtered list = "+filteredList.toString());
    print("Filtered list size = "+filteredList.length.toString());

    // replace result list with new filtered list
    multiSearch.results.clear();
    multiSearch.results.addAll(filteredList);

    sink.add(ResultWrapper.success(multiSearch));
  }

  filterByPeople() {

    sink.add(ResultWrapper.loading());

    print(" multiSearchResponseOriginal result list  = "+multiSearchResponseOriginal.results.toString());

    MultiSearchResponse multiSearch = MultiSearchResponse();
    multiSearch.page = multiSearchResponseOriginal.page;
    multiSearch.total_pages = multiSearchResponseOriginal.total_pages;
    multiSearch.total_results = multiSearchResponseOriginal.total_results;
    multiSearch.results =  List<Results>();

    List<Results> listToFilter = new List<Results>();
    listToFilter.addAll(multiSearchResponseOriginal.results);

    print("listToFilter = "+listToFilter.toString());

    List<Results> filteredList = listToFilter.where((element) {
      return element.media_type == "person";
    }).toList();

    print("Filtered list = "+filteredList.toString());
    print("Filtered list size = "+filteredList.length.toString());

    // replace result list with new filtered list
    multiSearch.results.clear();
    multiSearch.results.addAll(filteredList);

    sink.add(ResultWrapper.success(multiSearch));
  }


  dispose() {
    _streamController?.close();
    _streamControllerFilter?.close();
  }
}
