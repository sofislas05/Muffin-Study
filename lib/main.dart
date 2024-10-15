
import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const BottomNavigationBarExampleApp());

class PomodoroTimerWidget extends StatefulWidget {
  @override
  _PomodoroTimerWidgetState createState() => _PomodoroTimerWidgetState();
}

class _PomodoroTimerWidgetState extends State<PomodoroTimerWidget> {
  int workDuration = 25; // Adjust the duration as needed
  int breakDuration = 5; // Adjust the duration as needed
  late int currentDuration;
  bool isWorking = true;
  bool isRunning = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    currentDuration = workDuration * 60;
  }

  void toggleTimer() {
    if (isRunning) {
      timer.cancel();
      isRunning = false;
    } else {
      startTimer();
    }
  }

  void startTimer() {
    isRunning = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentDuration > 0) {
        setState(() {
          currentDuration -= 1;
        });
      } else {
        timer.cancel();
        toggleTimer();
        isWorking = !isWorking;
        currentDuration = isWorking ? workDuration * 60 : breakDuration * 60;
        startTimer();
      }
    });
  }

  void resetTimer() {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    setState(() {
      isRunning = false;
      isWorking = true;
      currentDuration = workDuration * 60;
    });
  }


  @override
  Widget build(BuildContext context) {
    String timerType = isWorking ? '\nTrabajo' : 'Break';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$timerType Timer',
          style: TextStyle(
            fontFamily: 'Fredoka',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.yellow[100],
          ),
          ),
        ColoredBox(
            color: Colors.redAccent,
            child: SizedBox(
              height: 20,
            ),
           ),

          Text(
          '${(currentDuration ~/ 60).toString().padLeft(2, '0')}:${(currentDuration % 60).toString().padLeft(2, '0')}',
          style: TextStyle(
            fontFamily: 'Fredoka',
              fontSize: 36,
              color: Colors.yellow[100]
          ),
        ),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: toggleTimer,
              child: Text(isRunning ? 'Pausar' : 'Comenzar',
              style: TextStyle(
                fontFamily: 'Fredoka',
                color: Colors.yellow[100],
              ),
              ),
            ),
            ColoredBox(
              color: Colors.redAccent,
              child: SizedBox(
                width: 20,
              ),
            ),
            ElevatedButton(
              onPressed: resetTimer,
              child: Text('Resetear',
              style: TextStyle(
                fontFamily: 'Fredoka',
                  color: Colors.yellow[100],
              ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BottomNavigationBarExampleApp extends StatelessWidget {
      const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    SingleChildScrollView(
      child: Container(
        color: Colors.deepPurple[50], //Background color for Home
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  '¡Una app para aprender!',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Image.asset('assets/images/Logo estudio creativo gradiente y minimalista fucsia y negro .png',
                  height: 200,
                  width: 400,
                ),
                Text(
                      'Este es un proyecto de las alumnas del 3ro de la media del Colegio Las Almenas en Asunción, Paraguay.\n'
                      '\nLas integrantes que conforman el equipo de desarrolladoras son: Fiorella Domínguez, Agustina Osorio, Paloma Frutos, Margarita Ramos y Sofía Islas.\n',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.blueGrey,
                    fontSize: 16,
                  ),
                ),
                Image.asset('assets/images/20231026_093951.jpg',
                  height: 200,
                  width: 300,
                ),
                Text(
                  '\nEn este proyecto se buscó poder desarrollar una aplicación móvil utilizando el SDK Flutter, y el lenguaje de programación de código abierto Dart, con el fin de promover la utilización de los métodos de estudio.\n'
                      '\nEl tema fue elegido en vista a que en la actualidad existe la creciente necesidad de la utilización de la tecnología en la educación, a manera de enriquecer la experiencia de aprendizaje y optimizar la administración de los recursos de manera eficaz.\n'
                      '\nEste proyecto consistió en conectar el ámbito educativo con la innovación tecnológica, permitiendo adquirir habilidades y ponerlas en práctica generando un producto, que a nuestro parecer, es necesario.\n',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.blueGrey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    SingleChildScrollView(
      child: Container(
        color: Colors.redAccent[100],
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  'Pomodoro Timer',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.yellow[100],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Image.asset('assets/images/20231026_102610_0000.png',
                  height: 100,
                  width: 100,

                ),
                Text(
                  '\n¿Ya probaste el método Pomodoro?\n'
                      '\nEl método Pomodoro consiste en la distribución del tiempo de estudio en intervalos de 25 minutos de trabajo y 5 minutos de descanso. Se caracteriza principalmente por la utilización de un "Timer" que ayuda a mejorar el rendimiento y a trabajar más eficientemente.\n',

                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.yellow[100],
                    fontSize: 16,
                  ),
                ),
                Image.asset('assets/images/compartir.png',
                  height: 200,
                  width: 300,
                ),

                PomodoroTimerWidget(),
              ],
            ),
          ),
        ),
      ),
    ),

    SingleChildScrollView(
      child: Container(
        color: Colors.green[100],
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  'Notas de Cornell',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Image.asset(
                  'assets/images/20231026_105324_0000.png',
                  height: 100,
                  width: 100,
                ),
                Text(
                  '\nEl método de Cornell es una técnica de estudio empleada para tomar apuntes facilitando la adquisición de datos gracias a su estructura que divide a la hija en tres secciones.\n'
                      '\n¿Cómo funciona este método?\n'
                      '\nEn el margen derecho se escriben las ideas más importantes de manera general mientras el profesor va explicando durante la clase. '
                      'A la izquierda se completan los apuntes principales con las notas más específicas y detalladas, para comprender y relacionar las distintas partes de nuestras anotaciones. '
                      'Es un modelo resumido y visual de la información para organizar grandes cantidades de datos que tienen conexiones entre sí bajo criterios fáciles de entender, interiorizar y recordar.\n',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.blueGrey,
                    fontSize: 16,
                  ),
                ),
                Image.asset('assets/images/cornellnotes.png',
                  height: 400,
                  width: 400,

                ),
                Text(
                  '\nVentajas del método de Cornell:',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '\n- Fomenta la escucha activa durante la clase'
                      '\n- Ayuda a retener la información'
                      '\n- Promueve la organización'
                      '\n- Es útil a la hora de repasar'
                      '\n- Constituye un material sencillo y completo',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.blueGrey,
                    fontSize: 16,
                  ),
                ),
                Image.asset('assets/images/ambiente.png',
                  height: 400,
                  width: 400,

                ),
              ],
            ),
          ),
        ),
      ),
     ),

    SingleChildScrollView(
      child: Container(
        color: Colors.lightBlue[100],
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  'Técnica de Feynman',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Image.asset('assets/images/20231026_110323_0000.png',
                    height: 100,
                    width: 100
                ),
                Text(
                  '\nEl método de Feynman conlleva cuatro pasos:\n'
                      '\nPrimer paso: Elegir el tema.\n'
                      '\nSegundo paso: Desarrollar y resumir ese tema en sus ideas más fundamentales en base a lo recordado.\n'
                      '\nTercer paso: Completar la información si es necesario.\n'
                      '\nCuarto paso: Cambiar todo lo escrito a una forma más simple y explicar o dar una clase sobre el tema a un alumno, que puede ser imaginario.',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.blueGrey,
                    fontSize: 16,
                  ),
                ),
                Image.asset('assets/images/Metodo Feynman.png',
                  height: 400,
                  width: 400,
                ),
                Text(
                  'Ventajas del método de Feynman:',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '\n- Fácil de entender'
                      '\n- Promueve la comprensión profunda'
                      '\n- Identifica las lagunas de conocimiento'
                      '\n- Contruye sesiones de estudio efectivas y eficientes'
                      '\n- Es aplicable a cualquier materia\n',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    color: Colors.blueGrey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),

    ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Muffin Study',
        style: TextStyle(
            fontFamily: 'Fredoka',
            color: Colors.blueGrey),
        ),
        backgroundColor: Colors.yellow[100],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Pomodoro',
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_sharp),
            label: 'Cornell',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_purple500_outlined),
            label: 'Feynman',
            backgroundColor: Colors.blueAccent,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow[100],
        onTap: _onItemTapped,
      ),
    );
  }
}
