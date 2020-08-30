class CustomNetworkException implements Exception{

    String message;
    String body;

    CustomNetworkException(this.message, this.body);

    @override
    String toString() {
      return 'message: $message, body: $body';
    }


}


class FetchDataException extends CustomNetworkException{
  FetchDataException([body]) : super("Connection Failed",body);
}

//400
class BadRequestException extends CustomNetworkException{
  BadRequestException([body]) : super("400 : Bad Request ",body);
}

//401
class UnauthorizedException extends CustomNetworkException{
  UnauthorizedException([body]) : super("401 : Unauthorized ",body);
}
//403
class ForbiddenException extends CustomNetworkException{
  ForbiddenException([body]) : super("403 : Forbidden ",body);
}

//404
class NotFoundException extends CustomNetworkException{
  NotFoundException([body]) : super("404 : Not Found ",body);
}

//500
class InternalServerException extends CustomNetworkException{
  InternalServerException([body]) : super("500 : Internal Server Error ",body);
}

//501
class NotImplementedException extends CustomNetworkException{
  NotImplementedException([body]) : super("501 : Not Implemented",body);
}

//502
class BadGatewayException extends CustomNetworkException{
  BadGatewayException([body]) : super("502 : Bad Gateway ",body);
}



