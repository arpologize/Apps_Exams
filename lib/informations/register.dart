import 'package:app_exams/informations/person.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:app_exams/informations/save.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    super.initState();
  }

  var _name = TextEditingController();
  var _lastname = TextEditingController();
  String _gender;
  var _job = TextEditingController();
  var _birth = TextEditingController();
  DateTime _birthday = DateTime.now();
  var _telnum = TextEditingController();
  var _address = TextEditingController();
  //Widget แสดงกรอบอินพุธข้อมูล
  Widget _textField(int index) {
    List<dynamic> fieldInformation = [
      _name,
      _lastname,
      _gender,
      _birthday,
      _job,
      _telnum,
      _address
    ];
    List<String> hintfield = [
      'Firstname',
      'Lastname',
      'Gender',
      '${_birthday.day} / ${_birthday.month} / ${_birthday.year}',
      'Job',
      'Telephone number',
      'Address'
    ];
    return Theme(
        data: new ThemeData(
          primaryColor: Colors.redAccent,
          primaryColorDark: Colors.red,
        ),
        child: TextField(
            enabled: (index == 3) ? false : true,
            controller: (index == 3)
                ? TextEditingController()
                : fieldInformation[index],
            decoration: new InputDecoration(
              hasFloatingPlaceholder: false,
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: new BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  )),
              focusedBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              labelText: hintfield[index],
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
            style: new TextStyle(
                fontSize: 14.0.sp,
                fontFamily: "Poppins",
                color: Colors.black)));
  }

// Widget แสดงปฏิทินเลือกวันเดือนปีที่ต้องการ
  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2022));
    if (picked != null)
      setState(() {
        _birthday = picked;
      });
  }

//Widget แสดงปุ่มตกลงเพื่อบันทึกข้อมูล
  Widget addpeopleButton() {
    return Container(
        width: 40.0.w,
        height: 10.0.h,
        child: ElevatedButton(
          style: ButtonStyle(),
          child: Text(
            "Apply",
            style: TextStyle(fontSize: 18.0.sp),
          ),
          onPressed: () {
            allPeople.add(Person(
                name: _name.text,
                lastname: _lastname.text,
                gender: _gender,
                birthday: _birthday,
                job: _job.text,
                telnum: _telnum.text,
                address: _address.text));
            saveList();
            Navigator.pop(context);
          },
        ));
  }

  Widget genderDropdown() {
    return DropdownButton<String>(
      isExpanded: true,
      focusColor: Colors.white,
      value: _gender,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      icon: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down,
          )),
      items: <String>[
        'Male',
        'Female',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              value,
              style: TextStyle(color: Colors.black, fontSize: 14.0.sp),
            ),
          ),
        );
      }).toList(),
      hint: Align(
        alignment: Alignment.center,
        child: Text(
          "Gender",
          style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      onChanged: (String value) {
        setState(() {
          _gender = value;
        });
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
          child: Container(
              child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  'Personal information',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('Firstname'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 40.0.w,
                            height: 10.0.h,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: new Theme(
                                data: new ThemeData(), child: _textField(0))),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Lastname'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 40.0.w,
                            height: 10.0.h,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: new Theme(
                                data: new ThemeData(), child: _textField(1))),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('Gender'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 40.0.w,
                            // height: 10.0.h,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.0, style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                            ),
                            child: new Theme(
                                data: new ThemeData(),
                                child: genderDropdown())),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text('Birthday'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              selectDate(context);
                            },
                            child: Container(
                                width: 40.0.w,
                                //height: 10.0.h,
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: new Theme(
                                    data: new ThemeData(),
                                    child: _textField(3)))),
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('Job'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 30.0.w,
                            height: 10.0.h,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: new Theme(
                                data: new ThemeData(), child: _textField(4))),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text('Telephone Number'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 50.0.w,
                            height: 10.0.h,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: new Theme(
                                data: new ThemeData(), child: _textField(5))),
                      ),
                    ],
                  ),
                ],
              ),
              Text('Address'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 85.0.w,
                    height: 10.0.h,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child:
                        new Theme(data: new ThemeData(), child: _textField(6))),
              ),
              addpeopleButton()
            ],
          ),
        ),
      ))),
    );
  }
}
