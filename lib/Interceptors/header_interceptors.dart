import 'dart:async';
import 'package:chopper/chopper.dart';

class HeaderInterceptors implements RequestInterceptor {
  static const headers = {
    'apiKey': '8ebfd7ef-6590-4ad3-bced-9eea05cae7f7',
    'Content-Type': 'application/json'
  };
  @override
  FutureOr<Request> onRequest(Request request) {
    Request newRequest = request.copyWith(headers: headers);
    return newRequest;
  }
}
