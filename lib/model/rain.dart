class Rain {
  double? dOneHour;

  Rain({this.dOneHour});

  Rain.fromJson(Map<String, dynamic> json) {
    dOneHour = json['dOneHour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dOneHour'] = this.dOneHour;
    return data;
  }
}