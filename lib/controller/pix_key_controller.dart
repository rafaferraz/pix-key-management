import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pix_key/database/db_firestore.dart';
import 'package:pix_key/models/pix_key_model.dart';

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

  late FirebaseFirestore db;

  PixKeyController() {
    db = DBFirestore.get();
  }

  Future<void> addPixKey(PixKey key) async {
    String id = '';
    await db
        .collection('keys')
        .add(
          key.toJson(),
        )
        .then((value) => id = value.id);
    keys.add(key.copyWith(idCP: id));
    notifyListeners();
  }

  void getKeys() async {
    isLoading = true;
    keys.clear();
    final snapshot = await db.collection('keys').get();
    snapshot.docs
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
  }

  void editKey(PixKey pixKey) async {
    db.collection('keys').doc(pixKey.id).update(pixKey.toJson());
    int index = keys.indexWhere((element) => element.id == pixKey.id);
    keys[index] = pixKey;
    notifyListeners();
  }

  Future<void> deleteKey(PixKey pixKey) async {
    await db.collection('keys').doc(pixKey.id).delete();
    keys.removeWhere((emp) => emp.id == pixKey.id);
    notifyListeners();
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
