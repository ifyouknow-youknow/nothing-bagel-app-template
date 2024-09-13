import 'package:flutter/material.dart';
import 'package:edm_teachers_app/COMPONENTS/button_view.dart';
import 'package:edm_teachers_app/COMPONENTS/future_view.dart';
import 'package:edm_teachers_app/COMPONENTS/main_view.dart';
import 'package:edm_teachers_app/COMPONENTS/padding_view.dart';
import 'package:edm_teachers_app/COMPONENTS/roundedcorners_view.dart';
import 'package:edm_teachers_app/COMPONENTS/text_view.dart';
import 'package:edm_teachers_app/COMPONENTS/textfield_view.dart';
import 'package:edm_teachers_app/FUNCTIONS/array.dart';
import 'package:edm_teachers_app/FUNCTIONS/colors.dart';
import 'package:edm_teachers_app/FUNCTIONS/date.dart';
import 'package:edm_teachers_app/FUNCTIONS/misc.dart';
import 'package:edm_teachers_app/FUNCTIONS/nav.dart';
import 'package:edm_teachers_app/MODELS/DATAMASTER/datamaster.dart';
import 'package:edm_teachers_app/MODELS/constants.dart';
import 'package:edm_teachers_app/MODELS/firebase.dart';
import 'package:edm_teachers_app/MODELS/screen.dart';
import 'package:edm_teachers_app/VIEWS/Navigation.dart';

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
    final docs = await firebase_GetAllDocumentsOrderedQueriedLimited(
        '${appName}_Chats',
        [
          {
            'field': 'userId',
            'operator': '==',
            'value': widget.dm.user['id'],
          }
        ],
        'date',
        "desc",
        80);
    return sortArrayByProperty(docs, "date");
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
      'senderId': widget.dm.user['id'],
    });
// GET ALL TOKENS
    if (success) {
      setState(() {
        _textController.clear();
        widget.dm.setToggleLoading(false);
      });
    }
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
            Row(
              children: [
                ButtonView(
                    child: const Icon(
                      Icons.refresh,
                      size: 36,
                    ),
                    onPress: () {
                      setState(() {});
                    }),
                SizedBox(
                  width: 10,
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
            )
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
                    'Chat with your administrator for any questions, requests, or concerns. This chat is only open for professional purposes.',
                wrap: true,
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
                                  color:
                                      mess['senderId'] != widget.dm.user['id']
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
                                            text: 'me',
                                            weight: FontWeight.w600,
                                            size: 14,
                                            color: mess['senderId'] !=
                                                    widget.dm.user['id']
                                                ? Colors.black
                                                : Colors.white,
                                            wrap: true,
                                          ),
                                          TextView(
                                            text: mess['message'],
                                            size: 16,
                                            color: mess['senderId'] !=
                                                    widget.dm.user['id']
                                                ? Colors.black
                                                : Colors.white,
                                            wrap: true,
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
