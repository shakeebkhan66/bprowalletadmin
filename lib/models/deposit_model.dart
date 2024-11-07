import 'package:cloud_firestore/cloud_firestore.dart';

class DepositModel {
  final String id;
  final String userName;
  final String userId;
  final double amount;
  final String typeOfAmount;
  final String paymentType;
  final String accountNumber;
  final String image;
  String status;
  String stateOfUser;
  final DateTime timestamp;

  DepositModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.amount,
    required this.typeOfAmount,
    required this.paymentType,
    required this.accountNumber,
    required this.image,
    required this.status,
    required this.stateOfUser,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'amount': amount,
      'username': userName,
      'typeOfAmount': typeOfAmount,
      'paymentType': paymentType,
      'accountNumber': accountNumber,
      'image': image,
      'status': status,
      'stateOfUser': stateOfUser,
      'timestamp': timestamp,
    };
  }

  factory DepositModel.fromMap(String id, Map<String, dynamic> data) {
    return DepositModel(
      id: id,
      userId: data['userId'],
      amount: data['amount'],
      userName: data['username'],
      typeOfAmount: data['typeOfAmount'],
      paymentType: data['paymentType'],
      accountNumber: data['accountNumber'],
      image: data['image'],
      status: data['status'],
      stateOfUser: data['stateOfUser'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
