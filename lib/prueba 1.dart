import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// run with: audioplayers: ^0.19.0

/*
void main() {
  runApp(MyApp());
}
*/
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: IconButton(
              icon: Icon(Icons.multitrack_audio),
              onPressed: (){
                final player = AudioCache();
                player.play('audio.mp3');
              }
          ),
        ),
      ),
    );
  }
}