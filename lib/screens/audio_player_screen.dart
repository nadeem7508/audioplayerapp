import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final position = audioProvider.position;
    final duration = audioProvider.duration;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Color(0xFF2B0A5C),
       
        title: Text(
          'AUDIO PLAYER APP',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(color: Colors.white.withOpacity(0.3), height: 1.0),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 51, 4, 92),
              Color.fromARGB(255, 58, 11, 158),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                audioProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              Slider(activeColor: Colors.white,
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble().clamp(0, duration.inSeconds.toDouble()),
                onChanged: (value) {
                  audioProvider.seek(Duration(seconds: value.toInt()));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDuration(position),style: TextStyle( color: Colors.white,),),
                  Text(_formatDuration(duration),style: TextStyle( color: Colors.white,)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous,color: Colors.white,),
                    onPressed: audioProvider.previous,
                  ),
                  IconButton(
                    icon: Icon(audioProvider.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,),
                    onPressed: audioProvider.togglePlayPause,
                    iconSize: 40,
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next,color: Colors.white,),
                    onPressed: audioProvider.next,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text("Volume",style: TextStyle( color: Colors.white,fontSize: 16)),
              Slider(
                min: 0,
                max: 1,
                value: audioProvider.volume,activeColor: Colors.white,
                onChanged: (value) => audioProvider.setVolume(value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    return "${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
}
