import 'package:flutter/material.dart';
import 'package:tyba_prueba/controller/auth.dart';
import 'package:tyba_prueba/view/components/alertDialog_Component.dart';
import 'package:tyba_prueba/view/utils/style.dart';

class AppbarComponent extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    // Componente de la barra superior
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: StylesElements.colorPrimary,
      title: Hero(
        tag: "logo",
        child: Container(
          height: 50,
          width: 100,
          child: Image.asset('assets/logo.png'),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: StylesElements.colorBlack,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialogComponent(
                      titulo: "Cerrar sesión",
                      contenido: Text(
                        "¿Estás seguro que desea salir de la app?",
                        style: StylesElements.tsNormalBlack,
                      ),
                      dosBotones: true,
                      textoBotonPositivo: "Aceptar",
                      textoBotonNegativo: "Cancelar",
                      funcionPositiva: () {
                        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                        Auth().signOut();
                      },
                      funcionNegativa: () => Navigator.pop(context));
                });
          },
        )
      ],
    );
  }
}
