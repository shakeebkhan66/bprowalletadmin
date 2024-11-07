import 'package:bpro_wallet_admin/models/withdraw_model.dart';
import 'package:bpro_wallet_admin/res/withdraw_service.dart';
import 'package:flutter/material.dart';

class WithdrawDetailProvider with ChangeNotifier {
  final WithdrawService withdrawService = WithdrawService();
  List<WithdrawModel> _withdraw = [];
  List<Map<String, Object>> _pendingUsers = [];
  bool _isLoading = true;

  List<WithdrawModel> get withdraws => _withdraw.where((withdraw) => withdraw.status == 'pending').toList();
  List<Map<String, Object>> get pendingUsers => _pendingUsers;
  bool get isLoading => _isLoading;

  WithdrawDetailProvider() {
    withdrawService.getWithdrawStream().listen((List<WithdrawModel> withdrawList) {
      _withdraw = withdrawList;
      _pendingUsers = _extractPendingUsers(withdrawList);
      _isLoading = false;
      notifyListeners();
    });
  }

  List<Map<String, Object>> _extractPendingUsers(List<WithdrawModel> withdrawList) {
    return withdrawList
        .where((withdraw) => withdraw.status == 'pending')
        .map((withdraws) => {
      'userId': withdraws.userId,
      'accountNo': withdraws.accountNumber,
      'accountTitle': withdraws.accountTitle,
      'accountType': withdraws.accountType,
      'amount': withdraws.amount,
      'status': withdraws.status
    })
        .toList();
  }

  Future<void> updateDepositStatus(String withdrawId, String status) async {
    await withdrawService.updateDepositStatus(withdrawId, status);
    _withdraw = _withdraw.map((withdraw) {
      if (withdraw.id == withdrawId) {
        withdraw.status = status;
      }
      return withdraw;
    }).toList();
    notifyListeners();
  }


  int getTodayWithdrawsCount(String status) {
    final now = DateTime.now();
    return _withdraw.where((withdraw) {
      final withdrawDate = withdraw.timestamp;
      return withdraw.status == status &&
          withdrawDate?.year == now.year &&
          withdrawDate?.month == now.month &&
          withdrawDate?.day == now.day;
    }).length;
  }

  int getYesterdayWithdrawsCount(String status) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    return _withdraw.where((withdraw) {
      final withdrawDate = withdraw.timestamp;
      return withdraw.status == status &&
          withdrawDate?.year == yesterday.year &&
          withdrawDate?.month == yesterday.month &&
          withdrawDate?.day == yesterday.day;
    }).length;
  }

  int getTodayRejectedWithdrawsCount() => getTodayWithdrawsCount('Rejected');
  int getTodayApprovedWithdrawsCount() => getTodayWithdrawsCount('Approved');
  int getYesterdayRejectedWithdrawsCount() => getYesterdayWithdrawsCount('Rejected');
  int getYesterdayApprovedWithdrawsCount() => getYesterdayWithdrawsCount('Approved');
  int getTodayPendingCount() => getTodayWithdrawsCount('pending');
  int getYesterdayPendingCount() => getYesterdayWithdrawsCount('pending');
}
