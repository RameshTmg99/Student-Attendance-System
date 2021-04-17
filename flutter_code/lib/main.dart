import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sas_flutter/ui/authCheck.dart';
import 'package:sas_flutter/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: ThemeData(
          primaryColor: Color.fromRGBO(34, 34, 34, 1.0),
          accentColor: Color.fromRGBO(15, 156, 213, 1.0)),
      home: new AuthCheck(),
    ));
  });
}
