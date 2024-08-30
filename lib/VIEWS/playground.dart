import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:edmusica_teachers/COMPONENTS/accordion_view.dart';
import 'package:edmusica_teachers/COMPONENTS/blur_view.dart';
import 'package:edmusica_teachers/COMPONENTS/button_view.dart';
import 'package:edmusica_teachers/COMPONENTS/calendar_view.dart';
import 'package:edmusica_teachers/COMPONENTS/checkbox_view.dart';
import 'package:edmusica_teachers/COMPONENTS/dropdown_view.dart';
import 'package:edmusica_teachers/COMPONENTS/fade_view.dart';
import 'package:edmusica_teachers/COMPONENTS/loading_view.dart';
import 'package:edmusica_teachers/COMPONENTS/main_view.dart';
import 'package:edmusica_teachers/COMPONENTS/map_view.dart';
import 'package:edmusica_teachers/COMPONENTS/padding_view.dart';
import 'package:edmusica_teachers/COMPONENTS/pager_view.dart';
import 'package:edmusica_teachers/COMPONENTS/qrcode_view.dart';
import 'package:edmusica_teachers/COMPONENTS/roundedcorners_view.dart';
import 'package:edmusica_teachers/COMPONENTS/scrollable_view.dart';
import 'package:edmusica_teachers/COMPONENTS/segmented_view.dart';
import 'package:edmusica_teachers/COMPONENTS/separated_view.dart';
import 'package:edmusica_teachers/COMPONENTS/split_view.dart';
import 'package:edmusica_teachers/COMPONENTS/switch_view.dart';
import 'package:edmusica_teachers/COMPONENTS/text_view.dart';
import 'package:edmusica_teachers/FUNCTIONS/colors.dart';
import 'package:edmusica_teachers/FUNCTIONS/date.dart';
import 'package:edmusica_teachers/FUNCTIONS/media.dart';
import 'package:edmusica_teachers/FUNCTIONS/misc.dart';
import 'package:edmusica_teachers/FUNCTIONS/recorder.dart';
import 'package:edmusica_teachers/FUNCTIONS/server.dart';
import 'package:edmusica_teachers/MODELS/coco.dart';
import 'package:edmusica_teachers/MODELS/constants.dart';
import 'package:edmusica_teachers/MODELS/DATAMASTER/datamaster.dart';
import 'package:edmusica_teachers/MODELS/firebase.dart';
import 'package:edmusica_teachers/MODELS/screen.dart';
import 'package:record/record.dart';

class PlaygroundView extends StatefulWidget {
  final DataMaster dm;
  const PlaygroundView({super.key, required this.dm});

  @override
  State<PlaygroundView> createState() => _PlaygroundViewState();
}

class _PlaygroundViewState extends State<PlaygroundView> {
  @override
  Widget build(BuildContext context) {
    return MainView(dm: widget.dm, children: [
      const PaddingView(
        child: Center(
          child: TextView(
            text: "Hello! This is the IIC Flutter App Template",
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      ButtonView(
          child: const TextView(
            text: 'Press Me',
          ),
          onPress: () {
            function_ScanQRCode(context);
          }),
      const SizedBox(
        height: 10,
      ),
    ]);
  }
}
