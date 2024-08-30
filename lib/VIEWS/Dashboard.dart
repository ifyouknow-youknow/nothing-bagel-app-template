import 'package:edmusica_teachers/VIEWS/Events.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:edmusica_teachers/COMPONENTS/button_view.dart';
import 'package:edmusica_teachers/COMPONENTS/future_view.dart';
import 'package:edmusica_teachers/COMPONENTS/main_view.dart';
import 'package:edmusica_teachers/COMPONENTS/map_view.dart';
import 'package:edmusica_teachers/COMPONENTS/padding_view.dart';
import 'package:edmusica_teachers/COMPONENTS/roundedcorners_view.dart';
import 'package:edmusica_teachers/COMPONENTS/text_view.dart';
import 'package:edmusica_teachers/FUNCTIONS/colors.dart';
import 'package:edmusica_teachers/FUNCTIONS/date.dart';
import 'package:edmusica_teachers/FUNCTIONS/misc.dart';
import 'package:edmusica_teachers/FUNCTIONS/nav.dart';
import 'package:edmusica_teachers/MODELS/DATAMASTER/datamaster.dart';
import 'package:edmusica_teachers/MODELS/constants.dart';
import 'package:edmusica_teachers/MODELS/firebase.dart';
import 'package:edmusica_teachers/MODELS/screen.dart';
import 'package:edmusica_teachers/VIEWS/Chat.dart';
import 'package:edmusica_teachers/VIEWS/Guide.dart';
import 'package:edmusica_teachers/VIEWS/Navigation.dart';

class Dashboard extends StatefulWidget {
  final DataMaster dm;
  const Dashboard({super.key, required this.dm});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // FUNCTIONS
  Future<List<dynamic>> _fetchPunches() async {
    final docs = await firebase_GetAllDocumentsOrderedQueriedLimited(
        '${appName}_Punches',
        [
          {'field': 'userId', 'operator': '==', 'value': widget.dm.user['id']}
        ],
        'date',
        'desc',
        1);
    print("PUNCHES");
    print(docs);
    return docs;
  }

  Future<List<dynamic>> _fetchLatestChat() async {
    final docs = await firebase_GetAllDocumentsOrderedQueriedLimited(
        '${appName}_Chats',
        [
          {
            'field': 'districtId',
            'operator': '==',
            'value': widget.dm.user['districtId']
          }
        ],
        'date',
        "desc",
        1);
    return docs;
  }

  Future<List<dynamic>> _fetchLatestEvent() async {
    final docs = await firebase_GetAllDocumentsOrderedQueriedLimited(
        '${appName}_Events',
        [
          {
            'field': 'districtId',
            'operator': '==',
            'value': widget.dm.user['districtId']
          }
        ],
        'date',
        "desc",
        1);
    return docs;
  }

  void onPunch() async {
    //
    final docs = await _fetchPunches();
    setState(() {
      widget.dm.setToggleAlert(true);
      widget.dm.setAlertTitle('Time Punch!');
      widget.dm.setAlertText(
          'Are you sure you want to clock ${docs.isEmpty || docs[0]['status'] == 'Out' ? "In" : "Out"}? Your time and location will be recorded.');
      widget.dm.setAlertButtons([
        ButtonView(
            paddingTop: 8,
            paddingBottom: 8,
            paddingLeft: 18,
            paddingRight: 18,
            radius: 100,
            backgroundColor: hexToColor("#3490F3"),
            child: TextView(
              text: 'Proceed',
              color: Colors.white,
              size: 18,
            ),
            onPress: () async {
              setState(() {
                widget.dm.setToggleAlert(false);
                widget.dm.setToggleLoading(true);
              });
              if (docs.isEmpty || docs[0]['status'] == 'Out') {
                // DO IN
                final success = await firebase_CreateDocument(
                    '${appName}_Punches', randomString(25), {
                  'date': DateTime.now().millisecondsSinceEpoch,
                  'location': {
                    'latitude': widget.dm.myLocation.latitude,
                    'longitude': widget.dm.myLocation.longitude
                  },
                  'status': "In",
                  'userId': widget.dm.user['id']
                });
                if (success) {
                  setState(() {
                    widget.dm.setToggleLoading(false);
                  });
                }
              } else {
                final success = await firebase_CreateDocument(
                    '${appName}_Punches', randomString(25), {
                  'date': DateTime.now().millisecondsSinceEpoch,
                  'location': {
                    'latitude': widget.dm.myLocation.latitude,
                    'longitude': widget.dm.myLocation.longitude
                  },
                  'status': "Out",
                  'userId': widget.dm.user['id']
                });
                if (success) {
                  setState(() {
                    widget.dm.setToggleLoading(false);
                  });
                }
              }
            })
      ]);
    });
  }

  @override
  void initState() {
    print("WE MADE IT HERE");
    // TODO: implement initState
    super.initState();
    // auth_SignOut();
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
                text: 'Hello ${widget.dm.user['firstName']}',
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
        ), // -------------

