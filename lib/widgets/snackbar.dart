import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:myapp/constantes.dart' as cons;
 
ShowSnackbar(BuildContext context, String mensaje, int duration) {
  //gestiona el momento en el que debe mostrarse el snackbar
  //dependiendo del contexto actual(proteccion de errores de creacion)
  SchedulerBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: cons.negro,
        content: Text(
          mensaje, textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
        action: SnackBarAction(
          label:' X ',
          onPressed: () {
           
          },
          textColor: Colors.white,
          disabledTextColor: Colors.grey,
      ),
      ),
    );
  });
}