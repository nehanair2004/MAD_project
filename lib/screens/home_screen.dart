import 'dart:async';
import 'package:trial/screens/guide_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trial/screens/login_screen.dart'; // Import your login screen
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    _timer = Timer.periodic(const Duration(hours: 1), (timer) {
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

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()), // Navigate to your login page
    );
  }

  void _navigateToGuidePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewsHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color accentColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quit Smoke',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dashboard Container
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF43291F),
                borderRadius: BorderRadius.circular(0.0),
              ),
              margin: const EdgeInsets.all(0.0),
              padding: const EdgeInsets.all(0.0),
              //height: MediaQuery.of(context).size.height / 2,
              height: 450,

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
                      offset: const Offset(0, -40), // Adjust the vertical offset to shift the image upwards
                      child: Image.asset(
                        'assets/homepage.png', // Replace with your image path
                        width: 400, // Set image width
                        height: 280, // Set image height
                        fit: BoxFit.contain, // Adjust how the image fits inside the container
                      ),
                    ),
                    // Display Smoke-Free Hours
                    Transform.translate(
                      offset: const Offset(0, -100), // Adjust the vertical offset to shift the text upwards
                      child: Text(
                        'Smoke-Free Hours: $_smokeFreeHours',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ),
                    // Button to Reset Timer
                    Container(
                      margin: const EdgeInsets.only(top: 0), // Adjust top margin to move the button upwards
                      child: SizedBox(
                        height: 20, // Set the height of the container
                        child: ElevatedButton(
                          onPressed: () {
                            _resetTimer();
                          },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 30),shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Adjust button border radius
                          ),
                        ),
                        child: const Text(
                          'Smoked a Cigarette',
                          style: TextStyle(fontSize: 16, color: Colors.white), // Adjust text style
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
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
            const SizedBox(height: 20),
            // Emergency Support Button
            _buildEmergencySupportButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(String label, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        if (label == 'Guide') {
          _navigateToGuidePage(); // Navigate to the guide page
        } else {
          // Perform action when other buttons are pressed
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10), // Adjust padding as needed
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
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
      margin: const EdgeInsets.only(top: 20), // Adjust top margin to move button below
      child: ElevatedButton(
        onPressed: () {
          // Perform action when emergency support button is pressed
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(30), // Adjust button size here
          shape: const CircleBorder(),
          backgroundColor: Colors.red, // Set button background color
        ),
        child: const Icon(
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