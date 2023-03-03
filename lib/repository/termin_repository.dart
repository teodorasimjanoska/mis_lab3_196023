import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:lab3_mis_196023/model/termin.dart';

class TerminRepository {
  final _fireCloud = FirebaseFirestore.instance.collection('termini');

  Future<void> create(
      {required String id,
      required String predmet,
      required DateTime datum,
      required String userId}) async {
    try {
      await _fireCloud.add({
        "termin id": id,
        'predmet': predmet,
        'datum': datum,
        'user id': userId,
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Termin>> get() async {
    final user = FirebaseAuth.instance.currentUser!;
    List<Termin> termini = [];
    try {
      final term = await FirebaseFirestore.instance
          .collection("termini")
          .where("user id", isEqualTo: user.uid)
          .get();
      term.docs.forEach((element) {
        return termini.add(Termin.fromJson(element.data()));
      });

      return termini;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return termini;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
