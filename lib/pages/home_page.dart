import 'package:flutter/material.dart';
import 'package:pix_key/controller/pix_key_controller.dart';
import 'package:pix_key/models/pix_key_model.dart';
import 'package:pix_key/utils.dart';
import 'package:pix_key/widgets/widgets.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<PixKeyController>().getKeys();
    super.initState();
  }

  TextEditingController textController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  Bank? selectedBank;

  @override
  Widget build(BuildContext context) {
    PixKeyController controller = context.watch<PixKeyController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff083863),
        title: Text('Meu Pix'),
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: controller.keys.isEmpty ? 1 : controller.keys.length,
              itemBuilder: (context, index) {
                if (controller.keys.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          size: 35,
                          color: Colors.amber[900],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Nenhuma chave foi encontrado.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  );
                }
                PixKey pixKey = controller.keys[index];
                return PixKeyTile(
                  pixKey: pixKey,
                  color: controller.getColorBank(pixKey.bank),
                  controller: controller,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff083863),
        onPressed: () => addDialog(context, controller),
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => null,
        //   ),
        // ),
        child: const Icon(Icons.add),
        tooltip: 'Adicionar Serviço',
      ),
    );
  }

  Future<void> addDialog(context, PixKeyController controller) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nova Chave'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFieldPattern(
                  label: 'Chave',
                  controller: textController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<Bank>(
                      decoration: const InputDecoration(
                        labelText: 'Banco',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff083863),
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Color(0xff083863),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff083863),
                          ),
                        ),
                      ),
                      value: selectedBank,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 18,
                      elevation: 16,
                      validator: (value) {
                        if (value == null) {
                          return 'Selecione o banco';
                        }
                        return null;
                      },
                      onChanged: (Bank? bank) {
                        setState(() {
                          selectedBank = bank;
                          bankNameController.text = bank!.bankName;
                          if (selectedBank != null &&
                              selectedBank!.bankName == 'Outro Banco') {
                            bankNameController.text = '';
                          }
                          Navigator.of(context).pop();
                          addDialog(context, controller);
                        });
                      },
                      items: controller.banks
                          .map<DropdownMenuItem<Bank>>((Bank bank) {
                        return DropdownMenuItem<Bank>(
                          value: bank,
                          child: Text(
                            bank.bankName,
                            style: const TextStyle(
                              color: Color(0xff083863),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                if (selectedBank != null &&
                    selectedBank!.bankName == 'Outro Banco')
                  TextFieldPattern(
                    label: 'Banco',
                    controller: bankNameController,
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar',
                  style: TextStyle(color: Color(0xff083863))),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Adicionar',
                  style: TextStyle(color: Color(0xff083863))),
              onPressed:
                  textController.text == '' || bankNameController.text == ''
                      ? null
                      : () async {
                          await controller.addPixKey(
                            PixKey(
                              key: textController.text,
                              bank: bankNameController.text,
                            ),
                          );
                          setState(() {
                            textController.text = '';
                            selectedBank = null;
                            bankNameController.text = '';
                          });
                          Navigator.of(context).pop();
                        },
            ),
          ],
        );
      },
    );
  }
}
