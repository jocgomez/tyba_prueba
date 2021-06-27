import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StylesElements {
  // --- Colores
  static Color colorPrimary = new Color(0xFFF6C114);
  static Color colorSecondary = new Color(0xFFB85D1E);
  static Color colorBlack = new Color(0xFF333333);
  static Color colorGreyBG = Colors.grey[100];

  // --- Text styles
  // Texto en botones
  static TextStyle tsButtonBlack = new TextStyle(color: colorBlack, fontWeight: FontWeight.bold);
  // Texto bold
  static TextStyle tsBoldGreen18 =
      new TextStyle(color: colorPrimary, fontWeight: FontWeight.bold, fontSize: 18);
  static TextStyle tsBoldBlue18 =
      new TextStyle(color: colorSecondary, fontWeight: FontWeight.bold, fontSize: 18);
  static TextStyle tsBoldBlack18 =
      new TextStyle(color: colorBlack, fontWeight: FontWeight.bold, fontSize: 18);
  static TextStyle tsBoldPrimary = new TextStyle(color: colorPrimary, fontWeight: FontWeight.bold);
  static TextStyle tsBoldSecondary =
      new TextStyle(color: colorSecondary, fontWeight: FontWeight.bold);
  static TextStyle tsBoldBlack = new TextStyle(color: colorBlack, fontWeight: FontWeight.bold);
  static TextStyle tsBoldWhite = new TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  // Texto Normal
  static TextStyle tsNormalGreen = new TextStyle(color: colorPrimary);
  static TextStyle tsNormalBlue = new TextStyle(color: colorSecondary);
  static TextStyle tsNormalWhite = new TextStyle(color: Colors.white);
  static TextStyle tsNormalBlack = new TextStyle(color: colorBlack);

  // --- Iconos
  static final _icons = <String, IconData>{
    'email': Icons.mail_outline,
    'passwordVisible': Icons.lock_outline,
    'passwordInvisible': Icons.lock_open,
    'product': FontAwesomeIcons.registered,
    'description': Icons.description,
    'price': Icons.attach_money,
    'stock': FontAwesomeIcons.cubes,
    'add': Icons.add
  };
  static Icon getIcon(String nombreIcono) {
    return Icon(
      _icons[nombreIcono],
    );
  }

  // --- Estilo de los TextFields
  static InputDecoration textFieldDecoration(
      String labelText, bool withIcon, String iconText, VoidCallback iconFunction) {
    return InputDecoration(
        fillColor: Colors.white,
        focusColor: Colors.white,
        filled: true,
        labelText: labelText,
        labelStyle: tsNormalBlack,
        alignLabelWithHint: true,
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon:
            withIcon ? IconButton(icon: getIcon(iconText), onPressed: () => iconFunction()) : null);
  }
}
