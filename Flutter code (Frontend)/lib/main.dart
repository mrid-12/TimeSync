import 'package:flutter/material.dart';
import 'package:untitled/LoginPages/login.dart';
import 'LoginPages/register.dart';

void main() {
  runApp(const MaterialApp(home: StartScreen()));
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            Column(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40, 105, 40, 55),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: const Image(
                        image: AssetImage('assets/name.jpg'), //assume any image
                        width: 350,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    shadowColor: Colors.red,
                    fixedSize: const Size(200, 57),
                    side: const BorderSide(color: Colors.black87, width: 1.8),
                    elevation: 5,
                    backgroundColor: Colors.indigo[800],
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Noto Serif',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    shadowColor: Colors.red,
                    fixedSize: const Size(200, 57),
                    side: const BorderSide(color: Colors.black87, width: 1.8),
                    elevation: 5,
                    backgroundColor: Colors.indigo[800],
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Noto Serif',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
