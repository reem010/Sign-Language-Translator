import 'package:flutter/material.dart';
// import 'LoginPage.dart';
// import 'TranslateSignToTextPage.dart';
// import 'TranslateTextToSignPage.dart';
import 'ChatWithGPTPage.dart';
// import 'HomePage.dart';

class SendYourSignsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Your Signs'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Sign Out'),
                  value: 'Sign Out',
                ),
                PopupMenuItem(
                  child: Text('Translate Sign to Text'),
                  value: 'sign_to_text',
                ),
                PopupMenuItem(
                  child: Text('Translate Text to Sign'),
                  value: 'text_to_sign',
                ),
                PopupMenuItem(
                  child: Text('Chat with GPT'),
                  value: 'chat_with_gpt',
                ),
                PopupMenuItem(
                  child: Text('Home'),
                  value: 'home_page',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'home') {
                Navigator.pop(context);
              } else {
                // Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  //   builder: (context) {
                  //     if (value == 'Sign Out') {
                  //       return LoginPage();
                  //     }
                  //     if (value == 'sign_to_text') {
                  //       return TranslateSignToTextPage();
                  //     } else if (value == 'text_to_sign') {
                  //       return TranslateTextToSignPage();
                  //     } else if (value == 'chat_with_gpt') {
                  //       return ChatWithGPTPage();
                  //     } else if (value == 'home_page') {
                  //       return HomePage();
                  //     }
                  //     // Return a placeholder widget
                  //     return Container();
                  //   },
                  // ),
                // );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Implement send functionality
          },
          child: Text(
            'Send',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).hintColor,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
        ),
      ),
    );
  }
}
