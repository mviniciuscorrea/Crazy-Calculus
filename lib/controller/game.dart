import 'package:calculo_maluco/controller/calc.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Game {
  final _calc = Calc();
  final _totalAwnsers = 10;
  final seconds = 5;
  final _audioCache = AudioCache(prefix: "assets/audio/");

  bool finalGame = false;
  bool restart = false;
  bool playingMusic = true;

  int _wrongAwnsers = 0;
  int _rightAwnsers = 0;

  AudioPlayer _audioPlayer = AudioPlayer();

  void _initGame() {
    _rightAwnsers = 0;
    _wrongAwnsers = 0;
    finalGame = false;
    restart = false;
    continueMusic();
  }

  playMusic() async {
    _audioPlayer = await _audioCache.play("music.mp3");

    _audioPlayer.onPlayerCompletion.listen((event) {
      _audioPlayer.stop();
      _audioPlayer.resume();
      playingMusic = true;
    });
  }

  pauseMusic() {
    _audioPlayer.pause();
    playingMusic = false;
  }

  continueMusic() {
    _audioPlayer.resume();
    playingMusic = true;
  }

  List<int> newNumbers() {
    return _calc.raffleNumber();
  }

  int newSimbol() {
    return _calc.raffleSimbolIndex();
  }

  num total({required List<int> numbers, required int simbol}) {
    return _calc.calcTotal(
      indexSimbol: simbol,
      numbers: numbers,
    );
  }

  Future<void> response(
      {required int simbolCalc,
      required int simbolSelect,
      required BuildContext context,
      bool timeOut = false}) async {
    if ((timeOut) || (simbolCalc != simbolSelect)) {
      _wrongAwnsers++;
    } else {
      _rightAwnsers++;
    }

    finalGame = ((_rightAwnsers + _wrongAwnsers) == _totalAwnsers);

    if (finalGame) {
      alertFinalGame(context: context);
    }
  }

  alertFinalGame({required BuildContext context}) {
    restart = true;

    String _text = '';
    String _title = '';
    EMOJI_TYPE _emoji = EMOJI_TYPE.JOYFUL;

    if (_rightAwnsers > _wrongAwnsers) {
      _title = 'Congratulations!';
      _text = 'Yeah! You got $_rightAwnsers answers right';
    } else if (_wrongAwnsers > _rightAwnsers) {
      _title = 'Oh no!';
      _text = 'Not this time, try again';
      _emoji = EMOJI_TYPE.SCARED;
    } else {
      _emoji = EMOJI_TYPE.COOL;
      _title = 'Oooops!';
      _text = 'There was a tie here';
    }

    pauseMusic();

    EmojiAlert(
      alertTitle: Text(_title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent[900],
          )),
      description: Column(
        children: [
          Text(
            _text,
            style: const TextStyle(color: Colors.purple),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      enableMainButton: true,
      cornerRadiusType: CORNER_RADIUS_TYPES.ALL_CORNERS,
      mainButtonColor: Colors.pink,
      mainButtonText: const Text("Play Again"),
      onMainButtonPressed: () async {
        _initGame();
        Navigator.pop(context);
      },
      cancelable: false,
      emojiType: _emoji,
      width: 300,
      height: 300,
      animationType: ANIMATION_TYPE.TRANSITION,
    ).displayAlert(context);
  }
}
