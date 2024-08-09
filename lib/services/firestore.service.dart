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
    doc.collection("notes").add(mandatoryData);
    doc.collection("todos").add(mandatoryData);
  }

  static Future<void> syncUserTodos(
      BuildContext buildContext, String context, String description) async {
    try {
      final data = <String, dynamic>{
        "uid": uid,
        "context": context,
        "description": description,
        "timestamp": Timestamp.now(),
        "isBookmarked": false,
        "completionStatus": false,
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

  static Future<void> deleteUserTodos(
      BuildContext buildContext, String docID) async {
    try {
      db.collection("users").doc(uid).collection("todos").doc(docID).delete();
    } on FirebaseException catch (e) {
      if (buildContext.mounted) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(content: Text('Failed to Delete Todo: ${e.message}')),
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

  static Future<void> deleteUserNotes(
      BuildContext buildContext, String docID) async {
    try {
      db.collection("users").doc(uid).collection("notes").doc(docID).delete();
    } on FirebaseException catch (e) {
      if (buildContext.mounted) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(content: Text('Failed to Delete Note: ${e.message}')),
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

  static Future<void> updateUserNotes(BuildContext buildContext, String context,
      String description, String docID) async {
    try {
      final data = <String, dynamic>{
        "context": context,
        "description": description,
        "timestamp": Timestamp.now(),
        "secretKey": firebaseSecretKey,
      };
      DocumentReference ref =
          db.collection("users").doc(uid).collection("notes").doc(docID);
      await ref.update(data);
    } on FirebaseException catch (e) {
      if (buildContext.mounted) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(content: Text('Failed to Update Notes: ${e.message}')),
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

  static Future<void> updateUserTodos(BuildContext buildContext, String context,
      String description, String docID) async {
    try {
      final data = <String, dynamic>{
        "context": context,
        "description": description,
        "timestamp": Timestamp.now(),
        "secretKey": firebaseSecretKey,
      };
      DocumentReference ref =
          db.collection("users").doc(uid).collection("todos").doc(docID);
      await ref.update(data);
    } on FirebaseException catch (e) {
      if (buildContext.mounted) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(content: Text('Failed to Update Todo: ${e.message}')),
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

  static Future<void> bookmarkNotes(
      BuildContext context, String docID, bool isBookmarked) async {
    try {
      final data = <String, dynamic>{
        "isBookmarked": isBookmarked,
        "secretKey": firebaseSecretKey,
      };
      db
          .collection("users")
          .doc(uid)
          .collection("notes")
          .doc(docID)
          .update(data);
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to Bookmark Note: ${e.message}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  static Future<void> bookmarkTodos(
      BuildContext context, String docID, bool isBookmarked) async {
    try {
      final data = <String, dynamic>{
        "isBookmarked": isBookmarked,
        "secretKey": firebaseSecretKey,
      };
      db
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(docID)
          .update(data);
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to Bookmark Todo: ${e.message}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  static Future<void> markToDoAsCompleted(
      BuildContext context, String docID, bool completionStatus) async {
    try {
      final data = <String, dynamic>{
        "completionStatus": completionStatus,
        "secretKey": firebaseSecretKey,
      };
      db
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(docID)
          .update(data);
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to Update the Completion Status of the Todo: ${e.message}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
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
