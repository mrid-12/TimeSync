import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../HomePages/home.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController pass = TextEditingController();

  Future<void> createUser(
      String username, String password, BuildContext context) async {
    const String createUser = 'http://10.0.0.38:8080/user/createUser';
    const String url = 'http://10.0.2.2:8080/user/createUser';

    final response = await http.post(Uri.parse(url),
        body: {"name": username, "password": password, "isActive": "true"});

    print(response.statusCode);

    if (response.statusCode == 201) {
      final res = jsonDecode(response.body);
      Fluttertoast.showToast(msg: res['message'], fontSize: 18);
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => homePage(UserID: res['id'])));
      }
    } else {
      Fluttertoast.showToast(msg: response.body, fontSize: 18);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              color: const Color.fromARGB(255, 59, 59, 59),
              height: double.infinity,
              width: double.infinity,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(50, 105, 50, 60),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Noto Serif',
                      color: Colors.lightBlue[300],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[300]?.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(color: Colors.white),
                      prefixText: 'Your Username: ',
                      prefixIcon: Icon(Icons.account_box_rounded,
                          size: 30, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[300]?.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: pass,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(color: Colors.white),
                      prefixText: 'Your Password: ',
                      prefixIcon: Icon(Icons.key_rounded,
                          size: 30, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: const Text("Already have an account? Click on me!")),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await createUser(name.text, pass.text, context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fixedSize: const Size(150, 47),
                    side: const BorderSide(color: Colors.black87, width: 2.3),
                    elevation: 5,
                    backgroundColor: Colors.red[900]?.withOpacity(0.7),
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
                Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
