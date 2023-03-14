import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    home: Myapp(),
  ));
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
//variables
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "DEL") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    }
   
     else if (value == "=") {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? "" : input,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ]),
          ),
        ),
        Row(
          children: [
            button(
                text: "AC", buttonbgColor: Colors.grey, tColor: Colors.black),
            button(text: "DEL", buttonbgColor: Colors.grey, tColor: Colors.black),
            button(text: "%", buttonbgColor: Colors.grey, tColor: Colors.black),
            button(text: "/", buttonbgColor: Colors.deepPurple),
          ],
        ),
        Row(
          children: [
            button(text: "7",buttonbgColor: operatorColor),
            button(text: "8",buttonbgColor: operatorColor),
            button(text: "9",buttonbgColor: operatorColor),
            button(text: "x", buttonbgColor: Colors.deepPurple),
          ],
        ),
        Row(
          children: [
            button(text: "4",buttonbgColor: operatorColor),
            button(text: "5",buttonbgColor: operatorColor),
            button(text: "6",buttonbgColor: operatorColor),
            button(text: "-", buttonbgColor: Colors.deepPurple),
          ],
        ),
        Row(
          children: [
            button(text: "1",buttonbgColor: operatorColor),
            button(text: "2",buttonbgColor: operatorColor),
            button(text: "3",buttonbgColor: operatorColor),
            button(text: "+", buttonbgColor: Colors.deepPurple),
          ],
        ),
        Row(
          children: [
            button(text: "00",buttonbgColor: operatorColor),
            button(text: "0",buttonbgColor: operatorColor),
            button(text: ".",buttonbgColor: operatorColor),
            button(text: "=", buttonbgColor: Colors.deepPurple),
          ],
        ),
      ]),
    );
  }

  Widget button({text, tColor = Colors.white, buttonbgColor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(3),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(18),
            primary: buttonbgColor),
        onPressed: () => onButtonClick(text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 34,
            color: tColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ));
  }
}
