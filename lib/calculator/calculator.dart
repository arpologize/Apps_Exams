import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  void initState() {
    super.initState();
  }

  String _history = '';
  String _expression = '';
  bool answer = false;

  void numClick(String text) {
    if (answer &&
        (text != '%' &&
            text != '/' &&
            text != '*' &&
            text != '-' &&
            text != '+')) {
      _expression = '';
    }
    answer = false;
    setState(() {
      if (_expression.length < 11) {
        _expression += text;
      }
    });
  }

  void allClear() {
    setState(() {
      _history = '';
      _expression = '';
    });
  }

  void clear() {
    setState(() {
      if ((_expression != null) && (_expression.length > 0)) {
        _expression = _expression.substring(0, _expression.length - 1);
      }
    });
  }

  void evaluate() {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();
    answer = true;
    setState(() {
      _history = _expression;
      _expression = exp.evaluate(EvaluationType.REAL, cm).toString();
    });
  }

  Widget numButton(String key) {
    return Container(
      width: 9.0.h,
      height: 9.0.h,
      margin: EdgeInsets.all(10),
      child: TextButton(
        // style: ButtonStyle(backgroundColor: ),
        //color: Colors.white.withOpacity(1),
        child: Text(
          key,
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 12.0.sp,
            color: Colors.white,
          ),
          textAlign: TextAlign.start,
        ),
        onPressed: () {
          numClick(key);
        },
      ),
    );
  }

  Widget expressionButton(String key) {
    return Container(
      width: 9.0.h,
      height: 9.0.h,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
          color: Colors.white,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 12.0.sp,
              color: Colors.teal,
            ),
            textAlign: TextAlign.start,
          ),
          onPressed: () {
            numClick(key);
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))),
    );
  }

  Widget evaluateButton(String key) {
    return Container(
      width: 9.0.h,
      height: 9.0.h,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
          color: Colors.white,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 12.0.sp,
              color: Colors.teal,
            ),
            textAlign: TextAlign.start,
          ),
          onPressed: () {
            evaluate();
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))),
    );
  }

  Widget deleteButton(String command) {
    return Container(
      width: 9.0.h,
      height: 9.0.h,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
          color: Colors.blueGrey,
          child: Text(
            command,
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 12.0.sp,
              color: Colors.white,
            ),
            textAlign: TextAlign.start,
          ),
          onPressed: () {
            if (command == "AC") {
              allClear();
            } else if (command == "<=") {
              clear();
            }
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Calculator"),
      //   centerTitle: true,
      // ),
      body: SafeArea(
          child: Container(
              decoration: BoxDecoration(color: Colors.blueGrey.shade900),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            _history,
                            style: TextStyle(
                              fontSize: 18.0.sp,
                              color: Color(0xFF545F61),
                            ),
                          ),
                        ),
                        alignment: Alignment(1.0, 1.0),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            _expression,
                            style: TextStyle(
                              fontSize: 42.0.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        alignment: Alignment(1.0, 1.0),
                      ),
                      SizedBox(height: 3.0.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          deleteButton('AC'),
                          deleteButton('<='),
                          expressionButton('%'),
                          expressionButton('/')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          numButton('7'),
                          numButton('8'),
                          numButton('9'),
                          expressionButton('*')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          numButton('4'),
                          numButton('5'),
                          numButton('6'),
                          expressionButton('-')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          numButton('1'),
                          numButton('2'),
                          numButton('3'),
                          expressionButton('+')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          numButton('.'),
                          numButton('0'),
                          numButton('00'),
                          evaluateButton('=')
                        ],
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
