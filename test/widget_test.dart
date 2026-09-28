// Testes de widget do app "prova" (IF Sul de Minas).
//
// O template padrão do `flutter create` vem com um smoke test de contador que
// não se aplica a este projeto — aqui os testes cobrem a tela de login e a
// navegação para a tela principal.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:prova/main.dart';

void main() {
  testWidgets('App abre na tela de login', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    // A rota inicial é /login, então a tela de login deve estar montada.
    expect(find.text('Bem-vindo(a)!'), findsOneWidget);
    expect(find.text('ENTRAR'), findsOneWidget);
    expect(find.text('Usuário ou e-mail'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
  });

  testWidgets('Tela principal exibe os 4 itens da navegação inferior',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    // Entra direto na home, sem passar pela animação de rota do navigator.
    await tester.pumpWidget(
      const MaterialApp(home: TelaPrincipal(indiceInicial: 0)),
    );
    await tester.pumpAndSettle();

    // Escopa as buscas dentro da BottomNavigationBar: os mesmos rótulos também
    // aparecem no corpo das telas, então buscar no árbol inteiro contaria
    // duplicados.
    final nav = find.byType(BottomNavigationBar);
    expect(nav, findsOneWidget);

    for (final rotulo in ['Início', 'Cursos', 'Atividades', 'Perfil']) {
      expect(
        find.descendant(of: nav, matching: find.text(rotulo)),
        findsOneWidget,
        reason: 'esperava o item "$rotulo" na barra de navegação inferior',
      );
    }
  });

  testWidgets('Tocar em "Entrar" navega para a tela principal',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    await tester.tap(find.text('ENTRAR'));
    await tester.pumpAndSettle();

    expect(find.text('Bem-vindo(a)!'), findsNothing);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
