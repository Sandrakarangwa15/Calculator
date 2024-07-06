import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ConnectivityChecker {
  ConnectivityChecker() {
    // Initialize connectivity monitoring
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _handleConnectivityChange(result);
    });
  }

  void _handleConnectivityChange(ConnectivityResult result) {
  switch (result) {
    case ConnectivityResult.none:
      _showToast('No Internet Connection');
      break;
    case ConnectivityResult.mobile:
    case ConnectivityResult.wifi:
      _showToast('Connected to Internet');
      break;
    default:
      _showToast('Unknown Connectivity');
      break;
  }
}

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void initialize(BuildContext context) {}
}
