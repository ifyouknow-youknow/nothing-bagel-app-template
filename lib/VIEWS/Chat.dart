import 'package:flutter/material.dart';
import 'package:edmusica_teachers/COMPONENTS/button_view.dart';
import 'package:edmusica_teachers/COMPONENTS/future_view.dart';
import 'package:edmusica_teachers/COMPONENTS/main_view.dart';
import 'package:edmusica_teachers/COMPONENTS/padding_view.dart';
import 'package:edmusica_teachers/COMPONENTS/roundedcorners_view.dart';
import 'package:edmusica_teachers/COMPONENTS/text_view.dart';
import 'package:edmusica_teachers/COMPONENTS/textfield_view.dart';
import 'package:edmusica_teachers/FUNCTIONS/array.dart';
import 'package:edmusica_teachers/FUNCTIONS/colors.dart';
import 'package:edmusica_teachers/FUNCTIONS/date.dart';
import 'package:edmusica_teachers/FUNCTIONS/misc.dart';
import 'package:edmusica_teachers/FUNCTIONS/nav.dart';
import 'package:edmusica_teachers/MODELS/DATAMASTER/datamaster.dart';
import 'package:edmusica_teachers/MODELS/constants.dart';
import 'package:edmusica_teachers/MODELS/firebase.dart';
import 'package:edmusica_teachers/MODELS/screen.dart';
import 'package:edmusica_teachers/VIEWS/Navigation.dart';

class Chat extends StatefulWidget {
  final DataMaster dm;
  const Chat({super.key, required this.dm});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _textController = TextEditingController();

  // FUNCTIONS
  Future<List<Map<String, dynamic>>> _fetchMessages() async {
    var doc = null;
    final stream = firebase_GetAllDocumentsQueriedOrderedLimitedListener(
      '${appName}_Chats',
      [
        {
          'field': 'districtId',
          'operator': '==',
          'value': widget.dm.user['districtId'],
        },
      ],
      'date',
      'desc',
      80,
      (newDoc) {
        // Handle new document addition if needed
        doc = newDoc;
      },
      (updatedDoc) {
        // Handle document updates if needed
      },
      (removedDoc) {
        // Handle document removal if needed
      },
    );

    // Convert the stream to a Future that resolves with the list of documents
    final docs = await stream.first;
    if (doc != null) {
      return sortArrayByProperty([...docs, doc], 'date');
    } else {
      return sortArrayByProperty(docs, 'date');
    }
  }

  void onSend() async {
    setState(() {
      widget.dm.setToggleLoading(true);
    });
    final success =
        await firebase_CreateDocument('${appName}_Chats', randomString(25), {
      'userId': widget.dm.user['id'],
      'message': _textController.text,
      'date': DateTime.now().millisecondsSinceEpoch,
      'nameInitial':
          '${widget.dm.user['firstName']} ${widget.dm.user['lastName'][0]}',
      'districtId': widget.dm.user['districtId']
    });
    setState(() {
      _textController.clear();
      widget.dm.setToggleLoading(false);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchMessages();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainView(dm: widget.dm, children: [
      // TOP
      PaddingView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextView(
              text: "Let's chat!",
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
      // MAIN
      PaddingView(
        child: RoundedCornersView(
          child: Container(
            color: Colors.black12,
            child: const PaddingView(
              child: TextView(
                text:
                    'This chat is restricted to your district. Please keep discussions relevant and use this space for important updates only.',
              ),
            ),
          ),
        ),
      ),
      // CHAT
      Expanded(
        child: PaddingView(
          child: FutureView(
            future: _fetchMessages(),
            childBuilder: (messages) {
              return SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    for (var mess in messages)
                      Row(
                        children: [
                          if (mess['userId'] == widget.dm.user['id'])
                            const Spacer(),
                          Column(
                            crossAxisAlignment:
                                mess['userId'] == widget.dm.user['id']
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              RoundedCornersView(
                                child: Container(
                                  color: mess['userId'] != widget.dm.user['id']
                                      ? hexToColor("#EFF1F3")
                                      : hexToColor("#1985C6"),
                                  child: SizedBox(
                                    width: getWidth(context) * 0.85,
                                    child: PaddingView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                            text: mess['nameInitial'],
                                            weight: FontWeight.w600,
                                            size: 14,
                                            color: mess['userId'] !=
                                                    widget.dm.user['id']
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                          TextView(
                                            text: mess['message'],
                                            size: 16,
                                            color: mess['userId'] !=
                                                    widget.dm.user['id']
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextView(
                                text: formatLongDate(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      mess['date']),
                                ),
                                size: 12,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
            emptyWidget: const Center(
              child: TextView(
                text: 'No messages yet.',
                size: 18,
              ),
            ),
          ),
        ),
      ),
      // BOTTOM
      PaddingView(
        child: Row(
          children: [
            Expanded(
              child: TextfieldView(
                backgroundColor: hexToColor("#F6F8FA"),
                controller: _textController,
                placeholder: 'Type message here..',
                multiline: true,
                maxLines: 8,
                size: 16,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.send_rounded,
                size: 34,
                color: hexToColor("#253677"),
              ),
              onPressed: () {
                onSend();
              },
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ]);
  }
}
