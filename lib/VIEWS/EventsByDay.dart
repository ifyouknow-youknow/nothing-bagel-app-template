import 'package:edm_teachers_app/COMPONENTS/border_view.dart';
import 'package:edm_teachers_app/COMPONENTS/button_view.dart';
import 'package:edm_teachers_app/COMPONENTS/main_view.dart';
import 'package:edm_teachers_app/COMPONENTS/padding_view.dart';
import 'package:edm_teachers_app/COMPONENTS/roundedcorners_view.dart';
import 'package:edm_teachers_app/COMPONENTS/text_view.dart';
import 'package:edm_teachers_app/FUNCTIONS/colors.dart';
import 'package:edm_teachers_app/FUNCTIONS/date.dart';
import 'package:edm_teachers_app/FUNCTIONS/nav.dart';
import 'package:edm_teachers_app/MODELS/DATAMASTER/datamaster.dart';
import 'package:edm_teachers_app/MODELS/constants.dart';
import 'package:edm_teachers_app/MODELS/firebase.dart';
import 'package:edm_teachers_app/MODELS/screen.dart';
import 'package:flutter/material.dart';

class EventsByDay extends StatefulWidget {
  final DataMaster dm;
  final DateTime day;
  const EventsByDay({super.key, required this.dm, required this.day});

  @override
  State<EventsByDay> createState() => _EventsByDayState();
}

class _EventsByDayState extends State<EventsByDay> {
  List<dynamic> _events = [];

  void _fetchEventsByDay() async {
    setState(() {
      widget.dm.setToggleLoading(true);
    });
    final docs = await firebase_GetAllDocumentsOrderedQueried(
        '${appName}_Events',
        [
          {
            'field': 'date',
            'operator': '>=',
            'value': DateTime(
                    widget.day.year, widget.day.month, widget.day.day, 0, 0, 0)
                .millisecondsSinceEpoch
          },
          {
            'field': 'date',
            'operator': '<=',
            'value': DateTime(widget.day.year, widget.day.month, widget.day.day,
                    23, 59, 59)
                .millisecondsSinceEpoch
          },
        ],
        'date',
        "asc");
    setState(() {
      widget.dm.setToggleLoading(false);
      _events = docs;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchEventsByDay();
  }

  @override
  Widget build(BuildContext context) {
    return MainView(dm: widget.dm, children: [
      // TOP
      PaddingView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chevron_left,
                    size: 28,
                    color: hexToColor("#253677"),
                  ),
                  TextView(
                    text: 'back',
                    color: hexToColor("#253677"),
                    size: 18,
                  ),
                ],
              ),
              onPress: () {
                nav_Pop(context);
              },
            ),
            TextView(
              text: formatDate(widget.day),
              size: 22,
              weight: FontWeight.w600,
            )
          ],
        ),
      ),
      // MAIN
      SingleChildScrollView(
        child: SizedBox(
          width: getWidth(context),
          child: PaddingView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._events.map((eve) {
                  return BorderView(
                    bottom: true,
                    bottomColor: Colors.black54,
                    child: PaddingView(
                      paddingLeft: 0,
                      paddingRight: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RoundedCornersView(
                            topLeft: 100,
                            topRight: 100,
                            bottomLeft: 100,
                            bottomRight: 100,
                            backgroundColor: eve['type'] == 'Concert'
                                ? hexToColor("#C06FAC")
                                : Colors.black12,
                            child: PaddingView(
                              paddingTop: 8,
                              paddingBottom: 8,
                              paddingLeft: 18,
                              paddingRight: 18,
                              child: TextView(
                                text: eve['type'],
                                color: Colors.white,
                                size: 18,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextView(
                            text: eve['title'],
                            size: 22,
                            weight: FontWeight.w600,
                          ),
                          TextView(
                            text: eve['details'],
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
