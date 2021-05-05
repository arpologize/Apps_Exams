class Person {
  Person(
      {this.name,
      this.lastname,
      this.gender,
      this.birthday,
      this.job,
      this.telnum,
      this.address});
  final String name;
  final String lastname;
  final String gender;
  final DateTime birthday;
  final String job;
  final String telnum;
  final String address;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["lastname"] = lastname;
    map["gender"] = gender;
    map["birthday"] = birthday.toString();
    map["job"] = job;
    map["telnum"] = telnum;
    map["address"] = address;
    // Add all other fields
    return map;
  }

  factory Person.fromMap(Map<String, dynamic> map) => Person(
      name: map["name"],
      lastname: map["lastname"],
      gender: map["gender"],
      birthday: DateTime.parse(map["birthday"]),
      job: map["job"],
      telnum: map["telnum"],
      address: map["address"]);
}
