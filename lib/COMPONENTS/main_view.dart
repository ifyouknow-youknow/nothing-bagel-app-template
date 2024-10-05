import 'package:flutter/material.dart';
import 'package:nothing_bagel_app_template/COMPONENTS/alert_view.dart';
import 'package:nothing_bagel_app_template/COMPONENTS/bubble_view.dart';
import 'package:nothing_bagel_app_template/COMPONENTS/button_view.dart';
import 'package:nothing_bagel_app_template/COMPONENTS/loading_view.dart';
import 'package:nothing_bagel_app_template/COMPONENTS/text_view.dart';
import 'package:nothing_bagel_app_template/MODELS/DATAMASTER/datamaster.dart';
import 'package:nothing_bagel_app_template/MODELS/screen.dart';

class MainView extends StatefulWidget {
  final DataMaster dm;
  final List<Widget> mobile;
  final List<Widget>? landscape;
  final List<Widget>? tablet;
  final Color backgroundColor;

  const MainView({
    super.key,
    required this.dm,
    required this.mobile,
    this.tablet,
    this.landscape,
    this.backgroundColor = Colors.white,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: getHeight(context),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 46,
                ),
                if (getWidth(context) < 520) ...widget.mobile,
                if (getWidth(context) >= 520 &&
                    getWidth(context) < 720 &&
                    widget.landscape != null)
                  ...?widget.landscape,
                if (getWidth(context) >= 520 && widget.tablet != null)
                  ...?widget.tablet
              ],
            ),

            // ABSOLUTE
            if (widget.dm.toggleBubble) const BubbleView(),
            if (widget.dm.toggleAlert)
              AlertView(
                title: widget.dm.alertTitle,
                message: widget.dm.alertText,
                actions: [
                  ButtonView(
                    child: const TextView(
                      text: 'Close',
                      wrap: false,
                    ),
                    onPress: () {
                      setState(() {
                        widget.dm.setToggleAlert(false);
                      });
                    },
                  ),
                  ...widget.dm.alertButtons
                ],
              ),
            if (widget.dm.toggleLoading) const LoadingView()
          ],
        ),
      ),
    );
  }
}
