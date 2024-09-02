import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:edm_teachers_app/COMPONENTS/accordion_view.dart';
import 'package:edm_teachers_app/COMPONENTS/blur_view.dart';
import 'package:edm_teachers_app/COMPONENTS/button_view.dart';
import 'package:edm_teachers_app/COMPONENTS/calendar_view.dart';
import 'package:edm_teachers_app/COMPONENTS/checkbox_view.dart';
import 'package:edm_teachers_app/COMPONENTS/dropdown_view.dart';
import 'package:edm_teachers_app/COMPONENTS/fade_view.dart';
import 'package:edm_teachers_app/COMPONENTS/loading_view.dart';
import 'package:edm_teachers_app/COMPONENTS/main_view.dart';
import 'package:edm_teachers_app/COMPONENTS/map_view.dart';
import 'package:edm_teachers_app/COMPONENTS/padding_view.dart';
import 'package:edm_teachers_app/COMPONENTS/pager_view.dart';
import 'package:edm_teachers_app/COMPONENTS/qrcode_view.dart';
import 'package:edm_teachers_app/COMPONENTS/roundedcorners_view.dart';
import 'package:edm_teachers_app/COMPONENTS/scrollable_view.dart';
import 'package:edm_teachers_app/COMPONENTS/segmented_view.dart';
import 'package:edm_teachers_app/COMPONENTS/separated_view.dart';
import 'package:edm_teachers_app/COMPONENTS/split_view.dart';
import 'package:edm_teachers_app/COMPONENTS/switch_view.dart';
import 'package:edm_teachers_app/COMPONENTS/text_view.dart';
import 'package:edm_teachers_app/FUNCTIONS/colors.dart';
import 'package:edm_teachers_app/FUNCTIONS/date.dart';
import 'package:edm_teachers_app/FUNCTIONS/media.dart';
import 'package:edm_teachers_app/FUNCTIONS/misc.dart';
import 'package:edm_teachers_app/FUNCTIONS/recorder.dart';
import 'package:edm_teachers_app/FUNCTIONS/server.dart';
import 'package:edm_teachers_app/MODELS/coco.dart';
import 'package:edm_teachers_app/MODELS/constants.dart';
import 'package:edm_teachers_app/MODELS/DATAMASTER/datamaster.dart';
import 'package:edm_teachers_app/MODELS/firebase.dart';
import 'package:edm_teachers_app/MODELS/screen.dart';
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
