import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sas_flutter/models/attdata.dart';
import 'package:sas_flutter/ui/authCheck.dart';

import 'package:sas_flutter/ui/routinePage.dart';
import 'package:sas_flutter/ui/scanner.dart';
import 'package:sas_flutter/ui/viewattendance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sas_flutter/utils/constants.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  String _userName = '',
      _password = '',
      _name = '',
      _rollno = '',
      _classname = '',
      _percent = '';

  var formatter = DateFormat('MMM dd, yyyy');

  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  var attdata = <AttData>[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    initialize();
  }

  //getting shared pref data and loading in variable
  Future<Null> _getData() async {
    final SharedPreferences prefs = await _preferences;

    String u = prefs.getString("userName");
    String p = prefs.getString("password");
    String n = prefs.getString("name");
    String r = prefs.getString("rollno");
    String c = prefs.getString("classname");

    this.setState(() {
      if (n != null && r != null && c != null) {
        _userName = u;
        _password = p;
        _name = n;
        _rollno = r;
        _classname = c;
      } else {
        _userName = u;
        _password = p;
        _name = 'name';
        _rollno = 'no';
        _classname = 'class';
      }
    });
  }

  Future _validateLogin() async {
    var responseobjectApp = await http.post(Constants.apiLink + "app.php",
        body: {'username': '$_userName', 'password': '$_password'});
    var responseApp;

    try {
      responseApp = json.decode(responseobjectApp.body);
    } catch (e) {
      print(e);
    }

    if (responseApp['myheader']['login'] != "Successfull") {
      _logout();
    } else {
      //update Shared Prefrences
      if (_name == 'name' || _rollno == 'no' || _classname == 'class') {
        _setData("name", responseApp['myheader']['name']);
        _setData("rollno", responseApp['myheader']['rollno'].toString());
        _setData("classname", responseApp['myheader']['classname']);
        await _getData();
      }
    }
  }

  void initialize() async {
    await _getData();
    await _validateLogin();
  }

  void onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    //apiCall();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  //add  value to shared prefs
  Future<Null> _setData(String key, String val) async {
    final SharedPreferences prefs = await _preferences;
    if (this.mounted) {
      setState(() {
        prefs.setString(key, val);
      });
    }
  }

  //last 5 attendance
  Future<Map> _getRecentAtt() async {
    //remove previous data
    attdata.clear();

    if (_userName != '') {
      //send request
      var responseobjectPercent = await http.post(
          Constants.apiLink + "percent.php",
          body: {'username': '$_userName'});
      var responsePercent;
      try {
        responsePercent = json.decode(responseobjectPercent.body);
      } catch (e) {
        return null;
      }

      _percent = responsePercent['myheader']['percent'].toString();

      //add items in map
      for (var i = 0; i < responsePercent.length - 1; i++) {
        attdata.add(AttData(responsePercent["$i"]["date"],
            responsePercent["$i"]["subname"], responsePercent["$i"]["status"]));
      }

      return responsePercent;
    } else
      return null;
  }

  _logout() async {
    final SharedPreferences prefs = await _preferences;
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AuthCheck()),
        ModalRoute.withName("/AuthCheck"));
    print("logout");
  }

  Future<void> _showAlert(BuildContext context) {
    var styleText = TextStyle(fontSize: 18, color: Colors.white);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
              dialogTheme: DialogTheme(
                  backgroundColor: Colors.black87,
                  titleTextStyle:
                      TextStyle(color: Colors.white, fontSize: 20))),
          child: AlertDialog(
            title: Text('Profile'),
            content: Container(
              color: Colors.black87,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.white, size: 28),
                    title: Text(_name, style: styleText),
                    subtitle:
                        Text("Name", style: TextStyle(color: Colors.white70)),
                  ),
                  ListTile(
                    leading: Icon(Icons.verified_user,
                        color: Colors.white, size: 28),
                    title: Text(_userName, style: styleText),
                    subtitle: Text("Username",
                        style: TextStyle(color: Colors.white70)),
                  ),
                  ListTile(
                    leading: Icon(Icons.code, color: Colors.white, size: 28),
                    title: Text(_rollno, style: styleText),
                    subtitle: Text("Roll No",
                        style: TextStyle(color: Colors.white70)),
                  ),
                  ListTile(
                    leading: Icon(Icons.class_, color: Colors.white, size: 28),
                    title: Text(_classname, style: styleText),
                    subtitle: Text("Class Name",
                        style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  cardBuilder(String title, String num, Color color) {
    return Card(
      elevation: 8,
      child: Container(
        color: color,
        width: 90,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                num,
                style: TextStyle(color: Colors.white, fontSize: 44),
              ),
              Text(
                "days",
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff2C3E50),
        body: Center(
            child: FutureBuilder(
          future: _getRecentAtt(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Stack(
              children: <Widget>[
                SmartRefresher(
                  header: BezierCircleHeader(),
                  controller: _refreshController,
                  onRefresh: onRefresh,
                  child: ListView(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AppBar(
                            title: InkWell(
                              onTap: () {
                                _showAlert(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.person),
                                  Text(
                                    _name.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white70,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            centerTitle: true,
                            elevation: 0,
                            actions: <Widget>[logoutButton(context)],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5),
                              Text(
                                formatter.format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          percentView(context, size),
                          SizedBox(height: 25),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                cardBuilder("Last", attdata.length.toString(),
                                    Colors.black87),
                                cardBuilder(
                                    "Present",
                                    attdata
                                        .where((element) =>
                                            element.status[0] == "P")
                                        .length
                                        .toString(),
                                    Colors.green),
                                cardBuilder(
                                    "Absent",
                                    attdata
                                        .where((element) =>
                                            element.status[0] == "A")
                                        .length
                                        .toString(),
                                    Colors.red[700]),
                              ],
                            ),
                          )
                        ],
                      ),
                      //  Container(
                      //   decoration:  BoxDecoration(
                      //     color: Colors.white,
                      //   ),
                      //   padding: EdgeInsets.all(5),
                      //   child:  Column(
                      //     children: <Widget>[
                      //       SizedBox(height: 5),
                      //        Text(
                      //         "RECENT LECTURES",
                      //         style: TextStyle(
                      //             color: Colors.black54,
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //       Expanded(
                      //         child: tileBuilder(),
                      //       ),
                      //       SizedBox(height: 10),
                      //       RaisedButton(
                      //         onPressed: () {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => Viewattendance(
                      //                       username: _userName,
                      //                     )),
                      //           );
                      //         },
                      //         child: Row(
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: <Widget>[
                      //             Icon(Icons.tune),
                      //             SizedBox(
                      //               width: 8,
                      //             ),
                      //             Text("Filter"),
                      //           ],
                      //         ),
                      //         color: Color.fromRGBO(34, 34, 34, 0.8),
                      //         textColor: Colors.white,
                      //       ),
                      //     ],
                      //   ),
                      //   height: MediaQuery.of(context).size.height * 0.6,
                      //   width: MediaQuery.of(context).size.width,
                      // )
                    ],
                  ),
                ),
                Positioned(
                  child: RaisedButton(
                    color: Color.fromRGBO(34, 34, 34, 0.8),
                    textColor: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.schedule),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Routine"),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RoutinePage()),
                      );
                    },
                  ),
                  bottom: 4,
                  left: 4,
                ),
                Positioned(
                  left: size.width / 2.5,
                  bottom: 5,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Viewattendance(
                                  username: _userName,
                                )),
                      );
                    },
                    child: Hero(
                      tag: 'att',
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.view_day),
                          SizedBox(
                            width: 8,
                          ),
                          Text("View All"),
                        ],
                      ),
                    ),
                    color: Color.fromRGBO(34, 34, 34, 0.8),
                    textColor: Colors.white,
                  ),
                )
              ],
            );
          },
        )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black87,
          child: Icon(Icons.camera),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Scanner(
                        username: _userName,
                        password: _password,
                      )),
            );
          },
        ),
      ),
    );
  }

  Tooltip logoutButton(BuildContext context) {
    return Tooltip(
      message: "LOGOUT",
      child: FlatButton(
        child: Icon(
          Icons.close,
          color: Colors.white70,
        ),
        onPressed: () {
          AlertDialog alert = AlertDialog(
            content: Text("Confirm Logout?"),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              MaterialButton(
                onPressed: () => _logout(),
                child: Text("Logout"),
              )
            ],
          );

          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
      ),
    );
  }

  percentView(BuildContext context, Size size) {
    if (_percent == '') return SizedBox();
    int val = int.parse(_percent);
    Color col;
    if (val <= 25) {
      col = Colors.red;
    } else if (val > 25 && val < 75) {
      col = Colors.blue;
    } else if (val >= 75) {
      col = Colors.green;
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          _percent + "%",
          style: TextStyle(
              fontSize: 150,
              fontWeight: FontWeight.w400,
              color: Colors.amberAccent),
        ),
        SizedBox(
          height: size.height * 0.42,
          width: size.height * 0.42,
          child: CircularProgressIndicator(
            backgroundColor: col,

            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
            //  value: _percent == '' ? 0 : double.parse(_percent) / 100,
            // value: 100,

            strokeWidth: 12,
          ),
        ),
      ],
    );
  }

  ListView tileBuilder() {
    return ListView.builder(
        itemCount: attdata.length,
        itemBuilder: (context, index) {
          var att = attdata[index];
          return Card(
            color: att.status[0] == "P" ? Colors.green : Colors.red[500],
            child: ListTile(
              leading: CircleAvatar(
                  child: Text(att.status[0]), backgroundColor: Colors.black87),
              title: Text(att.subname),
              subtitle: Text(formatter.format(DateTime.parse(att.date))),
            ),
          );
        });
  }
}
