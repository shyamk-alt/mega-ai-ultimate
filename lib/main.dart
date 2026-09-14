import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:torch_light/torch_light.dart';
import 'package:device_apps/device_apps.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; import 'dart:math'; import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http; import 'dart:convert';

// YOUR GEMINI KEY - PASTED FROM YOUR PHOTO
const String GEMINI_API_KEY = "AIzaSyAb8RN6JRaP6BId6QY3ZelwK1fABnKbMh5WNIkwEB1s5vu6i4Ew";

void main() => runApp(MaterialApp(debugShowCheckedModeBanner:false, home: Mega()));
class Mega extends StatefulWidget { @override State<Mega> createState()=>_MegaState();}
class _MegaState extends State<Mega> with TickerProviderStateMixin{
  final SpeechToText _speech=SpeechToText(); final FlutterTts _tts=FlutterTts();
  bool isActive=false, isListening=false, isEditing=false, isThinking=false;
  String status="MEGA AI is OFF"; late AnimationController _orb,_wave,_pulse;
  File? editImage; Uint8List? editedBytes; double brightness=0;
  @override void initState(){super.initState(); _orb=AnimationController(vsync:this,duration:Duration(seconds:3))..repeat(); _wave=AnimationController(vsync:this,duration:Duration(milliseconds:700))..repeat(reverse:true); _pulse=AnimationController(vsync:this,duration:Duration(seconds:1))..repeat(reverse:true);}
  Future<void> toggle() async{if(!isActive){await [Permission.microphone,Permission.speech].request(); await _speech.initialize(); await _tts.setLanguage("en-US"); await _tts.setSpeechRate(0.48); setState(()=>isActive=true); speak("Mega Ultimate Activated for Shyam. One button is ON. Say open Instagram or ask anything.");} else {await _speech.stop(); await _tts.stop(); setState(()=>{isActive=false,isListening=false,status="MEGA AI is OFF"});}}
  Future<void> speak(String m) async{setState(()=>status=m); await _tts.speak(m);}
  void startVoice() async{if(!isActive) return; setState(()=>isListening=true); _speech.listen(onResult:(r){if(r.finalResult) stopVoice(r.recognizedWords
