//! for handle  http exception
class HttpException implements Exception {
  String message;

  HttpException({required this.message});

  @override
  String toString() {
    return 'CustomException: $message';
  }
}
