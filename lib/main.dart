import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String GEMINI_API_KEY = "";

void main() => runApp(MegaAIApp());

class MegaAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MegaHome(),
    );
  }
}

class MegaHome extends StatefulWidget {
  @override
  _MegaHomeState createState() => _MegaHomeState();
}

class _MegaHomeState extends State<MegaHome> {
  stt.SpeechToText _speech = stt.SpeechToText();
  FlutterTts _tts = FlutterTts();
  String text = "Say Hey MEGA";
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    _tts.setLanguage("en-US");
    _tts.setSpeechRate(0.5);
  }

  void _speak(String msg) async {
    await _tts.speak(msg);
  }

  void _listen() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => isListening = true);
      _speech.listen(onResult: (result) {
        setState(() {
          text = result.recognizedWords;
          if (text.toLowerCase().contains("hey mega") || text.toLowerCase().contains("hey mega ai")) {
            _speak("Hello, I'm MEGA AI, how can I help you?");
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("MEGA AI Ultimate"), backgroundColor: Colors.purple),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic, size: 100, color: isListening ? Colors.green : Colors.white),
            SizedBox(height: 20),
            Text(text, style: TextStyle(color: Colors.white, fontSize: 22), textAlign: TextAlign.center),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _listen,
              child: Text("Tap & Say Hey MEGA"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, padding: EdgeInsets.all(20)),
            )
          ],
        ),
      ),
    );
  }
}
