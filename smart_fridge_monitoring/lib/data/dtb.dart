import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  static Future<void> adduser(
      {required String userid,
      required String username,
      required String email,
      required String phone,
      required String password,
      required String usertype}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userid).set({
        'username': username,
        'email': email,
        'phone': phone,
        'password': password,
        'type': usertype
      });
      log("Fridge added successfully!");
    } catch (e) {
      log("Error adding user: $e");
    }
  }

  static Future<void> addFridge({
    required String id,
    required String status,
    required double cabinTemp,
    required double cabinCurrent,
    required double freezerTemp,
    required double freezerCurrent,
    required double mincabincurrent,
    required double maxcabincurrent,
    required double mincabintemp,
    required double maxcabintemp,
    required double minfreezercurrent,
    required double maxfreezercurrent,
    required double minfreezertemp,
    required double maxfreezertemp,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('fridges').doc(id).set({
        'status': status,
        'cabinTemp': cabinTemp,
        'cabinCurrent': cabinCurrent,
        'freezerTemp': freezerTemp,
        'freezerCurrent': freezerCurrent,
        'mincabintemp': mincabintemp,
        'maxcabintemp': maxcabintemp,
        'mincabincurrent': mincabincurrent,
        'maxcabincurrent': maxcabincurrent,
        'minfreezertemp': minfreezertemp,
        'maxfreezertemp': maxfreezertemp,
        'minfreezercurrent': minfreezercurrent,
        'maxfreezercurrent': maxfreezercurrent,
      });
      log("Fridge added successfully!");
    } catch (e) {
      log("Error adding fridge: $e");
    }
  }

  static Future<void> updateFridge(
      String id, Map<String, dynamic> updatedData) async {
    try {
      await FirebaseFirestore.instance
          .collection('fridges')
          .doc(id)
          .update(updatedData);
      log("Fridge updated successfully!");
    } catch (e) {
      log("Error updating fridge: $e");
    }
  }

  static Future<void> deleteFridge(String id) async {
    try {
      await FirebaseFirestore.instance.collection('fridges').doc(id).delete();
      log("Fridge deleted successfully!");
    } catch (e) {
      log("Error deleting fridge: $e");
    }
  }
}
