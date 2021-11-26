import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pix_key/database/db_firestore.dart';
import 'package:pix_key/models/pix_key_model.dart';

class PixKeyController extends ChangeNotifier {
  List<PixKey> keys = [];
  bool isLoading = false;

  late FirebaseFirestore db;

  PixKeyController() {
    db = DBFirestore.get();
  }

  addPixKey(PixKey key) async {
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
    notifyListeners();
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

  void deleteKey(PixKey pixKey) async {
    await db.collection('keys').doc(pixKey.id).delete();
    keys.removeWhere((emp) => emp.id == pixKey.id);
    notifyListeners();
  }
}
