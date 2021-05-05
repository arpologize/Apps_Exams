class Project {
  Project({
    this.projectName,
    this.projectDid,
    this.projectDate,
  });

  String projectName;
  bool projectDid;
  DateTime projectDate;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["projectName"] = projectName;
    map["projectDid"] = projectDid.toString();
    map["projectDate"] = projectDate.toString();
    // Add all other fields
    return map;
  }

  factory Project.fromMap(Map<String, dynamic> map) => Project(
      projectName: map["projectName"],
      projectDid: (map["projectDid"] == 'true') ? true : false,
      projectDate: DateTime.parse(map["projectDate"]));
}
