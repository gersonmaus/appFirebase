import 'package:flutter/material.dart';
import '../model/aluno.dart';
import '../presenter/aluno_presenter.dart';
import 'aluno_view.dart';
import 'aluno_form_page.dart';

// Define uma página que exibe uma lista de alunos e permite adicionar novos alunos
class AlunoPage extends StatefulWidget {
  @override
  _AlunoPageState createState() => _AlunoPageState();
}

// Define o estado da página de lista de alunos, implementando a interface AlunoView
class _AlunoPageState extends State<AlunoPage> implements AlunoView {
  // O presenter responsável por buscar e adicionar alunos
  late AlunoPresenter presenter;

  // Lista de alunos exibida na página
  List<Aluno> alunos = [];

  // Mensagem de erro que pode ser exibida na página
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    // Inicializa o presenter e busca os alunos
    presenter = AlunoPresenter(this);
    presenter
        .fetchAlunos(); // Faz a requisição para buscar os alunos no backend
  }

  // Método que atualiza a lista de alunos exibida
  @override
  void displayAlunos(List<Aluno> alunos) {
    setState(() {
      this.alunos = alunos; // Atualiza a lista de alunos
      errorMessage = ''; // Limpa qualquer mensagem de erro
    });
  }

  // Método que exibe uma mensagem de erro se a requisição falhar
  @override
  void showError(String error) {
    setState(() {
      errorMessage = error; // Atualiza a mensagem de erro a ser exibida
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Alunos'), // Título da página
        actions: [
          // Botão para adicionar um novo aluno
          IconButton(
            icon: Icon(Icons.add), // Ícone de adicionar
            onPressed: () async {
              // Abre a tela de cadastro de aluno
              bool? alunoAdicionado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlunoFormPage(presenter: presenter),
                ),
              );

              // Se o aluno foi adicionado com sucesso, atualiza a lista de alunos
              if (alunoAdicionado == true) {
                presenter.fetchAlunos(); // Recarrega a lista de alunos
              }
            },
          ),
        ],
      ),

      // Verifica se há uma mensagem de erro. Caso contrário, exibe a lista de alunos.
      body: errorMessage.isEmpty
          ? ListView.builder(
              itemCount: alunos.length, // Número de itens na lista
              itemBuilder: (context, index) {
                // Para cada aluno, exibe uma linha com o nome, idade e turma
                return ListTile(
                  title: Text(alunos[index].nome), // Nome do aluno
                  subtitle: Text(
                    'Idade: ${alunos[index].idade} | Turma: ${alunos[index].turma}', // Detalhes do aluno
                  ),
                );
              },
            )
          : Center(
              child: Text(errorMessage)), // Exibe a mensagem de erro, se houver
    );
  }
}
