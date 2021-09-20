import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String text_entrypoint = '';
  String text_display = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculadora Camilo")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          this._Display(),
          this._EntryPoint(),
          this._Keyboard(),
        ],
      )
    );
  }

  Widget drawButton({required String text_button, int flex_button: 1, Color color_button: const Color(0xF454545)}){
    return Expanded(
      flex: flex_button,
      child: Container(
        child: 
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ElevatedButton(
              onPressed: () => this._updateScreen(text_button), 
              child: Text(text_button),
              style: ElevatedButton.styleFrom(
                primary: color_button,
                side: BorderSide(width: 1.0, color: Color(0xFF212121)),
              ),
            ),
          ),
        ) 
    );
  }

  _Display() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Row(
          children: [
            Text(
              text_display, 
              textAlign: TextAlign.right, 
              style: 
                TextStyle(
                  color: Colors.white,
                  fontSize: 20,
              ),
            ),
          ],
        ),
        color: Color(0xFF383838),
      ),
    );
  }

  _EntryPoint() {
    return Expanded(
      flex: 1,
        child: Container(
          child: Row(
            children: [
              Text(
                text_entrypoint, 
                textAlign: TextAlign.right, 
                style: 
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                ),
              ),
            ],
          ),
          color: Color(0xFF404040),
        ),
    );
  }

  _Keyboard() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                drawButton(text_button: "7"),
                drawButton(text_button: "8"),
                drawButton(text_button: "9"),
                drawButton(text_button: "/"),
                drawButton(text_button: "<"),
                drawButton(text_button: "C"),
              ]
            ),
            Row(
              children: [
                drawButton(text_button: "4"),
                drawButton(text_button: "5"),
                drawButton(text_button: "6"),
                drawButton(text_button: "*"),
                drawButton(text_button: "("),
                drawButton(text_button: ")"),
              ]
            ),
            Row(
              children: [
                drawButton(text_button: "2"),
                drawButton(text_button: "3"),
                drawButton(text_button: "1"),
                drawButton(text_button: "-"),
                drawButton(text_button: "^2"),
                drawButton(text_button: "sqrt("),
              ]
            ),
            Row(
              children: [
                drawButton(text_button: "0"),
                drawButton(text_button: ","),
                drawButton(text_button: "%"),
                drawButton(text_button: "+"),
                drawButton(text_button: "=", color_button: Color(0xFF50b64b)),
              ]
            ),

          ],
        ),
        color: Color(0xFF383838),
      )
    );
  }

  _updateScreen(String character) {
    setState(() {
 
      if (character == 'C'){
        text_entrypoint = '';
        text_display = '';
      }
      else if (character == '<'){
        if (text_entrypoint.length > 0)
          text_entrypoint = text_entrypoint.substring(0, text_entrypoint.length-1);
      }
      else if (character == "="){

        String eval = '';
        try{
          Parser p = Parser();
          Expression exp = p.parse(text_entrypoint);

          ContextModel cm = ContextModel();

          eval = exp.evaluate(EvaluationType.REAL, cm).toString();
          if (eval == "NaN")
            text_display = "Error de raíz negativa";
          else if (eval == "Infinity")
            text_display = "No se puede dividir entre 0";
          else
            text_display = eval.toString();
        } on Exception catch (ex) {
          text_display = "Ha ocurrido un error";
        } on RangeError catch(ex){
          text_display = "Error de sintaxis";
        }

      }else
          text_entrypoint = text_entrypoint + character;


    });
  }
}