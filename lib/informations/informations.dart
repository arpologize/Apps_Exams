import 'package:app_exams/informations/Person.dart';
import 'package:app_exams/informations/profile.dart';
import 'package:app_exams/informations/register.dart';
import 'package:app_exams/informations/save.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class Informations extends StatefulWidget {
  @override
  _InformationsState createState() => _InformationsState();
}

class _InformationsState extends State<Informations> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  bool checkfetch = false;
  Future<void> fetchData() async {
    await getList();
    checkfetch = true;
  }

  Future onGoBack(dynamic value) {
    setState(() {});
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => Register());
    Navigator.push(context, route).then(onGoBack);
  }

  Widget showListPeople() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: allPeople.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(allPeople[index].name),
            onDismissed: (direction) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "${allPeople[index].name} ${allPeople[index].lastname} deleted")));
              setState(() {
                allPeople.removeAt(index);
                saveList();
              });
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${allPeople[index].name} ${allPeople[index].lastname}',
                        style: TextStyle(fontSize: 15.0.sp),
                      ),
                    ],
                  ),
                  onTap: () {
                    MaterialPageRoute materialPageRoute = MaterialPageRoute(
                        builder: (BuildContext context) => Profile(
                              index: index,
                            ));
                    Navigator.of(context).push(materialPageRoute);
                  },
                ),
              ),
            ),
            secondaryBackground: Container(
              child: Center(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.red,
            ),
            background: Container(),
            //child: MovieCard(movie: movies[index]),
            //key: UniqueKey(),
            direction: DismissDirection.endToStart,
          );
        },
      ),
    );
  }

  Widget registerButton() {
    return Container(
        alignment: Alignment.topRight,
        child: ElevatedButton(
          style: ButtonStyle(),
          child: Text("Add Person"),
          onPressed: () {
            // MaterialPageRoute materialPageRoute =
            //     MaterialPageRoute(builder: (BuildContext context) => Register());
            // Navigator.of(context).push(materialPageRoute);
            navigateSecondPage();
          },
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        body: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (checkfetch) {
                return SafeArea(
                    child: Container(
                  //decoration: BoxDecoration(color: Colors.blueGrey.shade100),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              'Civilians List',
                              style: TextStyle(
                                  fontSize: 28.0.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        registerButton(),
                        showListPeople(),
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
            }));
  }
}
