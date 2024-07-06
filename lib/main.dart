import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'signin.dart';
import 'signup.dart';
import 'calculatorscreen.dart';
import 'theme.dart';
import 'connectivity_checker.dart';
import 'battery_checker.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyB6ByTWR3L_NWUyhQKdwuiSV1QZy2HWXuQ', 
      appId: '1:385344616624:android:be93fc3def52429ec02375', 
      messagingSenderId: '385344616624', 
      projectId: 'authentication-a0a98'  
    )
  );

  // Initialize theme provider
  final themeProvider = theme(ThemeData.dark()); // Example function to initialize theme provider

  // Optionally, await for theme initialization
  await themeProvider.getTheme(); // Ensure theme is loaded before running the app
  

  runApp(
    ChangeNotifierProvider.value(
      value: themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<theme>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Simple Calculator',
          theme: themeProvider.themeData.copyWith(
            textTheme: TextTheme(
              bodyLarge: GoogleFonts.notoSerif(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: themeProvider.themeData.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              bodyMedium: GoogleFonts.notoSerif(
                fontSize: 14.0,
                color: themeProvider.themeData.brightness == Brightness.dark
                    ? Colors.white70
                    : Colors.black54,
              ),
            ),
          ),
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();
  final BatteryChecker _batteryChecker = BatteryChecker();

  final List<Widget> _screens = [
    const SignInScreen(),
    const SignUpScreen(),
    const CalculatorScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _connectivityChecker.initialize(context);
      _batteryChecker.initialize(context);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<theme>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Simple Calculator',
          style: TextStyle(fontSize: 22.0),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign In'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
              selected: _selectedIndex == 0,
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Sign Up'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
              selected: _selectedIndex == 1,
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Calculator'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
              selected: _selectedIndex == 2,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle settings navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(themeProvider.themeData.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode),
              title: Text(themeProvider.themeData.brightness == Brightness.dark
                  ? 'Light Mode'
                  : 'Dark Mode'),
              onTap: () {
                themeProvider.setTheme(
                  themeProvider.themeData.brightness == Brightness.dark
                      ? ThemeData.light()
                      : ThemeData.dark(),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
