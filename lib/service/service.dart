import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pix_key/models/pix_key_model.dart';

import 'db_firestore.dart';

class ServiceApplication {
  late FirebaseFirestore db;

  ServiceApplication({isTest = false}) {
    if (!isTest) {
      db = DBFirestore.get();
    }
  }

  Future<PixKey> addPixKey(PixKey key) async {
    String? id;
    await db
        .collection('keys')
        .add(
          key.toJson(),
        )
        .then((value) => id = value.id);
    return key.copyWith(idCP: id);
  }

  Future getKeys() async {
    final snap = await db.collection('keys').get();
    return snap.docs;
  }

  Future<bool> editPixKey(PixKey pixKey) async {
    try {
      await db.collection('keys').doc(pixKey.id).update(pixKey.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deletePixKey(PixKey pixKey) async {
    try {
      await db.collection('keys').doc(pixKey.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
