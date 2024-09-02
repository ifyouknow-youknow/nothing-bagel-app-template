import 'package:edm_teachers_app/VIEWS/Events.dart';
import 'package:edm_teachers_app/VIEWS/Timecard.dart';
import 'package:edm_teachers_app/VIEWS/Tracks.dart';
import 'package:flutter/material.dart';
import 'package:edm_teachers_app/COMPONENTS/border_view.dart';
import 'package:edm_teachers_app/COMPONENTS/button_view.dart';
import 'package:edm_teachers_app/COMPONENTS/image_view.dart';
import 'package:edm_teachers_app/COMPONENTS/main_view.dart';
import 'package:edm_teachers_app/COMPONENTS/padding_view.dart';
import 'package:edm_teachers_app/COMPONENTS/text_view.dart';
import 'package:edm_teachers_app/FUNCTIONS/nav.dart';
import 'package:edm_teachers_app/MODELS/DATAMASTER/datamaster.dart';
import 'package:edm_teachers_app/MODELS/firebase.dart';
import 'package:edm_teachers_app/MODELS/screen.dart';
import 'package:edm_teachers_app/VIEWS/Chat.dart';
import 'package:edm_teachers_app/VIEWS/Dashboard.dart';
import 'package:edm_teachers_app/VIEWS/Guide.dart';
import 'package:edm_teachers_app/VIEWS/Login.dart';

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
      Expanded(
        child: Column(
          children: [
            // DASHBOARD
            SizedBox(
              width: double.infinity,
              child: BorderView(
                bottom: true,
                bottomColor: Colors.black54,
                child: ButtonView(
                    child: const PaddingView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: 'Dashboard',
                            size: 24,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 38,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    onPress: () {
                      nav_PushAndRemove(context, Dashboard(dm: widget.dm));
                    }),
              ),
            ),
            //  TIMECARD
            SizedBox(
              width: double.infinity,
              child: BorderView(
                bottom: true,
                bottomColor: Colors.black54,
                child: ButtonView(
                    child: const PaddingView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: 'Timecard',
                            size: 24,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 38,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    onPress: () {
                      nav_PushAndRemove(context, Timecard(dm: widget.dm));
                    }),
              ),
            ),
            //  TRACKS
            SizedBox(
              width: double.infinity,
              child: BorderView(
                bottom: true,
                bottomColor: Colors.black54,
                child: ButtonView(
                    child: const PaddingView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: 'Tracks',
                            size: 24,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 38,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    onPress: () {
                      nav_PushAndRemove(context, Tracks(dm: widget.dm));
                    }),
              ),
            ),
            //  CHAT
            SizedBox(
              width: double.infinity,
              child: BorderView(
                bottom: true,
                bottomColor: Colors.black54,
                child: ButtonView(
                    child: const PaddingView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: 'Chat',
                            size: 24,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 38,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    onPress: () {
                      nav_PushAndRemove(context, Chat(dm: widget.dm));
                    }),
              ),
            ),
            //  EVENTS
            SizedBox(
              width: double.infinity,
              child: BorderView(
                bottom: true,
                bottomColor: Colors.black54,
                child: ButtonView(
                    child: const PaddingView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: 'Events',
                            size: 24,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 38,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    onPress: () {
                      nav_PushAndRemove(context, Events(dm: widget.dm));
                    }),
              ),
            ),
            //  GUIDE
            SizedBox(
              width: double.infinity,
              child: BorderView(
                bottom: true,
                bottomColor: Colors.black54,
                child: ButtonView(
                    child: const PaddingView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: 'Guide',
                            size: 24,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 38,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    onPress: () {
                      nav_PushAndRemove(context, Guide(dm: widget.dm));
                    }),
              ),
            )
          ],
        ),
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
