import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/cards/home.dart';
import 'package:quiz_app/views/auth_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget homeWidget = Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: const Text('Quiz app'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),

          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle settings action
              setState(() {
                // Sign out logic here
                // For example, you can use FirebaseAuth to sign out the user
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                );
              });
            },
          ),
        ],
      ),
      body: homeWidget,

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        onTap: (index) {
          setState(() {
            if (index == 0) {
              homeWidget = Home();
            } else {
              homeWidget = Placeholder();
            }
          });
        },
      ),
    );
  }
}
