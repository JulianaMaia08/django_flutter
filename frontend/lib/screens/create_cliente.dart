import 'package:flutter/material.dart';
import 'package:my_app/services/api_service.dart';
import 'package:my_app/model/cliente_model.dart';

class CriarCliente extends StatefulWidget {
  const CriarCliente({Key? key}) : super(key: key);

  @override
  State<CriarCliente> createState() => _CriarClienteState();
}

class _CriarClienteState extends State<CriarCliente> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();

  void _salvarCliente() async {
    if (_formKey.currentState!.validate()) {
      // Cria objeto ClienteModel
      final cliente = ClienteModel(
        id: 0, // backend gera o ID
        nome: nomeController.text,
        cpf: cpfController.text,
        email: emailController.text,
        telefone: telefoneController.text,
      );

      // Chama o serviço para criar cliente
      await ApiService().createCliente(cliente);

      // Volta para Home e força recarregar lista
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criar Cliente")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: "Nome"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o nome" : null,
              ),
              TextFormField(
                controller: cpfController,
                decoration: const InputDecoration(labelText: "CPF"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o seu cpf" : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o email" : null,
              ),
              TextFormField(
                controller: telefoneController,
                decoration: const InputDecoration(labelText: "Telefone"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o telefone" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarCliente,
                child: const Text("Salvar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
