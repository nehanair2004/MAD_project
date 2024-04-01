import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CraveCrush',
      theme: ThemeData(
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.green,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
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
      body: Column(
        children: [
          // Dashboard Container
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF43291F),
              borderRadius: BorderRadius.circular(0.0),
            ),
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height / 2,

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CraveCrush',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rowdies(fontSize: 45.0, color: Colors.white),
                  ),
                  // Image Widget
                  // Wrap Image.asset with Transform to move it upwards
                  Transform.translate(
                    offset: Offset(0, -45), // Adjust the vertical offset to shift the image upwards
                    child: Image.asset(
                      'assets/homepage.png', // Replace with your image path
                      width: 450, // Set image width
                      height: 325, // Set image height
                      fit: BoxFit.contain, // Adjust how the image fits inside the container
                    ),
                  ),
                  // Display Smoke-Free Hours
                  Transform.translate(
                    offset: Offset(0, -100), // Adjust the vertical offset to shift the text upwards
                    child: Text(
                      'Smoke-Free Hours: $_smokeFreeHours',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                  ),
                  // Button to Reset Timer
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
          SizedBox(height: 20),
          // Row for Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 110, // Set the width of the button
                height: 100, // Set the height of the button
                child: _buildIconButton('Wallet', Icons.account_balance_wallet),
              ),
              SizedBox(
                width: 110, // Set the width of the button
                height: 100, // Set the height of the button
                child: _buildIconButton('Health Progress', Icons.favorite),
              ),
              SizedBox(
                width: 110, // Set the width of the button
                height: 100, // Set the height of the button
                child: _buildIconButton('Guide', Icons.book),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Emergency Support Button
          _buildEmergencySupportButton(),
        ],
      ),
    );
  }

  Widget _buildIconButton(String label, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        // Perform action when button is pressed
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10), // Adjust padding as needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26, // Set icon size
          ),
          SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16, // Set text size

            ),
          ),
        ],
      ),
    );
  }


  // Function to Build Emergency Support Button
  Widget _buildEmergencySupportButton() {
    return Container(
      margin: EdgeInsets.only(top: 20), // Adjust top margin to move button below
      child: ElevatedButton(
        onPressed: () {
          // Perform action when emergency support button is pressed
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(30), // Adjust button size here
          shape: CircleBorder(),
          backgroundColor: Colors.red, // Set button background color
        ),
        child: Icon(
          Icons.warning,
          color: Colors.white, // Set icon color
          size: 40, // Set icon size
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
