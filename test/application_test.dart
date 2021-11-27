import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pix_key/controller/pix_key_controller.dart';
import 'package:pix_key/models/pix_key_model.dart';

void main() {
  PixKeyController pixKeyController = PixKeyController(isNotTest: false);

  test('get Color Bank', () {
    Color expected = pixKeyController.getColorBank('Nubank');

    expect(
      expected,
      Colors.purple[800]!,
    );
  });

  group('Teste do Model PixKey', () {
    PixKey tPixKey = PixKey(
      bank: 'BTG +',
      key: '12345678900',
      id: 'abcd1234efgh5678',
    );

    test('fromJson', () {
      var dataPar = {"bank": 'BTG +', "key": '12345678900'};
      var idPar = 'abcd1234efgh5678';
      var pixKey = PixKey.fromJson(Aux(
        dataR: dataPar,
        id: idPar,
      ));

      expect(tPixKey, pixKey);
    });
  });
}

class Aux {
  String id;
  Map dataR;

  Aux({
    required this.dataR,
    required this.id,
  });

  data() {
    return this.dataR;
  }
}
