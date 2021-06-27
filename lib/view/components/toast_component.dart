import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastComponent {
  // Componente para enviar un mensaje toast, se evalua si es corto o largo (Duración)
  static void toastMessage({@required String message, @required bool isLong}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
