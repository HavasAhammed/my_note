import 'dart:async';

import 'package:chopper/chopper.dart';

class HeaderInterceptors implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    final headers = Map<String, String>.from(request.headers);
    headers['apiKey'] = '8ebfd7ef-6590-4ad3-bced-9eea05cae7f7';
    request = request.copyWith(headers: headers);
    return request;
  }
}
