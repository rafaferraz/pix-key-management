import 'package:flutter/material.dart';
import 'package:pix_key/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[1],
      appBar: AppBar(
        backgroundColor: colors[1],
        title: Text('Meu Pix'),
      ),
      body: Column(
        children: [
          // TODO: CRIAR WIDGET CHAVE
        ],
      ),
    );
  }
}
