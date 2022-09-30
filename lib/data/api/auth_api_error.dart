import '../network/network_errors.dart';

class BadCredentialsError extends ResponseError {
  BadCredentialsError(super.statusCode, super.responseData);
}