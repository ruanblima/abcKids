import 'package:audioplayers/audio_cache.dart';

class MusicaFundo {
  static bool isPaused = false;
  static AudioCache musicaFundo = new AudioCache(prefix: "audios/");

  MusicaFundo();

  static void pause() {
    isPaused = true;
    _pauseMusicaFundo();
  }

  static Future _pauseMusicaFundo() async {
    await musicaFundo.fixedPlayer.pause();
  }

  void pararMusicaFundo() async {
    await musicaFundo.fixedPlayer.stop();
  }

  static void loop() {
    _loopMusicaFundo();
  }

  static Future _loopMusicaFundo() async {
    await musicaFundo.loop("musicaDeFundo.mp3");
  }

  static void play() {
    _playMusicaFundo();
  }

  static Future _playMusicaFundo() async {
    await musicaFundo.play("musicaDeFundo.mp3");
  }

  static void diminuirVolume() {
    _diminuirSom();
  }

  static Future _diminuirSom() async {
    await musicaFundo.fixedPlayer.setVolume(0);
  }
}
