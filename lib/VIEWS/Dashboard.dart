import 'package:flutter/material.dart';
import 'package:iic_app_template_flutter/COMPONENTS/button_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/main_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/padding_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/text_view.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/nav.dart';
import 'package:iic_app_template_flutter/MODELS/DATAMASTER/datamaster.dart';
import 'package:iic_app_template_flutter/VIEWS/Navigation.dart';

class Dashboard extends StatefulWidget {
  final DataMaster dm;
  const Dashboard({super.key, required this.dm});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MainView(dm: widget.dm, children: [
      PaddingView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextView(
              text: 'Dashboard',
              size: 18,
              weight: FontWeight.w500,
            ),
            ButtonView(
                child: const Icon(
                  Icons.menu,
                  size: 36,
                ),
                onPress: () {
                  nav_Push(context, Navigation(dm: widget.dm));
                })
          ],
        ),
      )
    ]);
  }
}
