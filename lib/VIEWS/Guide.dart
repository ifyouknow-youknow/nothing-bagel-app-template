import 'package:flutter/material.dart';
import 'package:edmusica_teachers/COMPONENTS/button_view.dart';
import 'package:edmusica_teachers/COMPONENTS/checkbox_view.dart';
import 'package:edmusica_teachers/COMPONENTS/main_view.dart';
import 'package:edmusica_teachers/COMPONENTS/padding_view.dart';
import 'package:edmusica_teachers/COMPONENTS/text_view.dart';
import 'package:edmusica_teachers/FUNCTIONS/nav.dart';
import 'package:edmusica_teachers/MODELS/DATAMASTER/datamaster.dart';
import 'package:edmusica_teachers/MODELS/screen.dart';
import 'package:edmusica_teachers/VIEWS/Navigation.dart';

class Guide extends StatefulWidget {
  final DataMaster dm;
  const Guide({super.key, required this.dm});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
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
              const TextView(
                text: "Teacher's Guide",
                size: 20,
              ),
              ButtonView(
                child: const Icon(
                  Icons.menu,
                  size: 36,
                ),
                onPress: () {
                  nav_Push(context, Navigation(dm: widget.dm));
                },
              ),
            ],
          ),
        ),
        // INFO
        Expanded(
          child: PaddingView(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextView(
                    text:
                        'These steps outline a routine for conducting a successful class. Be sure to follow them in sequence, taking the time to understand each step thoroughly. Proper preparation and timely execution of these steps will ensure a smooth and effective class experience.',
                    size: 16,
                  ),
                  const PaddingView(
                      paddingLeft: 0, paddingRight: 0, child: Divider()),
                  // 1. BACKPACKS
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: '1. Backpacks',
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text:
                                      'Have the students leave their backpacks outside the classroom door.',
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 2. MATERIALS
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: '2. Materials',
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text:
                                      'Students should have their recorder and music book in hand.',
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 3. LINE UP
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: '3. Line Up',
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text: 'Students line up at the door.',
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 4. QUIET ENTRY
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: '4. Quiet Entry',
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text:
                                      'Students must be quiet before entering the classroom.',
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 5. TECHERS SIGNAL
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "5. Teacher's Signal",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text:
                                      "Students wait for the teacher's signal to enter.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 6. SILENT ENTRY
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "6. Silent Entry",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text: "Students enter the classroom quietly.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 7. DESK SETUP
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "7. Desk Setup",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text:
                                      "Students place their music book and recorder on their desk.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 8. ATTENDANCE
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "8. Attendance",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text:
                                      "Students wait quietly while the teacher takes attendance.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 9. REVIEW PREVIOUS LESSON
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "9. Review Previous Lesson",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text:
                                      "Go over the key points and concepts from the previous lesson to ensure understanding and retetion.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 10. START LESSON PART 1
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "10. Start lesson Part 1",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text:
                                      "Introduce new materials and activities.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 11. BREAK
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "11. Break",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text:
                                      "Take a 10-minute break for restroom and water.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 12. CONTINUE LESSOn
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "12. Continue Lesson",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text: "Resume the lesson.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 13. CONCLUDE LESSON
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "13. Conclude Lesson",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text: "Review important points of lesson.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 14. PREPARE FOR DISMISSAL
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "14. Prepare for dismissal",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text:
                                      "Students close their music books and place their recorders in their cases.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 15. PRACTICE REMINDER
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "15. Practice Reminder",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text: "Remind students to practice at home.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 16. CLEAN UP
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "16. Cleanup",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text:
                                      "Students check for and dispose of any trash around their desks.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // 17. QUIET DISMISSAL
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxView(onChange: (value) {}),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "17. Quiet Dismissal",
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                TextView(
                                  text: "Students exit the classroom quietly.",
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
