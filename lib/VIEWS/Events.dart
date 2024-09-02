import 'package:edm_teachers_app/COMPONENTS/button_view.dart';
import 'package:edm_teachers_app/COMPONENTS/calendar_view.dart';
import 'package:edm_teachers_app/COMPONENTS/future_view.dart';
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
import 'package:edm_teachers_app/VIEWS/EventsByDay.dart';
import 'package:edm_teachers_app/VIEWS/Navigation.dart';
import 'package:flutter/material.dart';

class Events extends StatefulWidget {
  final DataMaster dm;
  const Events({super.key, required this.dm});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  List<DateTime> _eventDates = [];
  // FETCHES
  Future<List<dynamic>> _fetchLatestEvent() async {
    final docs = await firebase_GetAllDocumentsOrderedQueriedLimited(
        '${appName}_Events',
        [
          {
            'field': 'districtId',
            'operator': '==',
            'value': widget.dm.user['districtId']
          },
          {
            'field': 'date',
            'operator': '>=',
            'value': DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)
                .millisecondsSinceEpoch
          }
        ],
        'date',
        'asc',
        1);
    return docs;
  }

  void _fetchAllEvents() async {
    setState(() {
      widget.dm.setToggleLoading(true);
    });
    final thisYear = DateTime.now().year;
    final docs = await firebase_GetAllDocumentsOrderedQueried(
        '${appName}_Events',
        [
          {
            'field': 'districtId',
            'operator': "==",
            'value': widget.dm.user['districtId']
          },
          {
            'field': 'date',
            'operator': '>=',
            'value': DateTime(thisYear, 1, 1).millisecondsSinceEpoch
          },
          {
            'field': 'date',
            'operator': '<=',
            'value': DateTime(thisYear, 12, 31).millisecondsSinceEpoch
          }
        ],
        'date',
        'asc');

    if (docs.isNotEmpty) {
      List<DateTime> dates = docs
          .map<DateTime>(
              (ting) => DateTime.fromMillisecondsSinceEpoch(ting['date']))
          .toList();
      setState(() {
        _eventDates = dates;
      });
    }
    setState(() {
      widget.dm.setToggleLoading(false);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return MainView(
      dm: widget.dm,
      children: [
        // TOP
        PaddingView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: 'Events',
                size: 20,
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
        ),

        //
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: getWidth(context),
                  child: PaddingView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: 'Upcoming Event',
                          size: 20,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FutureView(
                          future: _fetchLatestEvent(),
                          childBuilder: (data) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RoundedCornersView(
                                  topLeft: 100,
                                  topRight: 100,
                                  bottomLeft: 100,
                                  bottomRight: 100,
                                  backgroundColor:
                                      data.first['type'] == 'Concert'
                                          ? hexToColor("#C06FAC")
                                          : Colors.black12,
                                  child: PaddingView(
                                    paddingTop: 8,
                                    paddingBottom: 8,
                                    paddingLeft: 18,
                                    paddingRight: 18,
                                    child: TextView(
                                      text: data.first['type'],
                                      weight: FontWeight.w600,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                TextView(
                                  text: data.first['title'],
                                  size: 20,
                                  weight: FontWeight.w500,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                TextView(
                                  text: data.first['details'],
                                  size: 16,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                TextView(
                                  text: formatLongDate(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          data.first['date'])),
                                  size: 18,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            );
                          },
                          emptyWidget: PaddingView(
                            child: Center(
                              child: TextView(
                                text: 'No upcoming event.',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                // MAIN
                CalendarView(
                  year: DateTime.now().year,
                  thisMonth: true,
                  highlightedDates: _eventDates,
                  selectedColor: hexToColor("#8CC541"),
                  onTapDate: (date) {
                    nav_Push(context, EventsByDay(dm: widget.dm, day: date));
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
