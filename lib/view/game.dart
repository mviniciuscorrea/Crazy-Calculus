import 'dart:async';
import 'package:calculo_maluco/controller/game.dart' as game_control;
import 'package:calculo_maluco/controller/routes.dart';
import 'package:calculo_maluco/widget/menu.dart';
import 'package:flutter/material.dart';
import 'package:calculo_maluco/style.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final _game = game_control.Game();
  final _menu = Menu();
  final _style = Style();

  double _scale = 0;
  int _seconds = 0;
  bool _disableTimer = false;
  IconData _iconAudio = Icons.volume_up;

  List<int> _numbers = [];
  int _simbolCalc = -1;
  num _total = 0;

  @override
  void initState() {
    initGame();
    super.initState();
  }

  void initGame() {
    _game.playMusic();
    _scale = _style.scaleTimerSmall();
    _newCalc();
    _timerProcess();
  }

  void _newCalc() {
    _disableTimer = false;
    _numbers = _game.newNumbers();
    _simbolCalc = _game.newSimbol();
    _total = _game.total(numbers: _numbers, simbol: _simbolCalc);

    if (_total.runtimeType != int) {
      _newCalc();
    }

    setState(() {
      _seconds = _game.seconds;
    });
  }

  void _timerProcess() {
    Timer.periodic(const Duration(seconds: 1), (_timer) {
      if (_disableTimer) {
        return _timer.cancel();
      }

      if (!_game.finalGame) {
        setState(() {
          _scale = _scale == _style.scaleTimerSmall()
              ? _style.scaleTimerGigant()
              : _style.scaleTimerSmall();

          _seconds--;
        });

        if (_seconds <= 0) {
          _game
              .response(
                  context: context,
                  simbolCalc: -1,
                  simbolSelect: -1,
                  timeOut: true)
              .then((_) {
            _newCalc();
            _seconds = _game.seconds;
          });
        }
      } else if (_game.restart) {
        setState(() {
          _seconds = _game.seconds;
        });

        _game.restart = false;
      }
    });
  }

  _goToIntro() {
    _disableTimer = true;
    _game.pauseMusic();
    Navigator.pushReplacementNamed(context, Routes.routeIntro);
  }

  _muteMusic() {
    _game.playingMusic ? _game.pauseMusic() : _game.continueMusic();

    setState(() {
      _iconAudio = _game.playingMusic ? Icons.volume_up : Icons.volume_mute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/wallpaper.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _goToIntro,
                child: const Icon(Icons.arrow_back, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  primary: Colors.purple,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  child: Icon(_iconAudio, color: Colors.red),
                  onTap: _muteMusic,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_numbers[0].toString(), style: _style.numbers()),
                      _style.sizedBox(),
                      Text('?', style: _style.simbol()),
                      _style.sizedBox(),
                      Text(_numbers[1].toString(), style: _style.numbers()),
                      _style.sizedBox(),
                      Text('=', style: _style.numbers()),
                      _style.sizedBox(),
                      Text(_total.toString(), style: _style.numbers())
                    ],
                  ),
                ),
              ),
              Flexible(
                child: GridView.count(
                  shrinkWrap: true,
                  childAspectRatio: 1.20,
                  padding: const EdgeInsets.all(16),
                  crossAxisCount: 4,
                  crossAxisSpacing: 15,
                  children: _menu.menus.map((m) {
                    return GestureDetector(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(m.img, width: 28),
                                ])),
                        onTap: () {
                          _game
                              .response(
                            simbolCalc: _simbolCalc,
                            simbolSelect: m.index,
                            context: context,
                          )
                              .then((_) {
                            _newCalc();
                          });
                        });
                  }).toList(),
                ),
              )
            ],
          ),
        ],
      ),
      floatingActionButton: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 1000),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.pink[600],
          onPressed: () {},
          label: Text(_seconds.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 22,
              )),
        ),
      ),
    );
  }
}
