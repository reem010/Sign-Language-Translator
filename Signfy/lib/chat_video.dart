import 'package:flutter/material.dart';
import 'ChatWithGPTPage.dart';
import 'LoginPage.dart';
import 'TranslateSignToTextPage.dart';
import 'HomePage.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';  // Import the url_launcher package
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class ChatVideo extends StatefulWidget {
  // final String sentence ;
  final List<String> VideoNames;
  const ChatVideo({Key? key, required this.VideoNames}) : super(key: key);
  @override
  _ChatVideoState createState() =>
      _ChatVideoState();
}

class _ChatVideoState extends State<ChatVideo> {
  @override
  void initState() {
    super.initState();
    // Run the translate function immediately
    _translateText(widget.VideoNames);
  }
  final TextEditingController _textController = TextEditingController();
  List<VideoPlayerController> _videoControllers = [];
  int _currentVideoIndex = 0;
  int num = 0;
  int count = 0;
  // late VideoPlayerController _videoController;
  bool _isPlaying = false;
  bool _autoPlayNext = true;
  bool showTextError = false;



  @override
  void dispose() {
    _textController.dispose();
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }
  @override
  void _translateText(List<String> VideoNames) async {
    for (var name in VideoNames){
      VideoPlayerController controller = VideoPlayerController.asset('assets/videos/$name')
        ..initialize().then((_) {
          setState(() {});
        });
      _videoControllers.add(controller);
    }
    setState(() {
      _currentVideoIndex = 0;
      if (_videoControllers.isNotEmpty) {
        _videoControllers[_currentVideoIndex].play();
      }
    });
    // final String text = _textController.text;
    // showTextError = text.isEmpty;
    // if (text.isEmpty) {
    //   showTextError = text.isEmpty;
    //   // ScaffoldMessenger.of(context).showSnackBar(
    //   //   SnackBar(content: Text('Please enter text to translate')),
    //   // );
    //   return;
    // }

    // final response = await http.post(
      // Uri.parse(
      //     'http://192.168.1.6:8000/translation/translate_text_to_sign/'), // Ensure this matches your Django URL
      // headers: {'Content-Type': 'application/json'},
      // body: jsonEncode({'text': text}),
    // );

    // if (response.statusCode == 200) {
    //   print('in if condition');
    //   final data = jsonDecode(response.body);
    //   List<String> videoNames = List<String>.from(data['video_paths']);
    //   // _initializeVideoControllers(videoNames);
    //   for (var name in videoNames){
    //     VideoPlayerController controller = VideoPlayerController.asset('assets/videos/$name')
    //       ..initialize().then((_) {
    //         setState(() {});
    //       });
    //     _videoControllers.add(controller);
    //   }
    //   setState(() {
    //     _currentVideoIndex = 0;
    //     if (_videoControllers.isNotEmpty) {
    //       _videoControllers[_currentVideoIndex].play();
    //     }
    //   });
      // String videoUrl = data['video_paths'];
      // // videoUrl = 'video_20240625232045.mp4' ;
      // print(videoUrl);
      // _videoController = VideoPlayerController.asset('assets/videos/$videoUrl')
      //   ..initialize().then((_) {
      //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      //     setState(() {});
      //   });
      // setState(() {
      //   _videoController.value.isPlaying
      //       ? _videoController.pause()
      //       : _videoController.play();
      // });
      // _isPlaying = true;
    // }
  }
  // void _initializeVideoControllers(List<String> videoNames) {
  //   print(videoNames);
  //   for (var name in videoNames) {
  //     VideoPlayerController controller = VideoPlayerController.asset('assets/videos/Welcome.mp4')
  //       ..initialize().then((_) {
  //         setState(() {});
  //       });
  //     _videoControllers.add(controller);
  //   }
  //   setState(() {
  //     _currentVideoIndex = 0;
  //     if (_videoControllers.isNotEmpty) {
  //       _videoControllers[_currentVideoIndex].play();
  //     }
  //   });
  // }
  void _nextVideo() {
    if (_currentVideoIndex < _videoControllers.length - 1) {
      _videoControllers[_currentVideoIndex].pause();
      _currentVideoIndex++;
      _videoControllers[_currentVideoIndex].play();
      setState(() {});
    }
  }
  void _previousVideo() {
    if (_currentVideoIndex > 0) {
      _videoControllers[_currentVideoIndex].pause();
      _currentVideoIndex--;
      _videoControllers[_currentVideoIndex].play();
      setState(() {});
    }
  }
  bool stat = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Response Video'),
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
                  PopupMenuItem(
                    child: Text('Translate Sign to Text'),
                    value: 'signToText',
                  ),

                  PopupMenuItem(
                    child: Text('Chatbot'),
                    value: 'chat',
                  ),
                  PopupMenuItem(
                    child: Text('Home'),
                    value: 'home_page',
                  ),
                ],
              ).then((value) {
                if (value != null) {
                  switch (value) {
                    case 'signOut':
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      break;
                    case 'signToText':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TranslateSignToTextPage()));
                      break;
                    case 'chat':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatWithGPTPage()));
                      break;
                    case 'home_page':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()));
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () => {
            //     // _translateText(context),
            //     _videoControllers = [],
            //   },
            //   child: Text(
            //     'Translate',
            //     style: TextStyle(fontSize: 18, color: Colors.white),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Theme.of(context)
            //         .hintColor, // Replace with your preferred color
            //     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            //   ),
            // ),
            SizedBox(height: 20),

            // if (_isPlaying)
            //   AspectRatio(
            //     aspectRatio: _videoController.value.aspectRatio,
            //     child: VideoPlayer(_videoController),
            //   ),
            if (_videoControllers.isNotEmpty)
              Column(
                children: [
                  AspectRatio(
                    aspectRatio: _videoControllers[_currentVideoIndex].value.aspectRatio,
                    child: VideoPlayer(_videoControllers[_currentVideoIndex]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: _previousVideo,
                      ),
                      IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: _nextVideo
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
