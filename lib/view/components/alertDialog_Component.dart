import 'package:flutter/material.dart';
import 'package:tyba_prueba/view/components/button_Component.dart';
import 'package:tyba_prueba/view/utils/style.dart';

class AlertDialogComponent extends StatelessWidget {
  AlertDialogComponent(
      {Key key,
      @required this.titulo,
      @required this.contenido,
      @required this.dosBotones,
      @required this.textoBotonPositivo,
      @required this.textoBotonNegativo,
      @required this.funcionPositiva,
      @required this.funcionNegativa})
      : super(key: key);

  final String titulo;
  final Widget contenido;
  final bool dosBotones;
  final String textoBotonNegativo;
  final String textoBotonPositivo;
  final VoidCallback funcionPositiva;
  final VoidCallback funcionNegativa;

  @override
  Widget build(BuildContext context) {
    // Componente atómico para la ventana emergente con parámetros variables como el # de botones y la funcion de cada uno de estos
    return AlertDialog(
      title: Text(this.titulo, style: StylesElements.tsBoldBlack),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SingleChildScrollView(child: this.contenido),
      actions: <Widget>[
        this.dosBotones
            ? ButtonComponent(
                color: Colors.white,
                text: this.textoBotonNegativo,
                borderColor: StylesElements.colorPrimary,
                function: this.funcionNegativa)
            : SizedBox(),
        ButtonComponent(
            color: StylesElements.colorPrimary,
            text: this.textoBotonPositivo,
            borderColor: StylesElements.colorPrimary,
            function: this.funcionPositiva),
      ],
    );
  }
}
