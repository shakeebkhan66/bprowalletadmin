// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/deposit_model.dart';
//
//
// class DepositService {
//   final CollectionReference _depositCollection = FirebaseFirestore.instance.collection('deposits');
//
//   Stream<List<DepositModel>> getDepositStream() {
//     return _depositCollection.snapshots().map((QuerySnapshot query) {
//       return query.docs.map((doc) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         return DepositModel(
//           userId: data['userId'],
//           amount: data['amount'],
//           typeOfAmount: data['typeOfAmount'],
//           paymentType: data['paymentType'],
//           image: data['image'],
//           status: data['status'],
//           timestamp: (data['timestamp'] as Timestamp).toDate(),
//         );
//       }).toList();
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/deposit_model.dart';

class DepositService {
  final CollectionReference _depositCollection = FirebaseFirestore.instance.collection('deposits');

  Stream<List<DepositModel>> getDepositStream() {
    return _depositCollection.snapshots().map((QuerySnapshot query) {
      return query.docs.map((doc) {
        return DepositModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> updateDepositStatus(String depositId, String status) async {
    await _depositCollection.doc(depositId).update({'status': status});
  }

  Future<void> updateBproAccountDetailsOfUser(
      String depositId, String stateOfUser, String bProAccountUsername, String bProAccountUserPassword) async {
    print("11 depostId $depositId");
    print("22 state $stateOfUser");
    print("33 username $bProAccountUsername");
    print("44 password $bProAccountUserPassword");
    await _depositCollection.doc(depositId).update({
      'stateOfUser': stateOfUser,
      'bProAccountUserName': bProAccountUsername,
      'bProAccountPassword': bProAccountUserPassword
    });
  }
}
