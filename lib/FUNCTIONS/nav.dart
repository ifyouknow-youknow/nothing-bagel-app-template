import 'package:flutter/material.dart';

void nav_Push(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nav_Pop(BuildContext context) {
  Navigator.pop(context);
}

void nav_PushAndRemove(BuildContext context, Widget page) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => page),
    (Route<dynamic> route) => false,
  );
}

bool nav_HasRoutes(BuildContext context) {
  return Navigator.canPop(context);
}
