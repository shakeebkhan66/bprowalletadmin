import 'package:bpro_wallet_admin/models/transfer_model.dart';
import 'package:bpro_wallet_admin/models/withdraw_model.dart';
import 'package:bpro_wallet_admin/res/transfer_service.dart';
import 'package:bpro_wallet_admin/res/withdraw_service.dart';
import 'package:flutter/material.dart';


class TransferProvider with ChangeNotifier {
  final TransferService transferService = TransferService();
  List<TransferModel> _transfer = [];
  List<Map<String, Object?>> _pendingUsers = [];
  bool _isLoading = true;

  List<TransferModel> get transfers => _transfer.where((transfer) => transfer.status == 'pending').toList();
  List<Map<String, Object?>> get pendingUsers => _pendingUsers;
  bool get isLoading => _isLoading;

  TransferProvider() {
    transferService.getTransferStream().listen((List<TransferModel> transferList) {
      _transfer = transferList;
      _pendingUsers = _extractPendingUsers(transferList);
      _isLoading = false;
      notifyListeners();
    });
  }

  List<Map<String, Object?>> _extractPendingUsers(List<TransferModel> transferList) {
    return transferList
        .where((transfer) => transfer.status == 'pending')
        .map((transfers) => {
      'userId': transfers.userId,
      'amount': transfers.amount,
      'status': transfers.status,
      'accountTransferMethod': transfers.accountTransferMethod,
      'timestamp': transfers.timestamp,
    })
        .toList();
  }

  Future<void> updateTransfer(String withdrawId, String status) async {
    await transferService.updateTransferStatus(withdrawId, status);
    _transfer = _transfer.map((transfer) {
      if (transfer.userId == withdrawId) {
        transfer.status = status;
      }
      return transfer;
    }).toList();
    notifyListeners();
  }


}