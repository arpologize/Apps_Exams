import 'package:app_exams/todolist/project.dart';
import 'package:app_exams/todolist/save.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

class Todolist extends StatefulWidget {
  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  @override
  void initState() {
    super.initState();
  }

//เช็คว่าข้อมูลโหลดมาพร้อมแล้วหรือยัง
  bool checkfetch = false;
  Future<void> fetchData() async {
    await getList();
    checkfetch = true;
  }

//ฟังก์ชันเช็คว่ามีข้อมูลวันนี้ อื่นๆ หรือเสร็จสิ้นหรือยัง ถ้าไม่มี Topic แสดงหัวข้อเรื่องจะหายไป
  DateTime selectedDate;
  bool checkProjectToday() {
    for (var index = 0; index < allProject.length; index++) {
      if ((DateTime.now().day == allProject[index].projectDate.day &&
              DateTime.now().month == allProject[index].projectDate.month) &&
          !allProject[index].projectDid) {
        return true;
      }
    }
    return false;
  }

  bool checkProject() {
    for (var index = 0; index < allProject.length; index++) {
      if (!(DateTime.now().day == allProject[index].projectDate.day &&
              DateTime.now().month == allProject[index].projectDate.month) &&
          !allProject[index].projectDid) {
        return true;
      }
    }
    return false;
  }

  bool checkFinishProject() {
    for (var project in allProject) {
      if (project.projectDid) {
        return true;
      }
    }
    return false;
  }

// ปฏิทินเลือกเวลา
  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }

// Widget แสดง Icon ปฏิทิน
  Widget calendar() {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              selectDate(context);
            },
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_sharp,
                  size: 28.0.sp,
                ),
                Text(
                  'Pick the date',
                  style: TextStyle(fontSize: 18.0.sp),
                )
              ],
            )),
      ],
    );
  }

// ช่อง Input ไว้ป้อนชื่องานว่างานอะไร
  void inputProject(context) {
    var _inputtext = TextEditingController();

    Widget _textField() {
      return Container(
          width: 90.0.w,
          height: 10.0.h,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: new Theme(
            data: new ThemeData(),
            child: TextFormField(
                controller: _inputtext,
                decoration: new InputDecoration(
                  hasFloatingPlaceholder: false,
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide:
                          new BorderSide(color: Colors.black, width: 2)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                  ),
                  labelText: 'ป้อนงานใหม่ที่นี่',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: new TextStyle(
                    fontSize: 14.0.sp,
                    fontFamily: "Poppins",
                    color: Colors.black)),
          ));
    }

    Widget send() {
      return Transform.rotate(
        angle: 270 * math.pi / 180,
        child: IconButton(
            icon: Icon(
              Icons.send,
              size: 32.0.sp,
            ),
            onPressed: () {
              setState(() {
                if (selectedDate == null) {
                  selectedDate = DateTime.now();
                }
                allProject.add(Project(
                    projectName: _inputtext.text,
                    projectDid: false,
                    projectDate: selectedDate));

                saveList();
              });
            }),
      );
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext bc) {
        return Container(
          height: 20.0.h,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _textField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [calendar(), send()],
                  )
                ],
              )),
        );
      },
    );
  }

// ช่อง input ไว้แก้งานที่ถูกเพิ่มแล้ว เปลี่ยนชื่อ เปลี่ยนเวลา
  void editProject(context, int index) {
    var _title = TextEditingController();
    _title.value = _title.value.copyWith(text: allProject[index].projectName);
    selectedDate = allProject[index].projectDate;
    Widget _textField() {
      return Container(
          width: 90.0.w,
          height: 10.0.h,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: new Theme(
            data: new ThemeData(),
            child: TextFormField(
                controller: _title,
                decoration: new InputDecoration(
                  hasFloatingPlaceholder: false,
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide:
                          new BorderSide(color: Colors.black, width: 2)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                  ),
                  //labelText: 'ป้อนงานใหม่ที่นี่',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: new TextStyle(
                    fontSize: 14.0.sp,
                    fontFamily: "Poppins",
                    color: Colors.black)),
          ));
    }

    Widget saveProject() {
      return Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
            icon: Icon(
              Icons.save,
              size: 28.0.sp,
            ),
            onPressed: () {
              setState(() {
                allProject[index].projectName = _title.text;
                allProject[index].projectDate = selectedDate;
                saveList();
              });
            }),
      );
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext bc) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
          return Container(
            height: 20.0.h,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    _textField(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                initialDatePickerMode: DatePickerMode.day,
                                firstDate: DateTime(2015),
                                lastDate: DateTime(2101));
                            mystate(() {
                              selectedDate = picked;
                            });
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.calendar_today_rounded,
                                    size: 28.0.sp,
                                  ),
                                ),
                                Text(
                                  '${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',
                                  style: TextStyle(fontSize: 16.0.sp),
                                )
                              ],
                            ),
                          ),
                        ),
                        saveProject()
                      ],
                    ),
                  ],
                )),
          );
        });
      },
    );
  }

