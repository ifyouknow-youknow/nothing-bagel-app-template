import 'package:flutter/material.dart';
import 'package:iic_app_template_flutter/COMPONENTS/button_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/image_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/main_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/padding_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/text_view.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/nav.dart';
import 'package:iic_app_template_flutter/MODELS/DATAMASTER/datamaster.dart';
import 'package:iic_app_template_flutter/MODELS/firebase.dart';
import 'package:iic_app_template_flutter/MODELS/screen.dart';
import 'package:iic_app_template_flutter/VIEWS/Login.dart';

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
      ),
      const Expanded(
        child: Column(),
      ),
      PaddingView(
        child: ButtonView(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 22,
                ),
                SizedBox(
                  width: 10,
                ),
                TextView(
                  text: 'sign out',
                  color: Colors.red,
                  size: 18,
                )
              ],
            ),
            onPress: () async {
              final success = await auth_SignOut();
              if (success) {
                nav_PushAndRemove(context, Login(dm: widget.dm));
              }
            }),
      ),
      const Divider(
        color: Colors.black26,
      ),
      PaddingView(
        child: ButtonView(
          child: const TextView(
            text: 'delete account',
            color: Colors.black54,
          ),
          onPress: () {},
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ]);
  }
}
