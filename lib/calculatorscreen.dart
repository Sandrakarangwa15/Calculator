import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "CLEAR") {
        _output = "0";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "/" ||
          buttonText == "x" ||
          buttonText == "%") {
        num1 = double.parse(output);
        operand = buttonText;
        _output = "0";
      } else if (buttonText == "=") {
        num2 = double.parse(output);

        if (operand == "+") {
          _output = (num1 + num2).toString();
        }
        if (operand == "-") {
          _output = (num1 - num2).toString();
        }
        if (operand == "x") {
          _output = (num1 * num2).toString();
        }
        if (operand == "/") {
          _output = (num1 / num2).toString();
        }
        if (operand == "%") {
          _output = (num1 % num2).toString();
        }

        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else if (buttonText == ".") {
        if (!_output.contains(".")) {
          _output += buttonText;
        }
      } else if (buttonText == "±") {
        if (_output.startsWith("-")) {
          _output = _output.substring(1);
        } else {
          _output = "-" + _output;
        }
      } else if (buttonText == "√x") {
        num1 = double.parse(output);
        _output = (num1 >= 0 ? sqrt(num1) : double.nan).toString();
      } else if (buttonText == "x²") {
        num1 = double.parse(output);
        _output = (num1 * num1).toString();
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }

      output = _output;
    });
  }

  Widget buildButton(String buttonText, Color color, double fontSize) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            buttonText,
            style: GoogleFonts.notoSerif(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                output,
                style: GoogleFonts.notoSerif(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
            ),
          ),
          const Divider(color: Colors.white70),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButtonRow(["x²", "√x", "CLEAR", "/"]),
                buildButtonRow(["7", "8", "9", "x"]),
                buildButtonRow(["4", "5", "6", "-"]),
                buildButtonRow(["1", "2", "3", "+"]),
                buildButtonRow(["±", "0", ".", "="]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons
            .map((button) => buildButton(
                  button,
                  button == "=" ? Colors.blue : Colors.grey[800]!,
                  24.0,
                ))
            .toList(),
      ),
    );
  }
}
