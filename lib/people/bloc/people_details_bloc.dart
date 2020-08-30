import 'dart:async';

import 'package:movies_app/model/people/People.dart';
import 'package:movies_app/model/repository.dart';
import 'package:movies_app/model/result_wrapper.dart';

class PeopleDetailsBLoC{

  Repository _repository;
  StreamController _streamController;

  StreamSink<ResultWrapper<People>> get dataSink => _streamController.sink;

  Stream<ResultWrapper<People>> get dataStream => _streamController.stream;

  PeopleDetailsBLoC(int id){
    _repository = Repository();
    _streamController = StreamController<ResultWrapper<People>>();
    fetchDetails(id);
  }

  fetchDetails(int id) async {

    dataSink.add(ResultWrapper.loading());

    var res = await _repository.getPeopleDetails(id);

    dataSink.add(res);

  }

  dispose(){
    _streamController?.close();
  }

}