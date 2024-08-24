import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iic_app_template_flutter/COMPONENTS/accordion_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/blur_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/button_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/checkbox_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/dropdown_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/fade_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/loading_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/map_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/padding_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/pager_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/roundedcorners_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/scrollable_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/segmented_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/separated_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/split_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/switch_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/text_view.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/colors.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/date.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/misc.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/recorder.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/server.dart';
import 'package:iic_app_template_flutter/MODELS/coco.dart';
import 'package:iic_app_template_flutter/MODELS/constants.dart';
import 'package:iic_app_template_flutter/MODELS/firebase.dart';
import 'package:iic_app_template_flutter/MODELS/screen.dart';
import 'package:record/record.dart';

class PlaygroundView extends StatefulWidget {
  const PlaygroundView({Key? key}) : super(key: key);

  @override
  State<PlaygroundView> createState() => _PlaygroundViewState();
}

class _PlaygroundViewState extends State<PlaygroundView> {
  String _selected = "One";
  Sound recorder = Sound();
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        const Center(
          child: TextView(
            text: "IIC App Template, WELCOME!",
            align: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // -------------------
        ButtonView(
            paddingTop: 8,
            paddingBottom: 8,
            paddingLeft: 14,
            paddingRight: 14,
            radius: 100,
            backgroundColor: hexToColor("#F8F8F8"),
            child: const TextView(text: "PRESS ME"),
            onPress: () async {
              print("HELLO BAGEL");
            })
      ],
    ));
  }
}
