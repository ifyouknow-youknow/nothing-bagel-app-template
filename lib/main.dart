import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iic_app_template_flutter/MODELS/firebase.dart';
import 'package:iic_app_template_flutter/VIEWS/playground.dart';
import 'package:iic_app_template_flutter/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  messaging_SetUp();
  await dotenv.load(fileName: "lib/.env");

  runApp(const MaterialApp(
    home: PlaygroundView(),
    // initialRoute: "/",
    // routes: {
    //   // "/": (context) => const PlaygroundView(),
    // },
  ));
}
