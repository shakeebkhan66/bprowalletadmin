import 'package:cloud_firestore/cloud_firestore.dart';

class WithdrawModel {
  final String id;
  final String userId;
  final String accountTitle;
  final String accountNumber;
  final double amount;
  final String accountType;
  String status;
  DateTime? timestamp;

  WithdrawModel({
    required this.id,
    required this.userId,
    required this.accountTitle,
    required this.accountNumber,
    required this.amount,
    required this.accountType,
    required this.status,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'accountTitle': accountTitle,
      'accountNo': accountNumber,
      'amount': amount,
      'accountType': accountType,
      'status': status,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }

  factory WithdrawModel.fromMap(String id, Map<String, dynamic> data) {
    return WithdrawModel(
      id: id,
      userId: data['userId'],
      accountTitle: data['accountTitle'],
      accountNumber: data['accountNo'],
      amount: data['amount'].toDouble(),
      accountType: data['accountType'],
      status: data['status'],
      timestamp: data['timestamp'] != null ? (data['timestamp'] as Timestamp).toDate() : null,
    );
  }
}
