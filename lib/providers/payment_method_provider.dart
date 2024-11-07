// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class PaymentMethodProvider extends ChangeNotifier {
//   String? accountHolderName;
//   String? accountMethodType;
//   String? accountNumber;
//   bool? accountStatus;
//   bool _isLoading = false;
//   List<Map<String, dynamic>> _paymentMethods = [];
//   List<bool> _switchStates = [];
//
//   bool get isLoading => _isLoading;
//   List<Map<String, dynamic>> get paymentMethods => _paymentMethods;
//   List<bool> get switchStates => _switchStates;
//
//   void setAccountHolderName(String name) {
//     accountHolderName = name;
//     notifyListeners();
//   }
//
//   void setAccountMethodType(String type) {
//     accountMethodType = type;
//     notifyListeners();
//   }
//
//   void setAccountNumber(String number) {
//     accountNumber = number;
//     notifyListeners();
//   }
//
//   void setAccountStatus(bool status){
//     accountStatus = status;
//     notifyListeners();
//   }
//
//   Future<void> addPaymentMethod() async {
//     _isLoading = true;
//     notifyListeners();
//
//     if (accountHolderName != null &&
//         accountMethodType != null &&
//         accountNumber != null && accountStatus != null) {
//       await FirebaseFirestore.instance.collection('accountType').add({
//         'accountHolderName': accountHolderName,
//         'accountMethodType': accountMethodType,
//         'accountNumber': accountNumber,
//         'accountStatus': accountStatus
//       });
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   Future<void> fetchPaymentMethods() async {
//     _isLoading = true;
//     notifyListeners();
//
//     QuerySnapshot querySnapshot =
//     await FirebaseFirestore.instance.collection('accountType').get();
//
//     _paymentMethods = querySnapshot.docs
//         .map((doc) => {
//       'accountHolderName': doc['accountHolderName'],
//       'accountMethodType': doc['accountMethodType'],
//       'accountNumber': doc['accountNumber'],
//       'accountStatus': doc['accountStatus']
//     })
//         .toList();
//
//     _switchStates = List<bool>.filled(_paymentMethods.length, false);
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   void toggleSwitch(int index, bool value) {
//     _switchStates[index] = value;
//     notifyListeners();
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentMethodProvider extends ChangeNotifier {
  String? accountHolderName;
  String? accountMethodType;
  String? accountNumber;
  bool accountStatus = false;
  bool _isLoading = false;
  List<Map<String, dynamic>> _paymentMethods = [];
  List<bool> _switchStates = [];

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get paymentMethods => _paymentMethods;
  List<bool> get switchStates => _switchStates;

  void setAccountHolderName(String name) {
    accountHolderName = name;
    notifyListeners();
  }

  void setAccountMethodType(String type) {
    accountMethodType = type;
    notifyListeners();
  }

  void setAccountNumber(String number) {
    accountNumber = number;
    notifyListeners();
  }

  void setAccountStatus(bool status) {
    accountStatus = status;
    notifyListeners();
  }

  Future<void> addPaymentMethod() async {
    _isLoading = true;
    notifyListeners();

    if (accountHolderName != null && accountMethodType != null && accountNumber != null) {
      await FirebaseFirestore.instance.collection('accountType').add({
        'accountHolderName': accountHolderName,
        'accountMethodType': accountMethodType,
        'accountNumber': accountNumber,
        'accountStatus': accountStatus,
      });
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPaymentMethods() async {
    _isLoading = true;
    notifyListeners();

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('accountType').get();

    _paymentMethods = querySnapshot.docs
        .map((doc) => {
      'id': doc.id,
      'accountHolderName': doc['accountHolderName'],
      'accountMethodType': doc['accountMethodType'],
      'accountNumber': doc['accountNumber'],
      'accountStatus': doc['accountStatus'],
    })
        .toList();

    _switchStates = _paymentMethods.map((method) => method['accountStatus'] as bool).toList();

    _isLoading = false;
    notifyListeners();
  }

  void toggleSwitch(int index, bool value) async {
    _switchStates[index] = value;
    notifyListeners();

    String docId = _paymentMethods[index]['id'];
    await FirebaseFirestore.instance.collection('accountType').doc(docId).update({'accountStatus': value});
  }
}
