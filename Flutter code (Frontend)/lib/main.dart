import 'package:flutter/material.dart';

void main() {
  runApp(const LoginScreen());
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool startButton = true;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 59, 59, 59),
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            /* Animated Align working with Stack, but not working
             with column, because it automatically aligns to the column.
             Column is to place 'Get Started' button below image and then show a
             log in form after animation.*/
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40),
                child: AnimatedAlign(
                  alignment:
                      startButton ? Alignment.center : Alignment.topCenter,
                  duration: const Duration(seconds: 3),
                  curve: Curves.fastOutSlowIn,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: const Image(
                      image: AssetImage('assets/name.jpg'), //assume any image
                      width: 350,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: startButton,
                child: Positioned(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          startButton = false;
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      shadowColor: Colors.red,
                      fixedSize: const Size(150, 47),
                      side: const BorderSide(color: Colors.black87, width: 1.8),
                      elevation: 5,
                      backgroundColor: Colors.indigo[800],
                    ),
                    child: const Text(
                      'Get started',
                      style: TextStyle(
                        fontFamily: 'Noto Serif',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
