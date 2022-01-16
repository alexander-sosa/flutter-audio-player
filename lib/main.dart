import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final audioName = "queganas.mp3";
  final name = "Etherite - Fuentes de Ortiz";

  AudioPlayer audioPlayer;
  AudioCache audioCache;

  double volume = 1;
  bool paused = false;

  Duration duration = Duration();
  Duration position = Duration();

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.positionHandler = (p) => setState((){
      position = p;
    });
    audioPlayer.durationHandler = (p) => setState((){
      duration = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Music Player"), centerTitle: true,),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createIconButton(Icons.volume_down, Colors.amber[200], () {
                    if (volume > 0){
                      volume -= 0.1;
                      audioPlayer.setVolume(volume);
                    }
                  }),
                  createIconButton(Icons.multitrack_audio, Colors.pink, () {
                    if (!paused)
                      audioCache.play(audioName);
                    else {
                      audioPlayer.resume();
                      paused = false;
                    }
                  }),
                  createIconButton(Icons.pause, Colors.red[300], () {
                    if (!paused) {
                      audioPlayer.pause();
                      paused = true;
                    }
                  }),
                  createIconButton(Icons.stop, Colors.black, () {audioPlayer.stop();}),
                  createIconButton(Icons.volume_up, Colors.amber[700], () {
                    if (volume < 1){
                      volume += 0.1;
                      audioPlayer.setVolume(volume);
                    }
                  }),
                ],
              ),
              Slider(
                  value: position.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble(),
                  onChanged: (double seconds){
                    setState(() {
                      audioPlayer.seek(Duration(seconds: seconds.toInt()));
                    });
                  }
              ),
            ],
          )
        ),
      )
    );
  }

  Widget createIconButton(IconData icon, Color color, VoidCallback onPressed){
    return IconButton(
        icon: Icon(icon),
        iconSize: 60,
        color: color,
        onPressed: onPressed
    );
  }
}