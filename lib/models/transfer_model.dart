import 'package:cloud_firestore/cloud_firestore.dart';

class TransferModel {
  final String? id;
  final String userId;
  final double amount;
  String status;
  final String accountTransferMethod;
  final DateTime? timestamp;

  TransferModel({
    this.id,
    required this.userId,
    required this.amount,
    required this.status,
    required this.accountTransferMethod,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'status': status,
      'accountTransferMethod': accountTransferMethod,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }

  factory TransferModel.fromMap(String id, Map<String, dynamic> data) {
    return TransferModel(
      id: data['id'],
      userId: data['userId'],
      amount: data['amount'],
      status: data['status'],
      accountTransferMethod: data['accountTransferMethod'],
      timestamp: data['timestamp'] != null ? (data['timestamp'] as Timestamp).toDate() : null,
    );
  }
}
