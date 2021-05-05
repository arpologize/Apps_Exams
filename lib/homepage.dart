import 'package:app_exams/calculator/calculator.dart';
import 'package:app_exams/informations/informations.dart';
import 'package:app_exams/todolist/todolist.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    //controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  TabController controller;
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Application Exams"),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Color(0xffffffff), // สีของข้อความปุ่มที่เลือก
            unselectedLabelColor:
                Color(0x55ffffff), // สีของข้อความปุ่มที่ไม่ได้เลือก
            tabs: <Tab>[
              Tab(icon: Icon(Icons.book_online), text: 'To do list'),
              Tab(icon: Icon(Icons.calculate), text: 'Calculator'),
              Tab(icon: Icon(Icons.person), text: 'Person'),
            ],
            // controller: controller,
          ),
        ),
        body: TabBarView(
          children: [Todolist(), Calculator(), Informations()],
        ),
      ),
    );
  }
}
// SafeArea(
//             child: Container(
//                 decoration: BoxDecoration(),
//                 child: Center(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[],
//                     ),
//                   ),
//                 )))