import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:edmusica_teachers/MODELS/DATAMASTER/datamaster.dart';
import 'package:edmusica_teachers/MODELS/firebase.dart';
import 'package:edmusica_teachers/VIEWS/Login.dart';
import 'package:edmusica_teachers/VIEWS/playground.dart';
import 'package:edmusica_teachers/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  messaging_SetUp();
  await dotenv.load(fileName: "lib/.env");

  runApp(
    MaterialApp(
      home: Login(dm: DataMaster()),
    ),
    // initialRoute: "/",
    // routes: {
    //   // "/": (context) => const PlaygroundView(),
    // },
  );
}
