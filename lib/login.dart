
// 🔧 IMPORTACIONES - Librerías que necesitamos usar
/// 'package:flutter/material.dart' - Contiene todos los widgets de Material Design
/// 'package:mypp/constantes.dart' - Archivo con constantes (colores, textos, etc.)
import 'package:flutter/material.dart';
import 'package:myapp/constantes.dart' as cons;
import 'package:myapp/Home.dart';
import 'package:myapp/widgets/snackbar.dart';

/// 🎯 CLASE PRINCIPAL - Login (StatefulWidget)
/// StatefulWidget = Widget que puede cambiar su estado durante la ejecución
/// StatelessWidget = Widget que nunca cambia (como un botón estático)
class Login extends StatefulWidget {
  /// 🔑 Constructor constante - Buena práctica en Flutter
  /// 'super.key' permite que Flutter optimice el rendimiento
  const Login({super.key});

  /// 🎪 MÉTODO createState() - Crea el estado del widget
  /// Cada StatefulWidget necesita su propio State
  /// El guión bajo (_) hace la clase privada (solo accesible en este archivo)
  @override
  State<Login> createState() => _LoginState();
}

/// ⚙️ CLASE DE ESTADO - _LoginState
/// Aquí va toda la lógica y variables que pueden cambiar
class _LoginState extends State<Login> {

  /// 🔄 VARIABLES DE ESTADO - Pueden cambiar durante la ejecución
  /// 'bool mostrarPassword' - Controla si mostrar/ocultar la contraseña
  /// 'TextEditingController' - Controla el texto de los campos de entrada
  bool mostrarPassword = false;
  final usuario = TextEditingController();
  final password = TextEditingController();

