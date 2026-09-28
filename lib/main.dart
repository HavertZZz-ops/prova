import 'package:flutter/material.dart';
import 'Pagelogin.dart';
import 'PageInicial.dart';
import 'PageCursos.dart';
import 'PageAtividades.dart';
import 'PagePerfil.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IF Sul de Minas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          primary: const Color(0xFF2E7D32),
          onPrimary: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const PageLogin(),
        '/home': (context) => const TelaPrincipal(indiceInicial: 0),
        '/cursos': (context) => const TelaPrincipal(indiceInicial: 1),
        '/atividades': (context) => const TelaPrincipal(indiceInicial: 2),
        '/perfil': (context) => const TelaPrincipal(indiceInicial: 3),
      },
    );
  }
}

/// Widget que gerencia a navegação entre as telas principais
/// usando BottomNavigationBar
class TelaPrincipal extends StatefulWidget {
  final int indiceInicial;
  const TelaPrincipal({super.key, this.indiceInicial = 0});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  late int _indiceSelecionado;

  // Lista de telas que serão exibidas
  final List<Widget> _telas = const [
    PageInicial(),
    PageCursos(),
    PageAtividades(),
    PagePerfil(),
  ];

  @override
  void initState() {
    super.initState();
    _indiceSelecionado = widget.indiceInicial;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceSelecionado],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceSelecionado,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey,
        onTap: (indice) {
          setState(() {
            _indiceSelecionado = indice;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Cursos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Atividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
