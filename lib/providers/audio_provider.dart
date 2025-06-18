import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  double _volume = 1.0;

  AudioProvider() {
    _init();
  }

  bool get isPlaying => _player.playing;
  Duration get position => _position;
  Duration get duration => _duration;
  double get volume => _volume;

  Future<void> _init() async {
    await _player.setAudioSource(
      ConcatenatingAudioSource(children: [
        AudioSource.asset(
          'assets/audio/sample.mp3',
          tag: MediaItem(id: '1', title: 'Sample 1', artist: 'Bot'),
        ),
        AudioSource.asset(
          'assets/audio/sample2.mp3',
          tag: MediaItem(id: '2', title: 'Sample 2', artist: 'Bot'),
        ),
      ]),
    );

    _player.durationStream.listen((d) {
      _duration = d ?? Duration.zero;
      notifyListeners();
    });

    _player.positionStream.listen((p) {
      _position = p;
      notifyListeners();
    });
  }

  void togglePlayPause() {
    isPlaying ? _player.pause() : _player.play();
    notifyListeners();
  }

  void seek(Duration value) {
    _player.seek(value);
  }

  void next() {
    _player.seekToNext();
  }

  void previous() {
    _player.seekToPrevious();
  }

  void setVolume(double value) {
    _volume = value;
    _player.setVolume(_volume);
    notifyListeners();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
