import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class ProdcastScreen extends StatefulWidget {
  const ProdcastScreen({super.key});

  @override
  State<ProdcastScreen> createState() => _ProdcastScreenState();
}

class _ProdcastScreenState extends State<ProdcastScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration();
  Duration position = Duration();

  @override
  void initState() {
    super.initState();

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((Duration d) {
      if (mounted) {
        setState(() {
          duration = d;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      if (mounted) {
        setState(() {
          position = p;
        });
      }
    });
  }

  Future<void> _playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(
          'https://drive.google.com/uc?id=1anJWw1V1yqXUfVvCoaFZammVMyRJCeDh'));
    }
  }

  Future<void> _stop() async {
    await _audioPlayer.stop();
  }

  void _seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    _audioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'EATH PODCAST',
              style: GoogleFonts.lato(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Image.asset('assets/Img2.jpg')),
            ),
            Text(
              'about earth from david',
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: position.inSeconds.toDouble(),
              max: duration.inSeconds.toDouble(),
              onChanged: (double value) {
                _seekToSecond(value.toInt());
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${position.inMinutes}:${position.inSeconds.remainder(60)}'),
                  Text(
                      '${duration.inMinutes}:${duration.inSeconds.remainder(60)}'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: IconButton(
                    onPressed: () {
                      _playPause();
                    },
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: IconButton(
                    onPressed: () {
                      _stop();
                    },
                    icon: Icon(Icons.stop, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
