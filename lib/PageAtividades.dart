// Tela 4: Atividades
// Widgets: Column, Container, BoxDecoration, SafeArea, Padding, Row,
// IconButton, Icon, Text, TextField, InputDecoration, ChoiceChip,
// SingleChildScrollView, Expanded, ListView.builder, Card, SizedBox,
// BorderRadius

import 'package:flutter/material.dart';

class PageAtividades extends StatefulWidget {
  const PageAtividades({super.key});

  @override
  State<PageAtividades> createState() => _PageAtividadesState();
}

class _PageAtividadesState extends State<PageAtividades> {
  // Filtro selecionado
  String _filtroSelecionado = 'Todas';

  // Lista de filtros
  final List<String> _filtros = [
    'Todas',
    'Pendentes',
    'Concluídas',
    'Importantes',
  ];

  // Lista de atividades (dados simulados)
  final List<Map<String, dynamic>> _atividades = [
    {
      'titulo': 'Exercício de Kotlin',
      'prazo': 'Hoje',
      'status': 'Pendente',
    },
    {
      'titulo': 'Projeto Flutter',
      'prazo': '28/09',
      'status': 'Pendente',
    },
    {
      'titulo': 'Quiz - Componentes',
      'prazo': '25/09',
      'status': 'Concluída',
    },
    {
      'titulo': 'Desenvolvimento Mobile',
      'prazo': '30/09',
      'status': 'Pendente',
    },
    {
      'titulo': 'Lógica de Programação',
      'prazo': '05/10',
      'status': 'Pendente',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cabeçalho verde
        _construirCabecalho(),

        // Campo de busca
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar atividades...',
              prefixIcon: const Icon(Icons.search),
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

        // Chips de filtro
        _construirFiltros(),

        // Lista de atividades
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _atividades.length,
            itemBuilder: (context, index) {
              return _construirCardAtividade(_atividades[index]);
            },
          ),
        ),
      ],
    );
  }

  /// Cabeçalho verde com título e subtítulo
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
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 4),
              const Text(
                'Atividades',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Acompanhe suas tarefas e\nmantenha seu progresso.',
                style: TextStyle(
                  fontSize: 14,
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

  /// Linha horizontal de chips de filtro
  Widget _construirFiltros() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _filtros.map((filtro) {
            final selecionado = _filtroSelecionado == filtro;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(filtro),
                selected: selecionado,
                selectedColor: const Color(0xFF2E7D32),
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: selecionado ? Colors.white : Colors.black87,
                  fontWeight:
                      selecionado ? FontWeight.bold : FontWeight.normal,
                ),
                onSelected: (selected) {
                  setState(() {
                    _filtroSelecionado = filtro;
                  });
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Card individual de atividade
  Widget _construirCardAtividade(Map<String, dynamic> atividade) {
    final bool pendente = atividade['status'] == 'Pendente';

    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          children: [
            // Ícone circular
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                pendente ? Icons.description : Icons.check_circle,
                color: const Color(0xFF2E7D32),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),

            // Título + prazo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    atividade['titulo'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        'Prazo: ${atividade['prazo']}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Chip de status
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: pendente ? Colors.red[50] : Colors.green[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                atividade['status'],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: pendente ? Colors.red[400] : Colors.green[700],
                ),
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }
}
