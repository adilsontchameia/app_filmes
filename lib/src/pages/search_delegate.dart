import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // Acoes do nosso app bar.
    //exe: icone para limpar o texto
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // algo que aparece no inicio, como icone de pesquisa a esquerda
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    //Instrucao que criar os resultados que mostraremos
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Sao as sugestoes que vao aparecer ao pesquisar
    throw UnimplementedError();
  }
}
