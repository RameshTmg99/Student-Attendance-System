import 'dart:convert';
import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sas_flutter/models/attdata.dart';
import 'package:sas_flutter/utils/constants.dart';

class Viewattendance extends StatefulWidget {
  final username;
  Viewattendance({Key key, @required this.username}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ViewattendanceState(username);
  }
}

class ViewattendanceState extends State {
  String _userName;

  ViewattendanceState(this._userName);

  static var formatter = new DateFormat('yyyy-MM-dd');
  static var formatter2 = new DateFormat('MMM dd, yyyy');

  static final today = DateTime.now();
  static String _startDate =
      formatter.format(DateTime(today.year, today.month, 01));
  static String _endDate = formatter.format(DateTime.now());

  String selected;

  var attdata = <AttData>[];

  Future _selectDate(int id) async {
    DateTime iniDate;
    if (id == 01) {
      iniDate = DateTime.parse(_startDate);
    } else if (id == 02) {
      iniDate = DateTime.parse(_endDate);
    }
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: iniDate,
        firstDate: new DateTime(2018),
        lastDate: new DateTime.now());

    if (picked != null && id == 01) {
      selected = formatter.format(picked);
      setState(() {
        _startDate = selected;
      });
    }

    if (picked != null && id == 02) {
      selected = formatter.format(picked);
      setState(() {
        _endDate = selected;
      });
    }
  }

  //get attendance
  Future<Map> _getAtt() async {
    //remove previous data
    attdata.clear();

    if (_userName != '') {
      //send request
      var responseobjectAtt = await http.post(Constants.apiLink + "detail.php",
          body: {
            'username': '$_userName',
            'sdate': '$_startDate',
            'edate': '$_endDate'
          });
      var responseAtt;
      try {
        print(responseobjectAtt.body);

        responseAtt = json.decode(responseobjectAtt.body);
      } catch (e) {
        print(e.toString());
        return null;
      }

      if (responseAtt['myheader']['response'] == true) {
        //add items in map
        for (var i = 0; i < responseAtt.length - 1; i++) {
          attdata.add(AttData(responseAtt["$i"]["date"],
              responseAtt["$i"]["subname"], responseAtt["$i"]["status"]));
        }
        return responseAtt;
      } else {
        print('test');
        return null;
      }
    } else {
      print('test');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Widget viewBody() {
      if (attdata != null) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: FutureBuilder(
                    future: _getAtt(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //if no data is available
                      if (snapshot.data == null) {
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: 200,
                            ),
                            Center(
                                child: Text(
                              "No Data",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 50),
                            )),
                          ],
                        );
                      } else {
                        return Expanded(
                          child: Container(child: tileBuilder()),
                        );
                      }
                    }),
              ),
              //Bottom widget
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        Text(
                          "Start Date",
                          style: TextStyle(color: Colors.white70),
                        ),
                        new RaisedButton(
                            color: Color.fromRGBO(15, 156, 213, 0.9),
                            onPressed: () {
                              _selectDate(01);
                            },
                            child: new Text(
                                formatter2.format(DateTime.parse(_startDate)),
                                style: TextStyle(color: Colors.white)),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)))
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        Text(
                          "End Date",
                          style: TextStyle(color: Colors.white70),
                        ),
                        new RaisedButton(
                            color: Color.fromRGBO(15, 156, 213, 0.9),
                            onPressed: () {
                              _selectDate(02);
                            },
                            child: new Text(
                                formatter2.format(DateTime.parse(_endDate)),
                                style: TextStyle(color: Colors.white)),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return SizedBox();
      }
    }

    return new Scaffold(
        backgroundColor: Color(0xff2C3E50),
        appBar: AppBar(
          title: Text("My Attendance"),
          elevation: 0,
        ),
        body: viewBody());
  }

  ListView tileBuilder() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: attdata.length,
        itemBuilder: (context, index) {
          var att = attdata[index];
          return Card(
            color: Colors.white.withAlpha(200),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  att.status[0],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor:
                    att.status[0] == "P" ? Colors.green : Colors.red[700],
              ),
              title: Text(att.subname ?? 'N/A'),
              subtitle: Text(formatter2.format(DateTime.parse(att.date))),
            ),
          );
        });
  }
}
