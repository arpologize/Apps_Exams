import 'package:app_exams/informations/informations.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:app_exams/informations/save.dart';

//หน้านี้แสดงรายละเอียดแต่ละบุคคลโดยมี Stateless เอาไว้แสดงข้อมูลอย่างเดียว
class Profile extends StatelessWidget {
  int index;
  Profile({Key key, this.index}) : super(key: key);
  @override
  Widget boxInformations(String title, String data) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      width: 100.0.w,
      //height: 10.0.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data,
                style:
                    TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          color: Colors.white),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 24.0.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 20.0.h,
                    height: 20.0.h,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.person,
                        size: 48.0.sp,
                      ),
                    ),
                  ),
                ),
                boxInformations('Firstname', allPeople[index].name),
                boxInformations('Lastname', allPeople[index].lastname),
                boxInformations('Gender', allPeople[index].gender.toString()),
                boxInformations('Birthday',
                    '${allPeople[index].birthday.day} / ${allPeople[index].birthday.month} / ${allPeople[index].birthday.year}'),
                boxInformations('Job', allPeople[index].job),
                boxInformations(
                    'Telephone number', allPeople[index].telnum.toString()),
                boxInformations('Address', allPeople[index].address),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
