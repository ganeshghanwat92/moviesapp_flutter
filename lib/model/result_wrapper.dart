class ResultWrapper<T>{

  Status status;
  T data;
  String message;

  ResultWrapper.loading() : status = Status.LOADING;
  ResultWrapper.success(this.data) : status = Status.SUCCESS;
  ResultWrapper.failed(this.message) : status = Status.FAILED;
  

}

enum Status{LOADING, SUCCESS, FAILED}