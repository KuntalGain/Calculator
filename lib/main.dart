import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userQuestion = "";
  String _userAnswer = "";

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(height: 50.0),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _userQuestion,
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      _userAnswer,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // color: Colors.deepPurple,
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  //clear all
                  if (index == 0) {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            _userQuestion = '';
                            _userAnswer = '';
                          });
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        buttonText: buttons[index]);
                  }

                  //Delete Button
                  else if (index == 1) {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            _userQuestion = _userQuestion.substring(
                                0, _userQuestion.length - 1);
                          });
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        buttonText: buttons[index]);
                  }
                  //Equal Button
                  else if (index == buttons.length - 1) {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        color: Color.fromARGB(255, 59, 248, 30),
                        textColor: Colors.white,
                        buttonText: buttons[index]);
                  }

                  //other buttons
                  else {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          _userQuestion += buttons[index];
                        });
                      },
                      color: isOperator(buttons[index])
                          ? Colors.deepPurple
                          : Colors.deepPurple[50],
                      textColor: isOperator(buttons[index])
                          ? Colors.deepPurple[50]
                          : Colors.deepPurple,
                      buttonText: buttons[index],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == "=") {
      return true;
    }

    return false;
  }

  void equalPressed() {
    String finalQuestion = _userQuestion;

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);

    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    _userAnswer = eval.toString();
  }
}
