class Period {
  String classroom;
  String time;
  String subject;
  String teacher;

  Period({this.classroom, this.time, this.subject, this.teacher});

  Period.fromJson(Map<String, dynamic> json) {
    classroom = json['classroom'];
    time = json['time'];
    subject = json['subject'];
    teacher = json['teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classroom'] = this.classroom;
    data['time'] = this.time;
    data['subject'] = this.subject;
    data['teacher'] = this.teacher;
    return data;
  }
}