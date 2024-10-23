import 'package:flutter/material.dart';

import 'view/aluno_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Alunos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlunoPage(),
    );
  }
}
