import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicBackground {
  static bool isPaused = false;
  static bool isStop = false;
  static AudioCache musicBackground = new AudioCache(prefix: "audios/");
  static AudioPlayer player;

  MusicBackground();

  static void play() {
    isPaused = false;
    _playmusicBackground();
  }

  static Future _playmusicBackground() async {
    player = await musicBackground.play("musicaDeFundo.mp3");
  }

  static void pause() {
    isPaused = true;
    _pauseMusicBackground();
  }

  static Future _pauseMusicBackground() async {
    player?.pause();
  }

  static void stop() {
    isStop = true;
    _stopMusicBackground();
  }

  static void _stopMusicBackground() {
    player?.stop();
  }

  static void loop() {
    isStop = false;
    _loopMusicBackground();
  }

  static Future _loopMusicBackground() async {
    player = await musicBackground.loop("musicaDeFundo.mp3");
  }

  static void decrementVolume() {
    _decrementVolume();
  }

  static void _decrementVolume() {
    player?.setVolume(0.03);
  }

  static void incrementVolume() {
    _incrementVolume();
  }

  static void _incrementVolume() {
    player?.setVolume(1);
  }
}
