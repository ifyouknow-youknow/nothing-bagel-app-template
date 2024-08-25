import 'package:flutter/material.dart';
import 'package:iic_app_template_flutter/COMPONENTS/button_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/image_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/main_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/padding_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/text_view.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/nav.dart';
import 'package:iic_app_template_flutter/MODELS/DATAMASTER/datamaster.dart';
import 'package:iic_app_template_flutter/MODELS/screen.dart';

class Navigation extends StatefulWidget {
  final DataMaster dm;
  const Navigation({super.key, required this.dm});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return MainView(dm: widget.dm, children: [
      PaddingView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ImageView(
              imagePath: 'assets/edm-logo.png',
              height: 80,
              objectFit: BoxFit.contain,
            ),
            ButtonView(
                child: const Row(
                  children: [
                    TextView(
                      text: 'close',
                      size: 18,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.close,
                      size: 24,
                    )
                  ],
                ),
                onPress: () {
                  nav_Pop(context);
                })
          ],
        ),
      )
    ]);
  }
}
