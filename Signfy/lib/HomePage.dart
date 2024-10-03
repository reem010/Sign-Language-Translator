import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'TranslateSignToTextPage.dart';
import 'TranslateTextToSignPage.dart';
import 'ChatWithGPTPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signify'),
        backgroundColor: Colors.teal,
        actions:[
          IconButton(
            icon: Text(
              '☰',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              // Show a menu or perform another action
              final RenderBox overlay =
              Overlay.of(context).context.findRenderObject() as RenderBox;
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  overlay.size.width - 100, // Adjust the X position
                  56.0, // This should match the height of your AppBar
                  0.0,
                  0.0,
                ),
                items: [
                  PopupMenuItem(
                    child: Text('Sign Out'),
                    value: 'signOut',
                  ),
                ],
              ).then((value) {
                if (value != null) {
                  switch (value) {
                    case 'signOut':
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      break;
                    default:
                  }
                }
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TranslateSignToTextPage()));
                },
                child: Text(
                  'Translate Sign to Text',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).hintColor,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TranslateTextToSignPage()));
                },
                child: Text(
                  'Translate Text to Sign',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor : Theme.of(context).hintColor,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatWithGPTPage()));
                },
                child: Text(
                  'Chatbot',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).hintColor,
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