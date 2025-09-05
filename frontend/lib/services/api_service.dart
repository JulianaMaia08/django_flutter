import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/constants.dart';
import 'package:my_app/model/cliente_model.dart';

class ApiService {
  // Buscar clientes
  Future<List<ClienteModel>?> getClientes() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.clientesEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ClienteModel> clientes = userModelFromJson(response.body);
        return clientes;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Criar cliente
  Future<void> createCliente(ClienteModel cliente) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.clientesEndpoint);
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nome": cliente.nome,
          "cpf": cliente.cpf,
          "email": cliente.email,
          "telefone": cliente.telefone,
        }),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception("Erro ao criar cliente: ${response.body}");
      }
    } catch (e) {
      log(e.toString());
    }
  }
  Future<void> atualizarCliente(ClienteModel cliente) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.clientesEndpoint}${cliente.id}/");
      var response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nome": cliente.nome,
          "cpf": cliente.cpf,
          "email": cliente.email,
          "telefone": cliente.telefone,
        }),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception("Erro ao criar cliente: ${response.body}");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Deletar cliente
  Future<void> deleteCliente(int id) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.clientesEndpoint}$id/"); 
      var response = await http.delete(url);

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception("Erro ao deletar cliente: ${response.body}");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
