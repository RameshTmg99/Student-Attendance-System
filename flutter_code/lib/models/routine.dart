import 'package:sas_flutter/models/period.dart';

class Routine {
  List<Day> days;

  Routine({this.days});

  Routine.fromJson(Map<String, dynamic> json) {
    if (json['day'] != null) {
      days = <Day>[];
      json['day'].forEach((v) {
        days.add(new Day.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.days != null) {
      data['day'] = this.days.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Day {
  String name;
  List<Period> periodList;

  Day({this.periodList, this.name});

  Day.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['period'] != null) {
      periodList = <Period>[];
      json['period'].forEach((v) {
        periodList.add(new Period.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.periodList != null) {
      data['period'] = this.periodList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
