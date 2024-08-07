import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/auth.service.dart';
import '../../services/keys/keys.dart';

final db = FirebaseFirestore.instance;
final uid = AuthServiceHandler.getCurrentUser()?.uid;

class DatabaseHandler {
  void initializer() {
    final doc = db.collection("users").doc(uid);
    final mandatoryData = <String, dynamic>{
      "uid": uid,
      "secretKey": firebaseSecretKey,
    };
    doc.collection("notes");
    doc.collection("todos");
  }

  static Future<void> syncUserTodos(BuildContext buildContext, String context,
      String description, bool isFav) async {
    try {
      final data = <String, dynamic>{
        "uid": uid,
        "context": context,
        "description": description,
        "timestamp": Timestamp.now(),
        "isBookmarked": isFav,
        "secretKey": firebaseSecretKey,
      };
      DocumentReference ref =
          await db.collection("users").doc(uid).collection("todos").add(data);
      await ref.update({"docID": ref.id});
    } on FirebaseException catch (e) {
      if (buildContext.mounted) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(content: Text('Failed to add Todo: ${e.message}')),
        );
      }
    } catch (e) {
      if (buildContext.mounted) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  static Future<void> syncUserNotes(BuildContext buildContext, String context,
      String description, bool isFav) async {
    try {
      final data = <String, dynamic>{
        "uid": uid,
        "context": context,
        "description": description,
        "timestamp": Timestamp.now(),
        "isBookmarked": isFav,
        "secretKey": firebaseSecretKey,
      };
      DocumentReference ref =
          await db.collection("users").doc(uid).collection("notes").add(data);
      await ref.update({"docID": ref.id});
    } on FirebaseException catch (e) {
      if (buildContext.mounted) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(content: Text('Failed to add Todo: ${e.message}')),
        );
      }
    } catch (e) {
      if (buildContext.mounted) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> todoStream() {
    final stream = db
        .collection("users")
        .doc(uid)
        .collection("todos")
        .orderBy('timestamp', descending: true);
    return stream.snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> noteStream() {
    final stream = db
        .collection("users")
        .doc(uid)
        .collection("notes")
        .orderBy('timestamp', descending: true);
    return stream.snapshots();
  }
}
