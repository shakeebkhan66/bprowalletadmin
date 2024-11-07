import 'package:bpro_wallet_admin/models/transfer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransferService {
  final CollectionReference _transferCollection = FirebaseFirestore.instance.collection('transferAccount');

  Stream<List<TransferModel>> getTransferStream() {
    return _transferCollection.snapshots().map((QuerySnapshot query) {
      return query.docs.map((doc) {
        return TransferModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> updateTransferStatus(String transferId, String status) async {
    await _transferCollection.doc(transferId).update({'status': status});
  }
}
