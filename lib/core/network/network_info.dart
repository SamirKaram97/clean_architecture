import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

abstract class NetworkInfo{
  Future<bool> isNetworkConnectionWork();
}

class NetworkInfoImpl implements NetworkInfo{
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl(this.internetConnectionChecker);
  @override
  Future<bool> isNetworkConnectionWork()async
  {
    return await internetConnectionChecker.hasConnection;
  }
}
