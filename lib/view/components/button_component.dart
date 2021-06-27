import 'package:flutter/material.dart';
import 'package:tyba_prueba/view/utils/style.dart';

class ButtonComponent extends StatelessWidget {
  ButtonComponent(
      {Key key,
      @required this.color,
      @required this.text,
      @required this.borderColor,
      @required this.function})
      : super(key: key);

  final Color color;
  final String text;
  final Color borderColor;
  final VoidCallback function;

  // Componente atómico del botón con parámetros variables
  Widget build(BuildContext context) {
    return RaisedButton(
        color: this.color,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            this.text,
            style: StylesElements.tsButtonBlack,
            textAlign: TextAlign.center,
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: this.borderColor, width: 2.0)),
        onPressed: () {
          this.function();
        });
  }
}