        // TIME CARD WIDGETS
        PaddingView(
          child: FutureView(
            future: _fetchPunches(),
            childBuilder: (punches) {
              return Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Row(
                      children: [
                        Expanded(
                          child: ButtonView(
                            radius: 14,
                            backgroundColor: hexToColor("#F6F8FA"),
                            child: PaddingView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextView(
                                    text: 'Latest Punch',
                                    size: 18,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextView(
                                        text: formatDate(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            punches[0]['date'],
                                          ),
                                        ),
                                        size: 18,
                                        weight: FontWeight.w500,
                                      ),
                                      TextView(
                                        text: formatTime(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            punches[0]['date'],
                                          ),
                                        ),
                                        size: 35,
                                        weight: FontWeight.w700,
                                        spacing: -2,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onPress: () {
                              // GO TO TIMECARD PAGE
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            child: ButtonView(
                              radius: 14,
                              backgroundColor: punches[0]['status'] == 'In'
                                  ? hexToColor("#253677")
                                  : hexToColor("#1985C6"),
                              child: PaddingView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextView(
                                      text: '',
                                      size: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextView(
                                          text:
                                              'Punch ${punches[0]['status'] == 'In' ? 'Out' : 'In'}',
                                          size: 24,
                                          weight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        Icon(
                                          punches[0]['status'] == "In"
                                              ? Icons.upload_rounded
                                              : Icons.download_rounded,
                                          color: Colors.white,
                                          size: 36,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              onPress: () {
                                onPunch(); // GO TO TIMECARD PAGE
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedCornersView(
                    child: MapView(height: 140, isScrolling: false, locations: [
                      LatLng(punches[0]['location']['latitude'],
                          punches[0]['location']['longitude'])
                    ]),
                  )
                ],
              );
            },
            emptyWidget: SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: ButtonView(
                      radius: 14,
                      backgroundColor: hexToColor("#F6F8FA"),
                      child: const PaddingView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                              text: 'Latest Punch',
                              size: 18,
                            ),
                            TextView(
                              text: 'No punches yet.',
                            )
                          ],
                        ),
                      ),
                      onPress: () {
                        // GO TO TIMECARD PAGE
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: ButtonView(
                        radius: 14,
                        backgroundColor: hexToColor("#1985C6"),
                        child: const PaddingView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    text: 'Punch In',
                                    size: 24,
                                    weight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.download_rounded,
                                    color: Colors.white,
                                    size: 36,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        onPress: () {
                          onPunch();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // CHAT & GUIDE
        PaddingView(
            paddingTop: 0,
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                        height: 200,
                        child: ButtonView(
                            radius: 10,
                            backgroundColor: hexToColor("#89F150"),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureView(
                                    future: _fetchLatestChat(),
                                    childBuilder: (data) {
                                      return PaddingView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextView(
                                              text: data.first['nameInitial'],
                                              weight: FontWeight.w600,
                                            ),
                                            TextView(
                                              text:
                                                  '${data.first['message']}${data.first['message'].length > 100 ? "..." : ""}'
                                                      .substring(
                                                          0,
                                                          data.first['message']
                                                                      .length >
                                                                  100
                                                              ? 100
                                                              : data
                                                                  .first[
                                                                      'message']
                                                                  .length),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    emptyWidget: PaddingView(
                                        child: const TextView(
                                            text: 'No chats yet.'))),
                                const PaddingView(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextView(
                                        text: 'open chat',
                                        size: 22,
                                        weight: FontWeight.w600,
                                      ),
                                      Icon(
                                        Icons.north_east,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            onPress: () {
                              nav_Push(context, Chat(dm: widget.dm), () {
                                setState(() {});
                              });
                            }))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: SizedBox(
                  height: 200,
                  child: ButtonView(
                      radius: 10,
                      backgroundColor: hexToColor("#EEF4FA"),
                      child: const PaddingView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: "Check out our teacher's classroom guide.",
                              size: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextView(
                                  text: 'view guide',
                                  size: 22,
                                  weight: FontWeight.w600,
                                ),
                                Icon(
                                  Icons.north_east,
                                  size: 32,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      onPress: () {
                        nav_Push(context, Guide(dm: widget.dm), () {
                          setState(() {});
                        });
                      }),
                ))
              ],
            )),
        // EVENTS
        PaddingView(
            paddingTop: 0,
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 200,
                  child: ButtonView(
                      paddingTop: 10,
                      paddingBottom: 10,
                      paddingLeft: 10,
                      paddingRight: 10,
                      backgroundColor: hexToColor("#8EB8ED"),
                      radius: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                text: 'Upcoming Event',
                                size: 16,
                                weight: FontWeight.w600,
                              ),
                              FutureView(
                                  future: _fetchLatestEvent(),
                                  childBuilder: (data) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          text: data.first['title'],
                                          size: 20,
                                          weight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        TextView(
                                          text: formatDate(DateTime.parse(
                                              data.first['dateStr'])),
                                          weight: FontWeight.w500,
                                          size: 16,
                                        ),
                                        TextView(
                                          text: formatTime(DateTime.parse(
                                              data.first['dateStr'])),
                                          size: 30,
                                          weight: FontWeight.w700,
                                          spacing: -2,
                                        ),
                                      ],
                                    );
                                  },
                                  emptyWidget: PaddingView(
                                      child: Center(
                                    child: TextView(
                                      text: 'No events posted yet.',
                                    ),
                                  )))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextView(
                                text: 'view events',
                                size: 22,
                                weight: FontWeight.w600,
                              ),
                              Icon(
                                Icons.north_east,
                                size: 32,
                              )
                            ],
                          )
                        ],
                      ),
                      onPress: () {
                        nav_Push(context, Events(dm: widget.dm), () {
                          setState(() {});
                        });
                      }),
                ))
              ],
            ))
      ],
    );
  }
}