  /// 🎨 MÉTODO build() - CONSTRUYE LA INTERFAZ DE USUARIO
  /// Se ejecuta cada vez que el estado cambia (setState)
  /// 'context' - Información sobre la ubicación del widget en el árbol
  @override
  Widget build(BuildContext context) {

    /// OBTENER TAMAÑO DE PANTALLA - Diseño responsivo
    /// MediaQuery nos da información sobre el dispositivo
    /// 'size' contiene ancho y alto de la pantalla
    final size = MediaQuery.of(context).size;

    /// ESTRUCTURA DEL WIDGET
    /// Cada elemento en Flutter se llama WIDGET
    /// Los widgets se organizan en forma de ÁRBOL (como una familia)
    /// Dart usa sintaxis en cascada (indentación) para organizar el código
    return Scaffold(

      ///  CUERPO DE LA PANTALLA - SingleChildScrollView
      /// Permite hacer scroll si el contenido es más grande que la pantalla
      /// IMPORTANTE: Evita errores de "overflow" en pantallas pequeñas
      body: SingleChildScrollView(

        /// PADDING - Espacio alrededor del contenido
        /// 'size.height * 0.1075' = 10.75% de la altura de la pantalla
        /// Esto hace el diseño RESPONSIVO (se adapta a diferentes tamaños)
        padding: EdgeInsets.all(
          size.height * 0.1075,
        ), //*1 --> 100% de la pantalla  *0.5 --> 50%

        /// CONTENEDOR PRINCIPAL - Column
        /// Organiza los widgets verticalmente (uno debajo del otro)
        child: Column(
          /// ALINEACIÓN - Centra todo verticalmente
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// ESPACIADO - SizedBox
            /// Crea un espacio vacío entre widgets
            /// 'size.height * 0.01' = 1% de la altura de la pantalla
            SizedBox(height: size.height * 0.01),

            /// TEXTO DEL TÍTULO
            /// Muestra "Inicio de sesion" en color ámbar
            Text('Inicio de sesion', style: TextStyle(color: Colors.amber, fontSize: 24)),

            /// LLAMADA A MÉTODO PERSONALIZADO
            /// buildRow() es un método que creamos abajo
            buildRow('Usuario'),

            /// CAMPO DE TEXTO PARA USUARIO
            /// newMetod() es otro método personalizado
            /// 'false' significa que NO es campo de contraseña
            newMetod('Escribe tu usuario', false),

            /// ESPACIADO ENTRE CAMPOS
            SizedBox(height: size.height * 0.01),

            /// ETIQUETA PARA CONTRASEÑA
            buildRow('Contraseña:'),

            /// CAMPO DE CONTRASEÑA
            /// 'true' significa que ES campo de contraseña
            newMetod('Escribe tu contraseña', true),

            /// ESPACIADO
            SizedBox(height: size.height * 0.01),

            /// TEXTO "¿Olvidaste tu contraseña?"
            /// Row organiza horizontalmente, MainAxisAlignment.end lo pone a la derecha
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('¿Olvidaste tu contraseña?', style: TextStyle(color: cons.azulito, fontSize: 16)),
              ],
            ),

            /// 📏 ESPACIADO ANTES DEL BOTÓN
            SizedBox(height: size.height * 0.03),

            /// 🔘 BOTÓN DE INGRESAR
            /// ElevatedButton = Botón elevado (con sombra)
            ElevatedButton(
              /// ACCIÓN DEL BOTÓN - onPressed
              /// Aquí iría la lógica de validación y navegación
              onPressed: () {
                setState(() {
                  //El usuario y contraseña son correctos
                  if(usuario.text == cons.user &&
                  password.text == cons.pass){
                    //cambiar la vista
                    //flutter trabaja con pilas , remplzamos la vista actual por una nueva
                    //el login ya no va a estar en la pila, pues no se ocupara regresar a ella
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  }
                  else{
                    //mostramos un mensaje de error (snackbar)
                    ShowSnackbar(context, 'Usuario invalido', 20);
                  }
                });
                // TODO: Agregar lógica de login aquí
                // Ejemplo: validar campos, hacer petición HTTP, navegar a otra pantalla
              },

              ///  ESTILO DEL BOTÓN
              style: ElevatedButton.styleFrom(
                /// Color de fondo usando constante
                backgroundColor: cons.azulito,
                /// Bordes redondeados
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                /// Tamaño fijo: 75% del ancho de pantalla, 45px de alto
                fixedSize: Size(size.width * 0.75, 45),
              ),

              /// TEXTO DEL BOTÓN
              child: Text(
                'Ingresar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500, // Peso de fuente medio
                  letterSpacing: 2.5, // Espacio entre letras
                  color: cons.blanco, // Color blanco
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///MÉTODO PERSONALIZADO - buildRow()
  /// Crea una fila con texto (reutilizable)
  /// Parámetro: 'texto' - El texto que queremos mostrar
  Row buildRow(String texto) {
    return Row(
      children: [
        /// Texto con estilo personalizado
        Text(texto, style: TextStyle(fontSize: 18)),
      ],
    );
  }

  /// MÉTODO PERSONALIZADO - newMetod()
  /// Crea un campo de texto (TextFormField) reutilizable
  /// Parámetros:
  /// - 'text': Texto de sugerencia (hint)
  /// - 'band': true para contraseña, false para usuario
  TextFormField newMetod(String text, bool band) {
    return TextFormField(
      /// CONTROLADOR - Conecta el campo con la variable
      /// Si 'band' es true usa password, sino usa usuario
      controller: band ? password : usuario,

      /// OCULTAR TEXTO - Para contraseñas
      /// Si 'band' es true, usa 'mostrarPassword' para decidir si ocultar
      obscureText: band ? mostrarPassword : false,

      /// DECORACIÓN DEL CAMPO
      decoration: InputDecoration(
        ///  FONDO RELLENO
        filled: true,
        fillColor: cons.blanco,

        /// ÍCONO AL FINAL (SUFFIX)
        /// Solo aparece si es campo de contraseña
        suffixIcon: band ? IconButton(
          ///  ACCIÓN: Cambiar visibilidad de contraseña
          onPressed: () {
            ///  CAMBIAR ESTADO - setState()
            /// Esto hace que Flutter reconstruya la interfaz
            setState(() {
              mostrarPassword = !mostrarPassword;
            });
          },
          /// 👁️ ÍCONO: Ojo abierto/cerrado según estado
          icon: mostrarPassword
              ? Icon(Icons.visibility_off, color: cons.azulito)
              : Icon(Icons.visibility, color: cons.azulito),
        ) : null, // Si no es contraseña, no hay ícono

        /// 🔘 ÍCONO AL INICIO (PREFIX)
        /// Siempre muestra ícono de persona (debería ser diferente para usuario vs password)
        prefixIcon: band
            ? Icon(Icons.lock, color: cons.azulito) // Candado para contraseña
            : Icon(Icons.person, color: cons.azulito), // Persona para usuario

        /// 📦 BORDE DEL CAMPO
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25), // Bordes redondeados
        ),

        /// 💡 TEXTO DE AYUDA
        hintText: text,
      ),
    );
  }
}

/// 📚 CONCEPTOS IMPORTANTES PARA APRENDER:
/// 1. WIDGET TREE: Los widgets se organizan como un árbol familiar
/// 2. STATE: Las variables que cambian necesitan estar en State
/// 3. setState(): Método que avisa a Flutter que reconstruya la UI
/// 4. Controllers: Para controlar el texto de los campos
/// 5. Responsive: Usar porcentajes del tamaño de pantalla
/// 6. Métodos personalizados: Para reutilizar código
/// 7. Material Design: Estilos y componentes de Google