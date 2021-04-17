import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sas_flutter/models/period.dart';
import 'package:sas_flutter/models/routine.dart';
import 'dart:convert';

class RoutinePage extends StatefulWidget {
  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  Routine routine;
  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  initPrefs() async {
    preferences = await SharedPreferences.getInstance();
    var resp = preferences.getString('routine');
    if (resp == null) {
      setupDays();
    } else {
      var js = json.decode(resp);
      setState(() {
        routine = Routine.fromJson(js);
      });
    }
  }

  saveRoutine() async {
    var edncodedString = json.encode(routine.toJson());
    await preferences.setString("routine", edncodedString);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Routine"),
        ),
        body: Container(
          child: routine == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : dayBuilder(),
        ),
      ),
    );
  }

  setupDays() {
    setState(() {
      routine = new Routine();
      routine.days = [];
      routine.days.add(new Day(name: 'Sunday', periodList: []));
      routine.days.add(new Day(name: 'Monday', periodList: []));
      routine.days.add(new Day(name: 'Tuesday', periodList: []));
      routine.days.add(new Day(name: 'Wenesday', periodList: []));
      routine.days.add(new Day(name: 'Thursday', periodList: []));
      routine.days.add(new Day(name: 'Friday', periodList: []));
    });
  }

  void addPeriod(List<Period> periodList) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var newPeriod =
              Period(classroom: '', time: '', teacher: '', subject: '');
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SingleChildScrollView(
              child: Container(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Input a Period",
                        textAlign: TextAlign.center,
                      ),
                      TextField(
                        onChanged: (s) => setState(() {
                          newPeriod.classroom = s;
                        }),
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Classroom'),
                      ),
                      TextField(
                        onChanged: (s) => setState(() {
                          newPeriod.time = s;
                        }),
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Time'),
                      ),
                      TextField(
                        onChanged: (s) => setState(() {
                          newPeriod.subject = s;
                        }),
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Subject'),
                      ),
                      TextField(
                        onChanged: (s) => setState(() {
                          newPeriod.teacher = s;
                        }),
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Teacher'),
                      ),
                      SizedBox(
                        width: 320.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (newPeriod.classroom.isNotEmpty &&
                                newPeriod.teacher.isNotEmpty &&
                                newPeriod.time.isNotEmpty &&
                                newPeriod.subject.isNotEmpty) {
                              print("Good");
                              setState(() {
                                periodList.add(newPeriod);
                              });
                              Navigator.pop(context);
                              saveRoutine();
                            } else {
                              print("bad");
                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF1BC0C5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void editPeriod(Period period) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController cl = new TextEditingController()
            ..text = period.classroom;
          TextEditingController ti = new TextEditingController()
            ..text = period.time;
          TextEditingController s = new TextEditingController()
            ..text = period.subject;
          TextEditingController t = new TextEditingController()
            ..text = period.teacher;

          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SingleChildScrollView(
              child: Container(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Edit Period",
                        textAlign: TextAlign.center,
                      ),
                      TextField(
                        controller: cl,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Classroom'),
                      ),
                      TextField(
                        controller: ti,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Time'),
                      ),
                      TextField(
                        controller: s,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Subject'),
                      ),
                      TextField(
                        controller: t,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Teacher'),
                      ),
                      SizedBox(
                        width: 320.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (cl.text.isNotEmpty &&
                                ti.text.isNotEmpty &&
                                t.text.isNotEmpty &&
                                s.text.isNotEmpty) {
                              print("Good");
                              setState(() {
                                period.classroom = cl.text;
                                period.time = ti.text;
                                period.teacher = t.text;
                                period.subject = s.text;
                              });
                              Navigator.pop(context);
                              saveRoutine();
                            } else {
                              print("bad");
                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF1BC0C5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  ListView dayBuilder() {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: 6,
        separatorBuilder: (context, i) {
          return Divider(
            thickness: 1,
          );
        },
        itemBuilder: (context, i) {
          var day = routine.days[i];
          return Card(
            child: ExpansionTile(
              title: Text(
                day.name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                if (day.periodList.isNotEmpty) periodBuilder(day),
                if (day.periodList == null || day.periodList.isEmpty)
                  Text("No Period"),
                MaterialButton(
                  onPressed: () {
                    addPeriod(day.periodList);
                  },
                  child: Row(
                    children: <Widget>[Icon(Icons.add), Text("Add Period")],
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget periodBuilder(Day day) {
    if (day.periodList == null) {
      day.periodList = [];
    }
    return Container(
      height: day.periodList.length > 2
          ? 6 * MediaQuery.of(context).size.height * 0.07
          : day.periodList.length * MediaQuery.of(context).size.height * 0.2,
      child: Scrollbar(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: day.periodList.length,
            itemBuilder: (context, j) {
              var period = day.periodList[j];

              return Card(
                color: Colors.white38,
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Subject: " + period.subject,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "Time: " + period.time,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "Class: " + period.classroom,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "Teacher: " + period.teacher,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.edit,
                              ),
                              onPressed: () {
                                editPeriod(period);
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                              ),
                              onPressed: () {
                                showDialog<Null>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete Period?'),
                                      content: const Text(
                                          'This will delete the selected period. It cannot be undone!'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: const Text('CANCEL'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        FlatButton(
                                          child: const Text('DELETE'),
                                          onPressed: () {
                                            setState(() {
                                              day.periodList.remove(period);
                                            });
                                            Navigator.pop(context);
                                            saveRoutine();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
