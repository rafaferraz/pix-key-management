import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pix_key/controller/pix_key_controller.dart';
import 'package:pix_key/models/pix_key_model.dart';
import 'package:pix_key/service/service.dart';

void main() {
  late PixKeyController controller;

  setUp(() {
    controller = PixKeyController(ServiceApplication(isTest: true));
  });

  group('get Colors', () {
    test('get Color Bank, when bank exist', () {
      Color expected = controller.getColorBank('Nubank');

      expect(
        expected,
        Colors.purple[800]!,
      );
    });

    test('get Color Bank, when bank not exist', () {
      Color expected = controller.getColorBank('Caixa Econômica Federal');

      expect(
        expected,
        Colors.cyan[50]!,
      );
    });
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

    test('toJson', () {
      var dataJson = {"bank": 'BTG +', "key": '12345678900'};
      var tJson = tPixKey.toJson();

      expect(tJson, dataJson);
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
