import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ConnectionErrorFailure extends Failure {
  ConnectionErrorFailure({String suffix = ''}) : super("Connection Error: $suffix");
}

class ConnectionTimeOutFailure extends Failure {
  ConnectionTimeOutFailure({String suffix = ''}) : super("Connection Time Out: $suffix");
}

class FetchDataFailure extends Failure {
  FetchDataFailure({String suffix = ''}) : super("Fetch Data Failure: $suffix");
}

class SendTimeOutFailure extends Failure {
  SendTimeOutFailure({String suffix = ''}) : super("Send Time Out: $suffix");
}

class ReceiveTimeOutFailure extends Failure {
  ReceiveTimeOutFailure({String suffix = ''}) : super("Receive Time Out: $suffix");
}

class BadCertificateFailure extends Failure {
  BadCertificateFailure({String suffix = ''}) : super("Bad Certificate: $suffix");
}

class CancelFailure extends Failure {
  CancelFailure({String suffix = ''}) : super("Cancel Failure: $suffix}");
}

class MethodNotAllowedFailure extends Failure {
  MethodNotAllowedFailure({String suffix = ''}) : super("Method Not Allowed: $suffix");
}

class UnprocessableContentFailure extends Failure {
  UnprocessableContentFailure({String suffix = ''}) : super("Unprocessable Content: $suffix");
}

class InternalServeFailure extends Failure {
  InternalServeFailure({String suffix = ''}) : super("Internal Server Failure: $suffix");
}

class BadRequestFailure extends Failure {
  BadRequestFailure({String suffix = ''}) : super("Bad Request: $suffix");
}

class NotFoundFailure extends Failure {
  NotFoundFailure({String suffix = ''}) : super("Not Found Resources: $suffix");
}

class CacheFailure extends Failure {
  CacheFailure({String suffix = ''}) : super("Cache Failure: $suffix");
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({String suffix = ''}) : super("Unauthorized: $suffix");
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure({String suffix = ''}) : super("Forbidden: $suffix");
}

class DuplicatedDataFailure extends Failure {
  DuplicatedDataFailure({String suffix = ''}) : super("Duplicated Data: $suffix");
}

class MissingParamsFailure extends Failure {
  MissingParamsFailure({String suffix = ''}) : super("Missing Params Failure: $suffix");
}

class UnknownFailure extends Failure {
  UnknownFailure({String suffix = ''}) : super("Unexpected Failure: $suffix");
}
