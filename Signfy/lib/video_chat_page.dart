import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Add this import
import 'package:video_player/video_player.dart';
import 'ChatVideoResult.dart'; // Add this import
import 'package:url_launcher/url_launcher.dart';  // Import the url_launcher package
import 'chat_video.dart';
import 'dart:convert';

class VideoPage2 extends StatefulWidget {
  final String filePath;

  const VideoPage2({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage2> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }
  Future<void> _uploadVideo(String filePath) async {
    final url = Uri.parse('http://192.168.153.51:8000/chat/chat_with_gpt/');
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('video', filePath));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseJson = json.decode(responseBody);
        final recognizedText = responseJson['recognized_text'];
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ResultPage(recognizedText: recognizedText),
        //   ),
        // );
      } else {
        print('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading video: $e');
    }
  }
  Future<void> _fetchAllWords() async {
    final url = Uri.parse('http://192.168.153.51:8000/chat/get_all_words/');
    final response = await http.get(url);

    if (response.statusCode == 200){
      print('in if condition');
      final data = json.decode(response.body);
      List<String> videoUrl = List<String>.from(data['video_paths']);
      print(videoUrl);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatVideo(VideoNames: videoUrl),
        ),
      ).then((_) {
        _resetWords();// Reset words after displaying the sentence

      });
      // await launch(videoUrl);
    }
    // _resetWords();
  }
  Future<void> _resetWords() async {
    final url = Uri.parse('http://192.168.153.51:8000/chat/reset_words/');
    final response = await http.post(url);
    if (response.statusCode != 200) {
      print('Failed to reset words: ${response.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              _uploadVideo(widget.filePath);

            },
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              _fetchAllWords();
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }
}
