import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.notoSerif(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyMedium: GoogleFonts.notoSerif(fontSize: 16.0, color: Colors.white70),
        ),
      ),
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key});

  @override
  // ignore: library_private_types_in_public_api
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
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "x" || buttonText == "%") {
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
        _output = (num1 >= 0 ? sqrt(num1) : double.nan).toString(); // Use sqrt() from dart:math
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
            padding: const EdgeInsets.all(15.0),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
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
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(
                vertical: 125,
                horizontal: 50,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  output,
                  style: GoogleFonts.notoSerif(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Divider(),
            Column(
              children: [
                Row(
                  children: [
                    buildButton("x²", Colors.grey[800]!, 20.0),
                    buildButton("√x", Colors.grey[800]!, 20.0),
                    buildButton("CLEAR", Colors.grey[800]!, 20.0),
                    buildButton("/", Colors.grey[800]!, 20.0),
                    
                  ],
                ),
                Row(
                  children: [
                    buildButton("7", Colors.grey[800]!, 20.0),
                    buildButton("8", Colors.grey[800]!, 20.0),
                    buildButton("9", Colors.grey[800]!, 20.0),
                    buildButton("x", Colors.grey[800]!, 20.0),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4", Colors.grey[800]!, 20.0),
                    buildButton("5", Colors.grey[800]!, 20.0),
                    buildButton("6", Colors.grey[800]!, 20.0),
                    buildButton("-", Colors.grey[800]!, 20.0),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1", Colors.grey[800]!, 20.0),
                    buildButton("2", Colors.grey[800]!, 20.0),
                    buildButton("3", Colors.grey[800]!, 20.0),
                    buildButton("+", Colors.grey[800]!, 20.0),
                  ],
                ),
                Row(
                  children: [
                    buildButton("±", Colors.grey[800]!, 20.0),
                    buildButton("0", Colors.grey[800]!, 20.0),
                    buildButton(".", Colors.grey[800]!, 20.0),
                    buildButton("=", Colors.blue, 20.0),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
