//  dependencies:
//   flutter:
//     sdk: flutter
//   audioplayers: ^0.20.1
//  flutter:
//   assets:
//     - assets/sound_effect.mp3
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brick Breaker',
      home: BrickBreakerGame(),
    );
  }
}

class BrickBreakerGame extends StatefulWidget {
  @override
  _BrickBreakerGameState createState() => _BrickBreakerGameState();
}

class _BrickBreakerGameState extends State<BrickBreakerGame> {
  AudioPlayer _audioPlayer = AudioPlayer();

  // Function to play sound
  void _playSound(String sound) async {
    await _audioPlayer.play(AssetSource('assets/$sound'));
  }

  // Example function when a brick is hit
  void _onBrickHit() {
    _playSound('sound_effect.mp3');
    // Additional code to handle brick hit logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brick Breaker'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _onBrickHit,
          child: Text('Hit Brick'),
        ),
      ),
    );
  }
}
