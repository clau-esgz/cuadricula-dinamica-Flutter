import 'dart:math'; // Este coso es para poder mezclar listas random con shuffle()
import 'package:flutter/material.dart';
import 'package:myapp/constantes.dart'; //aquí están los colorcitos 

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //variables que definen cuántos renglones, columnas, espacio y tamaño de cada cuadrito
  final int filas = 6;
  final int columnas = 3;
  final double espacio = 12;//Espacio entre cada cuadrito, para que no estén pegados
  final double lado = 80; //tam de cada cuadrito (ancho y alto)

  //numeritos que se ven en cada cuadrito
  late List<int> numeros;
  //colorcitos de fondo de cada cuadrito
  late List<Color> colores;
  //este colorcito es para el texto del cuadrito del centro (el 8)
  Color colorTextoCentro = blanco;
  late Color colorOriginalCentro;

  @override
  void initState() {
    super.initState();
    //arreglo con los numeritos del 1 al 18 para la cuadricula
    numeros = List.generate(filas * columnas, (index) => index + 1);
    //aquí se copian los colorcitos kiuts del archivo de constantes
    colores = List<Color>.from(cuadritoColors);
    //vamos a guardar  el color original del cuadrito del centro (índice 7)
    colorOriginalCentro = colores[7];
  }

  //intercambiar los numeritos entre dos cuadritos
  void intercambiar(int a, int b) {
    setState(() {
      final temp = numeros[a];
      numeros[a] = numeros[b];
      numeros[b] = temp;
    });
  }

  // Esta función hace lo mismo pero con los colorcitos de fondo
  void intercambiarColores(int a, int b) {
    setState(() {
      final temp = colores[a];
      colores[a] = colores[b];
      colores[b] = temp;
    });
  }

  //Esta función es para el cuadrito del centro: si está blanco lo regresa a su colorcito original y texto blanco,
  //si no, lo pone blanco y el texto negro para que se vea
  void cambiarEnMedio() {
    setState(() {
      if (colores[7] == blanco) {
        colores[7] = colorOriginalCentro;
        colorTextoCentro = blanco;
      } else {
        colores[7] = blanco;
        colorTextoCentro = negro;
      }
    });
  }
//catafixeamos todo
  void mezclarTodo() {
    setState(() {
      numeros.shuffle();
      colores.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    //calculamos el ancho total de la cuadricula para que quede bien centrada y cuadrada
    final double anchoCuadricula = (lado * columnas) + (espacio * (columnas - 1));
    List<Widget> filasWidgets = [];
    for (int i = 0; i < filas; i++) {
      List<Widget> columnasWidgets = [];
      for (int j = 0; j < columnas; j++) {
        int index = i * columnas + j; //se calcula eel índice correcto para cada cuadrito
        columnasWidgets.add(
          GestureDetector(
            onTap: () {
              //se se le da click al 0, 1 o 2, intercambia su numerito con el 15, 16 o 17 respectivamente
              if (index == 0) intercambiar(0, 15);
              if (index == 1) intercambiar(1, 16);
              if (index == 2) intercambiar(2, 17);

              //.si se le ds click al 6 o al 8, intercambia sus colorcitos de fondo
              if (index == 6) intercambiarColores(6, 8);
              if (index == 8) intercambiarColores(8, 6);

              //si se le da click al del centro (índice 7), cambia el colorcito de fondo y el colorcito del texto
              if (index == 7) {
                cambiarEnMedio();
              }

              //si se le da click al 13, revuelve todos los numeritos y colorcitos de la cuadricula
              if (index == 13) {
                mezclarTodo();
              }
            },
            child: Container(
              width: lado,
              height: lado,
              margin: EdgeInsets.only(
                left: j == 0 ? 0 : espacio, //solo pone espacio a la izquierda si no es el primero
              ),
              decoration: BoxDecoration(
                color: colores[index], //aquí va el colorcito de fondo del cuadrito
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: moradito, width: 2),
              ),
              child: Center(
                child: Text(
                  '${numeros[index]}', //en este deste va el numerito que le toca a cada cuadrito
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: index == 7 ? colorTextoCentro : blanco, //elcentro puede cambiar de colorcito de texto, los demás siempre blanco
                  ),
                ),
              ),
            ),
          ),
        );
      }
      filasWidgets.add(
        Padding(
          padding: EdgeInsets.only(
            top: i == 0 ? 0 : espacio, //solo  se pone espacio arriba si no es la primera fila
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: columnasWidgets,
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: anchoCuadricula,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: filasWidgets,
          ),
        ),
      ),
    );
  }
}