// List แสดงตารางงานของวันนี้
  Widget showListProjectToday() {
    return Container(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: allProject.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(allProject[index].projectName),
            onDismissed: (direction) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("${allProject[index].projectName} deleted")));
              setState(() {
                allProject.removeAt(index);
                saveList();
              });
            },
            child: Container(
              color: Colors.grey.shade100,
              child:
                  ((DateTime.now().day == allProject[index].projectDate.day &&
                              DateTime.now().month ==
                                  allProject[index].projectDate.month &&
                              DateTime.now().year ==
                                  allProject[index].projectDate.year) &&
                          !allProject[index].projectDid)
                      ? ListTile(
                          //contentPadding: EdgeInsets.all(0.5),
                          //shape: s,
                          leading: IconButton(
                            icon: (allProject[index].projectDid)
                                ? Icon(Icons.check_circle)
                                : Icon(Icons.trip_origin),
                            onPressed: () {
                              setState(() {
                                allProject[index].projectDid = true;
                                saveList();
                              });
                            },
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${allProject[index].projectName}',
                                style: TextStyle(fontSize: 15.0.sp),
                              ),
                              Text(
                                '${allProject[index].projectDate.day} / ${allProject[index].projectDate.month} / ${allProject[index].projectDate.year}',
                                style: TextStyle(
                                    fontSize: 11.0.sp, color: Colors.grey),
                              )
                            ],
                          ),
                          onTap: () {
                            editProject(context, index);
                          },
                        )
                      : Container(),
            ),
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

// List แสดงตารางงานที่ไม่ใช่ของวันนี้
  Widget showListProject() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: allProject.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(allProject[index].projectName),
            onDismissed: (direction) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("${allProject[index].projectName} deleted")));
              setState(() {
                allProject.removeAt(index);
                saveList();
              });
            },
            child: Container(
              color: Colors.grey.shade100,
              child:
                  (!(DateTime.now().day == allProject[index].projectDate.day &&
                              DateTime.now().month ==
                                  allProject[index].projectDate.month &&
                              DateTime.now().year ==
                                  allProject[index].projectDate.year) &&
                          !allProject[index].projectDid)
                      ? ListTile(
                          onTap: () {
                            editProject(context, index);
                          },
                          leading: IconButton(
                            icon: (allProject[index].projectDid)
                                ? Icon(Icons.check_circle)
                                : Icon(Icons.trip_origin),
                            onPressed: () {
                              setState(() {
                                allProject[index].projectDid = true;
                                saveList();
                              });
                            },
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${allProject[index].projectName}',
                                style: TextStyle(fontSize: 15.0.sp),
                              ),
                              Text(
                                '${allProject[index].projectDate.day} / ${allProject[index].projectDate.month} / ${allProject[index].projectDate.year}',
                                style: TextStyle(
                                    fontSize: 11.0.sp, color: Colors.grey),
                              )
                            ],
                          ))
                      : Container(),
            ),
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

// List แสดงตารางงานที่เสร็จสิ้นแล้ว
  Widget showListFinishProject() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: allProject.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(allProject[index].projectName),
            onDismissed: (direction) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("${allProject[index].projectName} deleted")));
              setState(() {
                allProject.removeAt(index);
                saveList();
              });
            },
            child: Container(
              color: Colors.grey.shade100,
              child: (allProject[index].projectDid)
                  ? ListTile(
                      onTap: () {
                        editProject(context, index);
                      },
                      leading: IconButton(
                        icon: (allProject[index].projectDid)
                            ? Icon(Icons.check_circle)
                            : Icon(Icons.trip_origin),
                        onPressed: () {
                          setState(() {
                            allProject[index].projectDid = false;
                            saveList();
                          });
                        },
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${allProject[index].projectName}',
                            style: TextStyle(
                                fontSize: 15.0.sp,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                          ),
                          Text(
                            '${allProject[index].projectDate.day} / ${allProject[index].projectDate.month} / ${allProject[index].projectDate.year}',
                            style: TextStyle(
                                fontSize: 11.0.sp, color: Colors.grey),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ),
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (checkfetch) {
                return SafeArea(
                    child: Container(
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (checkProjectToday())
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('วันนี้'),
                              )
                            : Container(),
                        showListProjectToday(),
                        (checkProject())
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('อื่นๆ'),
                              )
                            : Container(),
                        showListProject(),
                        (checkFinishProject())
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('เสร็จสิ้น'),
                              )
                            : Container(),
                        showListFinishProject()
                      ],
                    ),
                  ),
                ));
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    strokeWidth: 6,
                  ),
                );
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => inputProject(context)),
          child: const Icon(Icons.add),
        ));
  }
}
