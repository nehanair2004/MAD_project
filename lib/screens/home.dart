import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CraveCrush',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.green,
        ),
        scaffoldBackgroundColor: Color(0xFFF4F0BB),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _smokeFreeHours = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadSmokeFreeHours();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(hours: 1), (timer) {
      setState(() {
        _smokeFreeHours++;
        _saveSmokeFreeHours();
      });
    });
  }

  void _resetTimer() {
    setState(() {
      _smokeFreeHours = 0;
      _saveSmokeFreeHours();
    });
  }

  void _loadSmokeFreeHours() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _smokeFreeHours = prefs.getInt('smokeFreeHours') ?? 0;
    });
  }

  void _saveSmokeFreeHours() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('smokeFreeHours', _smokeFreeHours);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('you are doing great'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color accentColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quit Smoke',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF43291F),
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height / 2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Progress Tracker\n\nSmoke-Free Hours: $_smokeFreeHours',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  _resetTimer();
                },
                child: Text('Smoked a Cigarette'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: accentColor,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSnackBar();
        },
        backgroundColor: accentColor,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
