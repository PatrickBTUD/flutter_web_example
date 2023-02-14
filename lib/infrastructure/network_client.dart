import 'package:dio/dio.dart';

const int _timeoutInSeconds = 30;
const int _networkTimeOut = _timeoutInSeconds * 100;

// this is bad don't do it like this
// you can get an API Key here: https://newsapi.org/
const String apiKey = 'ADD_YOUR_NEWS_API_KEY_HERE';

class NetworkClient {
  late Dio client;

  NetworkClient() {
    client = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2/',
        connectTimeout: _networkTimeOut,
        receiveTimeout: _networkTimeOut,
        sendTimeout: _networkTimeOut,
        headers: {
          'Authorization': apiKey,
        },
      ),
    );
  }
}