import 'package:flutter/material.dart';
import 'HomePage.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showEmailError = false;
  bool showPasswordError = false;
  bool wrongUserOrPass = false;
  void _login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    setState(() {
      showEmailError = email.isEmpty;
      showPasswordError = password.isEmpty;
      wrongUserOrPass = false;
    });
    print(email.isNotEmpty);
    print(password.isNotEmpty);

    if (email.isNotEmpty && password.isNotEmpty) {
      var url = Uri.parse('http://0.0.0.0:8000/auth/login/');
      print(url);
      void onError(int x) {
        print("+--");
        print(x);
      }
      print(url);
      var response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'email': email, 'password': password}),
          );
      print(response);
      if (response.statusCode == 200) {

        var jsonResponse = json.decode(response.body);
        // Store tokens or navigate to the home page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else{
        setState(() {
          wrongUserOrPass = true;
        });
      }

    } else {
      // Show error message

    }
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'Signify',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    errorText: showEmailError ? 'Email is required' : (wrongUserOrPass ? 'Wrong username or password' : null),

                    errorStyle: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    errorText:
                        showPasswordError ? 'Password is required' : (wrongUserOrPass ? 'Wrong username or password' : null),
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).hintColor,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => _navigateToSignUp(context),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }

