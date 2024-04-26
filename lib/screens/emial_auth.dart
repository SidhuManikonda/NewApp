import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_json_read/models/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailAuth extends StatefulWidget {
  const EmailAuth({Key? key}) : super(key: key);

  @override
  State<EmailAuth> createState() => _EmailAuthState();
}

class _EmailAuthState extends State<EmailAuth> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isloggedin = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // Check if the user is already logged in
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      // If email and password are stored, try to sign in
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // If sign-in successful, navigate to ProductsScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TableView()),
        );
      } catch (e) {
        print('Error signing in automatically: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Authentication'),
      ),
      body: Column(
        children: [
          _textfield('Email', 'Enter Email', emailcontroller),
          _textfield('Password', 'Enter Password', passwordcontroller),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString('email', emailcontroller.text);
              pref.setString('password', passwordcontroller.text);
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailcontroller.text,
                  password: passwordcontroller.text,
                );
                // If sign-in successful, navigate to ProductsScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TableView()),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(e.toString()),
                ));
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _textfield(String text, String hintText, controller) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: text,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
