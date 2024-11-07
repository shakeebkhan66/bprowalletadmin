import 'package:bpro_wallet_admin/models/withdraw_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/deposit_model.dart';

class WithdrawService {
  final CollectionReference _withdrawCollection = FirebaseFirestore.instance.collection('withdrawAmount');

  Stream<List<WithdrawModel>> getWithdrawStream() {
    return _withdrawCollection.snapshots().map((QuerySnapshot query) {
      return query.docs.map((doc) {
        return WithdrawModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> updateDepositStatus(String depositId, String status) async {
    await _withdrawCollection.doc(depositId).update({'status': status});
  }
}
