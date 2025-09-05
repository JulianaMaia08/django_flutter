import 'package:flutter/material.dart';
import 'package:my_app/model/cliente_model.dart';
import 'package:my_app/services/api_service.dart';
import 'package:my_app/screens/create_cliente.dart';
import 'package:my_app/screens/atualiza_cliente.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ClienteModel>? _clienteModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _clienteModel = await ApiService().getClientes();
    setState(() {});
  }

  void _deleteCliente(int id) async {
    await ApiService().deleteCliente(id);
    _getData(); // atualiza lista
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: _clienteModel == null || _clienteModel!.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _clienteModel!.length,
              itemBuilder: (context, index) {
                final cliente = _clienteModel![index];
                return Card(
                  child: ListTile(
                    leading: Text(cliente.id.toString()),
                    title: Text(cliente.nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cliente.cpf),
                        Text(cliente.email),
                        Text(cliente.telefone),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            final recarregar = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AtualizarCliente(cliente: cliente),
                              ),
                            );

                            if (recarregar == true) {
                              _getData();
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteCliente(cliente.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final recarregar = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CriarCliente()),
          );

          if (recarregar == true) {
            _getData();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
