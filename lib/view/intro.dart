import 'package:calculo_maluco/controller/routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9,
              ],
              colors: [
                Colors.blue,
                Colors.blueGrey,
                Colors.blueGrey,
                Colors.blueGrey,
              ],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Lottie.asset(
                  "assets/images/parrot.json",
                  width: 170,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                        "Crazy Calculus is a kids game to learn math operations.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                        "You have 10 chances to get the calculation right in 5 seconds. Good luck",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                GestureDetector(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/start.png",
                          width: 200, height: 180),
                    ),
                    onTap: () => Navigator.pushReplacementNamed(
                        context, Routes.routeGame)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
