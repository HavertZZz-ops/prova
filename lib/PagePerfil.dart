// Tela 5: Perfil
// Widgets: Column, Container, BoxDecoration, SafeArea, Padding, Row,
// IconButton, Icon, Text, Card, ListTile, Divider, SizedBox,
// CircleAvatar, BorderRadius

import 'package:flutter/material.dart';

class PagePerfil extends StatelessWidget {
  const PagePerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cabeçalho verde com avatar e nome
        _construirCabecalho(context),

        // Opções do perfil
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _construirOpcao(
                  icone: Icons.person_outline,
                  titulo: 'Dados pessoais',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _construirOpcao(
                  icone: Icons.workspace_premium,
                  titulo: 'Certificados',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _construirOpcao(
                  icone: Icons.settings,
                  titulo: 'Configurações',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Cabeçalho verde com seta de voltar, título, avatar e nome
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
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 32),
          child: Column(
            children: [
              // Barra do topo: seta + título "Perfil"
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 24),
                    onPressed: () {},
                  ),
                  const Text(
                    'Perfil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Avatar circular com ícone de pessoa
              CircleAvatar(
                radius: 42,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 48,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),

              // Nome do aluno
              const Text(
                'Aluno IF',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Card de opção do perfil (Dados pessoais, Certificados, Configurações)
  Widget _construirOpcao({
    required IconData icone,
    required String titulo,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icone, color: const Color(0xFF2E7D32), size: 26),
        title: Text(
          titulo,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
