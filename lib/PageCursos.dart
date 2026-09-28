// Tela 3: Cursos
// Widgets: Column, Container, BoxDecoration, SafeArea, Padding, Row,
// IconButton, Icon, Text, TextField, InputDecoration, Expanded,
// ListView.builder, Card, SizedBox, LinearProgressIndicator,
// ClipRRect, BorderRadius

import 'package:flutter/material.dart';

class PageCursos extends StatelessWidget {
  const PageCursos({super.key});

  // Lista de cursos (dados simulados)
  static final List<Map<String, dynamic>> _cursos = [
    {
      'titulo': 'Desenvolvimento Mobile',
      'subtitulo': 'Kotlin e Android',
      'icone': Icons.android,
      'corIcone': Colors.green[700]!,
      'progresso': 0.60,
    },
    {
      'titulo': 'Flutter',
      'subtitulo': 'Desenvolvimento Cross-Platform',
      'icone': Icons.flutter_dash,
      'corIcone': Colors.blue,
      'progresso': 0.40,
    },
    {
      'titulo': 'Java',
      'subtitulo': 'Programação Orientada a Objetos',
      'icone': Icons.coffee,
      'corIcone': Colors.red[700]!,
      'progresso': 0.30,
    },
    {
      'titulo': 'Python',
      'subtitulo': 'Lógica e Programação',
      'icone': Icons.data_object,
      'corIcone': Colors.amber[700]!,
      'progresso': 0.20,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cabeçalho verde com título "Cursos"
        _construirCabecalho(context),

        // Campo de busca
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar cursos...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.close),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),

        // Lista de cursos
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _cursos.length,
            itemBuilder: (context, index) {
              return _construirCardCurso(_cursos[index]);
            },
          ),
        ),
      ],
    );
  }

  /// Cabeçalho verde com seta de voltar e título
  Widget _construirCabecalho(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF2E7D32),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 24),
                    onPressed: () {},
                  ),
                  const Text(
                    'Cursos',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white, size: 28),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Card de curso com ícone, título, subtítulo e barra de progresso
  Widget _construirCardCurso(Map<String, dynamic> curso) {
    final int porcentagem = (curso['progresso'] * 100).toInt();

    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Ícone circular do curso
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: (curso['corIcone'] as Color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                curso['icone'],
                color: curso['corIcone'],
                size: 28,
              ),
            ),
            const SizedBox(width: 14),

            // Informações do curso + barra de progresso
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    curso['titulo'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    curso['subtitulo'],
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Barra de progresso
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: curso['progresso'],
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF2E7D32),
                            ),
                            minHeight: 8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '$porcentagem%',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Seta
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
