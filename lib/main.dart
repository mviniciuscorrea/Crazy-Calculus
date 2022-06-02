import 'package:calculo_maluco/controller/routes.dart';
import 'package:calculo_maluco/view/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crazy Calculus',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Intro(),
    );
  }
}
