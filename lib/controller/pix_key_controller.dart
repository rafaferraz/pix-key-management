import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pix_key/models/pix_key_model.dart';
import 'package:pix_key/service/service.dart';

class PixKeyController extends ChangeNotifier {
  List<PixKey> keys = [];
  List<Bank> banks = [
    Bank(bankName: 'Nubank', color: Colors.purple[800]!),
    Bank(bankName: 'Banco Inter', color: Colors.orange),
    Bank(bankName: 'Sicoob', color: Colors.blueGrey[700]!),
    Bank(bankName: 'Banco BMG', color: Colors.orange[600]!),
    Bank(bankName: 'C6 Bank', color: Colors.grey[400]!),
    Bank(bankName: 'BTG +', color: Colors.black),
    Bank(bankName: 'WillBank', color: Colors.amber),
    Bank(bankName: 'Outro Banco', color: Colors.white),
  ];

  bool isLoading = false;
  ServiceApplication service;

  PixKeyController(this.service);

  Future<void> addPixKey(PixKey key) async {
    PixKey pixKeyRes = await service.addPixKey(key);
    keys.add(pixKeyRes);
    notifyListeners();
  }

  Future<List<PixKey>> getKeys() async {
    isLoading = true;
    keys.clear();
    final docs = await service.getKeys();
    docs
        .map(
          (element) => keys.add(
            PixKey.fromJson(
              element,
            ),
          ),
        )
        .toList();
    isLoading = false;
    notifyListeners();
    return keys;
  }

  Future<void> editKey(PixKey pixKey) async {
    bool res = await service.editPixKey(pixKey);
    if (res) {
      int index = keys.indexWhere((element) => element.id == pixKey.id);
      keys[index] = pixKey;
      notifyListeners();
    }
  }

  Future<void> deleteKey(PixKey pixKey) async {
    bool res = await service.deletePixKey(pixKey);
    if (res) {
      keys.removeWhere((emp) => emp.id == pixKey.id);
      notifyListeners();
    }
  }

  Color getColorBank(String bank) {
    return banks
        .firstWhere(
          (element) => element.bankName == bank,
          orElse: () => Bank(
            bankName: 'Default',
            color: Colors.cyan[50]!,
          ),
        )
        .color;
  }
}

class Bank {
  String bankName;
  Color color;

  Bank({
    required this.bankName,
    required this.color,
  });
}
