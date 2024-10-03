import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  bool showUsernameError = false;
  bool showPasswordError = false;
  bool showEmailError = false;
  bool showFirstNameError = false;
  bool showLastNameError = false;

  final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+');
  final RegExp passwordRegExp = RegExp(r'^(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$');
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

  void _signUp(BuildContext context) async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String email = emailController.text.trim();
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();

    setState(() {
      showUsernameError = username.isEmpty;
      showPasswordError =
          password.isEmpty || !passwordRegExp.hasMatch(password);
      showEmailError = email.isEmpty || !emailRegExp.hasMatch(email);
      showFirstNameError = firstName.isEmpty || !nameRegExp.hasMatch(firstName);
      showLastNameError = lastName.isEmpty || !nameRegExp.hasMatch(lastName);
    });

    if (username.isNotEmpty &&
        password.isNotEmpty &&
        email.isNotEmpty &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty) {
      var url = Uri.parse('http://192.168.153.51:8000/auth/register/');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Show error message
      }
    }
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
                'Sign Up',
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
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    errorText:
                        showUsernameError ? 'Username is required' : null,
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
                    errorText: showPasswordError
                        ? 'Password must be at least 8 characters long, contain at least 1 number and 1 special character'
                        : null,
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    errorText: showEmailError
                        ? 'Email must be a valid email address'
                        : null,
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(),
                    errorText: showFirstNameError
                        ? 'First name must not contain numbers or special characters'
                        : null,
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(),
                    errorText: showLastNameError
                        ? 'Last name must not contain numbers or special characters'
                        : null,
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _signUp(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).hintColor,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
