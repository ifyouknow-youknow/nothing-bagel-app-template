import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iic_app_template_flutter/COMPONENTS/button_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/future_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/main_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/map_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/padding_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/roundedcorners_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/text_view.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/colors.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/date.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/nav.dart';
import 'package:iic_app_template_flutter/MODELS/DATAMASTER/datamaster.dart';
import 'package:iic_app_template_flutter/MODELS/constants.dart';
import 'package:iic_app_template_flutter/MODELS/firebase.dart';
import 'package:iic_app_template_flutter/MODELS/screen.dart';
import 'package:iic_app_template_flutter/VIEWS/Navigation.dart';

class Dashboard extends StatefulWidget {
  final DataMaster dm;
  const Dashboard({super.key, required this.dm});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // FUNCTIONS
  Future<List<dynamic>> _fetchPunches() async {
    final docs = await firebase_GetAllDocumentsOrderedQueried(
        '${appName}_Punches',
        [
          {'field': 'userId', 'operator': '==', 'value': widget.dm.user['id']}
        ],
        'date',
        'desc');
    return docs;
  }

  void onPunch() async {
    //
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
                              backgroundColor: hexToColor("#8EB8ED"),
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
                        backgroundColor: hexToColor("#8EB8ED"),
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
        )
      ],
    );
  }
}
