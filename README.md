# prova — App Flutter "IF Sul de Minas"

App mobile/desktop multiplataforma de academicismo, feito em **Flutter**. Simula o
portal do aluno do **Instituto Federal Sul de Minas**: login, cursos com progresso,
atividades, e perfil.

Todos os dados são **simulados (mockados) no próprio código** — não há back-end,
banco de dados nem API. O objetivo do projeto é a camada de interface e navegação.

---

## Índice

- [Stack](#stack)
- [Como rodar](#como-rodar)
- [Estrutura do projeto](#estrutura-do-projeto)
- [Arquitetura e navegação](#arquitetura-e-navegação)
- [Função de cada arquivo](#função-de-cada-arquivo)
- [Widgets do Material usados](#widgets-do-material-usados)
- [Testes](#testes)
- [Dívidas técnicas conhecidas](#dívidas-técnicas-conhecidas)
- [Requisitos de ambiente](#requisitos-de-ambiente)

---

## Stack

| Item | Versão / valor |
|---|---|
| Flutter | 3.41.9 (stable) |
| Dart | 3.11.5 |
| Material Design | 3 (`useMaterial3: true`) |
| Dependências | apenas `cupertino_icons` |

A única dependência de terceiros é `cupertino_icons`. O restante do app usa
somente a biblioteca nativa do Flutter — por isso a seção `dev_dependencies` só
tem `flutter_test` e `flutter_lints`.

---

## Como rodar

```bash
# 1. Instalar as dependências
flutter pub get

# 2. Ver os dispositivos disponíveis
flutter devices

# 3. Rodar (escolha um destino)
flutter run                 # dispositivo conectado
flutter run -d chrome       # web
flutter run -d windows      # Windows (exige Visual Studio, ver abaixo)
```

Outros comandos úteis:

```bash
flutter analyze   # análise estática (lint)
flutter test      # roda os testes
flutter build web --release   # build de produção para web
```

---

## Estrutura do projeto

```
prova/
├── lib/                     # todo o código do app
│   ├── main.dart            # ponto de entrada + navegação
│   ├── Pagelogin.dart       # tela 1: login
│   ├── PageInicial.dart     # tela 2: home
│   ├── PageCursos.dart      # tela 3: cursos
│   ├── PageAtividades.dart  # tela 4: atividades
│   └── PagePerfil.dart      # tela 5: perfil
├── test/
│   └── widget_test.dart     # 3 testes de widget
├── android/                 # gerado por flutter create
├── ios/
├── web/
├── windows/
├── linux/
├── macos/
├── pubspec.yaml             # metadados e dependências
└── analysis_options.yaml    # regras de lint
```

---

## Arquitetura e navegação

O app usa **dois mecanismos de navegação** que trabalham juntos.

### 1. Rotas nomeadas — login → home

Definidas no `MeuApp` (`lib/main.dart`):

| Rota | Widget | Quando aparece |
|---|---|---|
| `/login` | `PageLogin` | rota inicial (`initialRoute`) |
| `/home` | `TelaPrincipal(indiceInicial: 0)` | destino do botão ENTRAR |
| `/cursos` | `TelaPrincipal(indiceInicial: 1)` | acesso direto por rota |
| `/atividades` | `TelaPrincipal(indiceInicial: 2)` | acesso direto por rota |
| `/perfil` | `TelaPrincipal(indiceInicial: 3)` | acesso direto por rota |

A transição do login para a home usa
`Navigator.pushReplacementNamed(context, '/home')` — o *replacement* significa que
a tela de login é **substituída** (e não empilhada), para o botão "voltar" do
Android não retornar ao formulário de login.

### 2. `BottomNavigationBar` — dentro da home

`TelaPrincipal` é um `StatefulWidget` que guarda `_indiceSelecionado` e troca o
corpo da tela conforme o toque na barra inferior:

```dart
final List<Widget> _telas = const [
  PageInicial(),     // índice 0
  PageCursos(),      // índice 1
  PageAtividades(),  // índice 2
  PagePerfil(),      // índice 3
];
```

O parâmetro `indiceInicial` define em qual aba a tela abre. As quatro rotas
`/cursos`, `/atividades` e `/perfil` existem justamente para permitir abrir
direto numa aba específica.

### Fluxo visual

```
        PageLogin
            │  (botão ENTRAR)
            ▼
      TelaPrincipal  ◄── BottomNavigationBar troca o corpo
       ├─ Início     → PageInicial
       ├─ Cursos     → PageCursos
       ├─ Atividades → PageAtividades
       └─ Perfil     → PagePerfil
```

### Tema

Cor institucional verde `#2E7D32` aplicada via `ColorScheme.fromSeed`, com
`onPrimary: Colors.white` e fundo branco (`scaffoldBackgroundColor`).

---

## Função de cada arquivo

### `lib/main.dart`

Ponto de entrada. Faz três coisas:

1. **`main()`** — chama `runApp(const MeuApp())`.
2. **`MeuApp`** — o `MaterialApp`. Configura tema, título (`IF Sul de Minas`),
   desliga a faixa de debug (`debugShowCheckedModeBanner: false`) e declara as
   rotas nomeadas.
3. **`TelaPrincipal`** — o container com a `BottomNavigationBar`, descrito acima.

### `lib/Pagelogin.dart` — tela 1

Formulário de acesso. É a única tela `StatefulWidget` com controllers de texto.

| Elemento | Implementação |
|---|---|
| Campos usuário e senha | `TextField` com `TextEditingController` |
| Mostrar/ocultar senha | `IconButton` alternando `_senhaVisivel`, que controla `obscureText` |
| Lembrar-me | `Checkbox` com `activeColor` verde |
| Entrar | `ElevatedButton` → `pushReplacementNamed('/home')` |

O `dispose()` descarta os dois controllers, evitando vazamento de memória. O
formulário está dentro de `SingleChildScrollView` para funcionar em telas baixas
(com o teclado aberto).

### `lib/PageInicial.dart` — tela 2 (Home)

Cabeçalho verde curvado (só os cantos de baixo arredondados) com saudação, e
três cards de resumo: **Meus Cursos**, **Atividades** e **Certificados**. Cada
card mostra ícone circular, título, subtítulo e uma seta `chevron_right`.

É `StatelessWidget` porque não tem dado mutável.

### `lib/PageCursos.dart` — tela 3

Lista de cursos com barra de progresso. Os dados ficam numa lista estática
`_cursos`, onde cada item é um `Map<String, dynamic>` com `titulo`, `subtitulo`,
`icone`, `corIcone` e `progresso` (de `0.0` a `1.0`).

O percentual exibido é calculado em runtime: `final int porcentagem =
(curso['progresso'] * 100).toInt();`. A barra usa `LinearProgressIndicator`
dentro de um `ClipRRect` para arredondar as pontas.

Usa `ListView.builder`, que constrói os cards **sob demanda** em vez de todos de
uma vez.

### `lib/PageAtividades.dart` — tela 4

Lista de atividades com filtro por chips. É `StatefulWidget` porque o filtro
selecionado é estado mutável: `_filtroSelecionado`.

Os chips (`Todas`, `Pendentes`, `Concluídas`, `Importantes`) são `ChoiceChip`
num `SingleChildScrollView` horizontal. O chip selecionado fica verde com texto
branco; os outros ficam cinza.

**Atenção:** o filtro muda só a aparência do chip. Ele **não** filtra a lista de
atividades — `_construirCardAtividade` recebe `_atividades[index]` sem aplicar
nenhum `where`. Ver [dívidas técnicas](#dívidas-técnicas-conhecidas).

O status do card (pendente ou concluída) é derivado dos dados:
`final bool pendente = atividade['status'] == 'Pendente';`, o que troca o ícone
(`Icons.description` vs `Icons.check_circle`) e a cor do chip.

### `lib/PagePerfil.dart` — tela 5

Cabeçalho com `CircleAvatar` e nome "Aluno IF", mais três opções em `Card` +
`ListTile`: **Dados pessoais**, **Certificados** e **Configurações**.

É o exemplo mais limpo de extração de widget repetido no projeto: o método
`_construirOpcao({icone, titulo, onTap})` é chamado três vezes, cada uma com
parâmetros diferentes. As funções começam com underscore (`_`) para sinalizar
que são privadas ao arquivo.

---

## Widgets do Material usados

O projeto foi feito para praticar uma gama específica de widgets. Cada arquivo
tem um comentário no topo listando os seus.

| Arquivo | Widgets exercitados |
|---|---|
| `Pagelogin.dart` | `Scaffold`, `SafeArea`, `SingleChildScrollView`, `Column`, `Row`, `Container`, `Icon`, `Text`, `TextField`, `InputDecoration`, `Checkbox`, `ElevatedButton`, `OutlinedButton`, `TextButton`, `IconButton`, `SizedBox`, `Padding`, `BoxDecoration`, `RoundedRectangleBorder` |
| `PageInicial.dart` | `Column`, `Container`, `BoxDecoration`, `SafeArea`, `Padding`, `Row`, `IconButton`, `Icon`, `Text`, `Expanded`, `SingleChildScrollView`, `Card`, `SizedBox`, `BorderRadius` |
| `PageCursos.dart` | `Column`, `Container`, `BoxDecoration`, `SafeArea`, `Padding`, `Row`, `IconButton`, `Icon`, `Text`, `TextField`, `InputDecoration`, `Expanded`, `ListView.builder`, `Card`, `SizedBox`, `LinearProgressIndicator`, `ClipRRect`, `BorderRadius` |
| `PageAtividades.dart` | `Column`, `Container`, `BoxDecoration`, `SafeArea`, `Padding`, `Row`, `IconButton`, `Icon`, `Text`, `TextField`, `InputDecoration`, `ChoiceChip`, `SingleChildScrollView`, `Expanded`, `ListView.builder`, `Card`, `SizedBox`, `BorderRadius` |
| `PagePerfil.dart` | `Column`, `Container`, `BoxDecoration`, `SafeArea`, `Padding`, `Row`, `IconButton`, `Icon`, `Text`, `Card`, `ListTile`, `Divider`, `SizedBox`, `CircleAvatar`, `BorderRadius` |

### Conceitos de Flutter usados

- **Widgets imutáveis** — todo construtor é `const`; quase tudo é `StatelessWidget`.
- `StatelessWidget` vs `StatefulWidget` — só duas telas precisam de estado
  (`Pagelogin` para os controllers e a visibilidade da senha; `PageAtividades`
  para o filtro). A home também é stateful, por causa do índice da barra.
- **Composição sobre herança** — cada tela monta um `Column` (cabeçalho fixo +
  conteúdo rolável) em vez de estender uma classe base.
- **Chaves de widget** — `super.key` no construtor de cada widget.
- `withOpacity()` para aplicar alfa a cores (hoje deprecated, ver abaixo).

---

## Testes

`test/widget_test.dart` tem 3 testes de widget:

| Teste | O que verifica |
|---|---|
| `App abre na tela de login` | a rota inicial é `/login` e os campos existem |
| `Tela principal exibe os 4 itens da navegação inferior` | Início, Cursos, Atividades e Perfil estão na barra |
| `Tocar em "Entrar" navega para a tela principal` | o login some e a `BottomNavigationBar` aparece |

```bash
flutter test
```

Resultado atual: **3/3 passando**.

Detalhe que vale registrar no segundo teste: as buscas são escopadas com
`find.descendant(of: nav, matching: find.text(rotulo))`. Sem isso, "Atividades"
seria encontrado duas vezes — uma na barra e outra no corpo da `PageInicial` — e
a asserção `findsOneWidget` falharia.

---

## Dívidas técnicas conhecidas

Nada aqui quebra o app, mas são pontos a corrigir:

1. **Filtro de atividades não filtra.** Em `PageAtividades.dart`, trocar o chip
   muda só o destaque visual; a lista exibida continua completa. Para filtrar de
   verdade, o `itemBuilder` precisaria aplicar um `where` sobre `_atividades`
   conforme `_filtroSelecionado`.
2. **Busca não funciona.** Os `TextField` de `PageCursos` e `PageAtividades` são
   decorativos: não têm `controller` e o texto digitado não é lido em lugar
   algum.
3. **Botões sem ação.** Vários `onPressed: () {}` vazios: "Esqueceu a senha",
   "Criar uma conta", os dois botões de login social, o menu hamburger, o sino de
   notificação e a seta de voltar em Cursos/Perfil.
4. **`withOpacity()` está deprecated** no Flutter 3.41 (6 ocorrências). A
   substituição é `.withValues(alpha: 0.1)`, que evita perda de precisão.
5. **Nomes de arquivo fora do padrão Dart.** A convenção é
   `lower_case_with_underscores`; os arquivos usam PascalCase (`PageInicial.dart`).
   Renomear exige atualizar todos os `import` de `main.dart`.
6. **Dados mockados em código.** Não há camada de repositório nem separação
   modelo/view — os dados estão como `List<Map<String, dynamic>>` dentro dos
   widgets.
7. **Sem tratamento de erro.** O login aceita qualquer usuário e senha; não há
   validação, nem estado de carregamento, nem mensagem de falha.

`flutter analyze` reporta 11 `info` — 5 do item 5 e 6 do item 4. **Nenhum erro.**

---

## Requisitos de ambiente

Verificado com `flutter doctor` nesta máquina:

| Componente | Estado |
|---|---|
| Flutter 3.41.9 (stable) | OK |
| Dart 3.11.5 | OK |
| Chrome (para web) | OK |
| **Visual Studio** | **ausente** — bloqueia `flutter run -d windows` |
| **Android SDK** | **ausente** — bloqueia `flutter run -d android` |

Para rodar em **Windows**, instale o Visual Studio com a workload
*"Desktop development with C++"* e todos os componentes padrão. Para rodar em
**Android**, instale o Android Studio (que traz o SDK).

Sem esses dois, o app roda normalmente em **web** (`flutter run -d chrome`).
