import 'package:dio/dio.dart';

class HeaderIntercept extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    print("-----请求之前，需要加一个请求头中的token--");
    options.headers.addAll({
      "xloanDeviceID": "deviceID",
      "xloanPlatform": "ANDROID",
      "xloanServer": "1.0",
    });
    return super.onRequest(options);
  }
}


