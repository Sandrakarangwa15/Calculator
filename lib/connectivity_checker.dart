import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityChecker {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult? _previousResult;

  void initialize(BuildContext context) {
    _checkInitialConnectivity(context);
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (_previousResult != result) {
        _showConnectivityMessage(result, context);
        _previousResult = result;
      }
    });
  }

  void _checkInitialConnectivity(BuildContext context) async {
    try {
      ConnectivityResult result = await _connectivity.checkConnectivity();
      _showConnectivityMessage(result, context);
      _previousResult = result;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to check connectivity: $e")),
      );
    }
  }

  void _showConnectivityMessage(ConnectivityResult result, BuildContext context) {
    String message;
    if (result == ConnectivityResult.mobile) {
      message = "Connected to mobile network";
    } else if (result == ConnectivityResult.wifi) {
      message = "Connected to WiFi";
    } else {
      message = "No internet connection";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

// Example usage in a Flutter app

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connectivity Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();

  @override
  void initState() {
    super.initState();
    _connectivityChecker.initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connectivity Checker'),
      ),
      body: Center(
        child: Text('Check your connectivity status.'),
      ),
    );
  }
}
