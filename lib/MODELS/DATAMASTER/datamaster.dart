import 'package:flutter/material.dart';

part 'toggles.dart';
part 'strings.dart';
part 'lists.dart';

class DataMaster with _DataMasterToggles, _DataMasterStrings, _DataMasterLists {
  String _userId = ''; // Removed `final` and added an initial value.
  String get userId => _userId;
  void setUserId(String value) => _userId = value;

  DataMaster();
}
