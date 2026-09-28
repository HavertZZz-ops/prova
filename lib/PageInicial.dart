// Tela 2: Página Inicial (Home)
// Widgets: Column, Container, BoxDecoration, SafeArea, Padding, Row,
// IconButton, Icon, Text, Expanded, SingleChildScrollView, Card,
// SizedBox, BorderRadius

import 'package:flutter/material.dart';

class PageInicial extends StatelessWidget {
  const PageInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cabeçalho verde curvado
        _construirCabecalho(),

        // Cards de resumo
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _construirCardResumo(
                  icone: Icons.menu_book,
                  titulo: 'Meus Cursos',
                  subtitulo: '5 cursos em andamento',
                ),
                const SizedBox(height: 16),
                _construirCardResumo(
                  icone: Icons.assignment,
                  titulo: 'Atividades',
                  subtitulo: '12 tarefas pendentes',
                ),
                const SizedBox(height: 16),
                _construirCardResumo(
                  icone: Icons.emoji_events,
                  titulo: 'Certificados',
                  subtitulo: '3 certificados conquistados',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Cabeçalho verde com saudação
  Widget _construirCabecalho() {
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
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu hamburger + sino de notificação
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined,
                        color: Colors.white, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Olá, Dev!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Pronto para aprender\ne transformar ideias\nem soluções?',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Card de resumo com ícone, título e subtítulo
  Widget _construirCardResumo({
    required IconData icone,
    required String titulo,
    required String subtitulo,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            // Ícone circular
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icone, color: const Color(0xFF2E7D32), size: 28),
            ),
            const SizedBox(width: 16),
            // Textos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitulo,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
