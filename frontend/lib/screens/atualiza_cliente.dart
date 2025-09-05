import 'package:flutter/material.dart';
import 'package:my_app/services/api_service.dart';
import 'package:my_app/model/cliente_model.dart';

class AtualizarCliente extends StatefulWidget {
  final ClienteModel cliente;

  const AtualizarCliente({Key? key, required this.cliente}) : super(key: key);

  @override
  State<AtualizarCliente> createState() => _AtualizarClienteState();
}


class _AtualizarClienteState extends State<AtualizarCliente> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();

  void _salvarCliente() async {
    if (_formKey.currentState!.validate()) {
      // Cria objeto ClienteModel
      final cliente = ClienteModel(
        id: widget.cliente.id, 
        nome: nomeController.text,
        cpf: widget.cliente.cpf,
        email: emailController.text,
        telefone: telefoneController.text,
      );

      // Chama o serviço para criar cliente
      await ApiService().atualizarCliente(cliente);

      // Volta para Home e força recarregar lista
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Atualizar Cliente")),
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
                    value!.isEmpty ? "Atualize o nome" : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Atualize o seu email" : null,
              ),
              TextFormField(
                controller: telefoneController,
                decoration: const InputDecoration(labelText: "Telefone"),
                validator: (value) =>
                    value!.isEmpty ? "Atualize o seu telefone" : null,
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
