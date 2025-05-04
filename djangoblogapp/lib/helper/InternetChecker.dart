import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker{
  Future<bool> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;  // No internet connection
    } else {
      return true;   // Internet connection is available
    }
  }
}