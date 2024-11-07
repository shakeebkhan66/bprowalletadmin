
// import 'package:flutter/material.dart';
// import '../models/deposit_model.dart';
// import '../res/deposit_service.dart';
//
// class DepositDetailsProvider with ChangeNotifier {
//   final DepositService _depositService = DepositService();
//   List<DepositModel> _deposits = [];
//   List<Map<String, String>> _pendingUsers = [];
//   bool _isLoading = true;
//
//   List<DepositModel> get deposits => _deposits.where((deposit) => deposit.status == 'pending').toList();
//   List<Map<String, String>> get pendingUsers => _pendingUsers;
//   bool get isLoading => _isLoading;
//
//   DepositDetailsProvider() {
//     _depositService.getDepositStream().listen((List<DepositModel> depositList) {
//       _deposits = depositList;
//       _pendingUsers = _extractPendingUsers(depositList);
//       _isLoading = false;
//       notifyListeners();
//     });
//   }
//
//   List<Map<String, String>> _extractPendingUsers(List<DepositModel> depositList) {
//     return depositList
//         .where((deposit) => deposit.stateOfUser == 'inActive')
//         .map((deposit) => {
//       'name': deposit.userName,
//       'number': deposit.accountNumber,
//       'amount': deposit.amount.toString(),
//       'status': deposit.status,
//       'stateOfUser': deposit.stateOfUser,
//       'date': deposit.timestamp.toString(),
//     })
//         .toList();
//   }
//
//   Future<void> updateDepositStatus(String depositId, String status) async {
//     await _depositService.updateDepositStatus(depositId, status);
//     _deposits = _deposits.map((deposit) {
//       if (deposit.id == depositId) {
//         deposit.status = status;
//       }
//       return deposit;
//     }).toList();
//     notifyListeners();
//   }
//
//   int getTodayDepositsCount(String status) {
//     final now = DateTime.now();
//     return _deposits.where((deposit) {
//       final depositDate = deposit.timestamp;
//       return deposit.status == status &&
//           depositDate.year == now.year &&
//           depositDate.month == now.month &&
//           depositDate.day == now.day;
//     }).length;
//   }
//
//   int getYesterdayDepositsCount(String status) {
//     final now = DateTime.now();
//     final yesterday = now.subtract(const Duration(days: 1));
//     return _deposits.where((deposit) {
//       final depositDate = deposit.timestamp;
//       return deposit.status == status &&
//           depositDate.year == yesterday.year &&
//           depositDate.month == yesterday.month &&
//           depositDate.day == yesterday.day;
//     }).length;
//   }
//
//   int getTodayRejectedDepositsCount() => getTodayDepositsCount('Rejected');
//   int getTodayApprovedDepositsCount() => getTodayDepositsCount('Approved');
//   int getYesterdayRejectedDepositsCount() => getYesterdayDepositsCount('Rejected');
//   int getYesterdayApprovedDepositsCount() => getYesterdayDepositsCount('Approved');
//   int getTodayPendingCount() => getTodayDepositsCount('pending');
//   int getYesterdayPendingCount() => getYesterdayDepositsCount('pending');
//
// }



import 'package:flutter/material.dart';
import '../models/deposit_model.dart';
import '../models/transfer_model.dart';
import '../models/withdraw_model.dart';
import '../res/deposit_service.dart';
import '../res/transfer_service.dart';
import '../res/withdraw_service.dart';


// class DepositDetailsProvider with ChangeNotifier {
//   final DepositService _depositService = DepositService();
//   final WithdrawService _withdrawService = WithdrawService();
//   List<DepositModel> _deposits = [];
//   List<WithdrawModel> _withdrawals = [];
//   List<Map<String, String>> _pendingUsers = [];
//   bool _isLoading = true;
//
//   List<DepositModel> get deposits => _deposits.where((deposit) => deposit.status == 'pending').toList();
//   List<Map<String, String>> get pendingUsers => _pendingUsers;
//   bool get isLoading => _isLoading;
//
//   DepositDetailsProvider() {
//     _depositService.getDepositStream().listen((List<DepositModel> depositList) {
//       _deposits = depositList;
//       _updatePendingUsers();
//       _isLoading = false;
//       notifyListeners();
//     });
//
//     _withdrawService.getWithdrawStream().listen((List<WithdrawModel> withdrawList) {
//       _withdrawals = withdrawList;
//       _updatePendingUsers();
//       _isLoading = false;
//       notifyListeners();
//     });
//   }
//
//   void _updatePendingUsers() {
//     _pendingUsers = _extractPendingUsers(_deposits, _withdrawals);
//   }
//
//   List<Map<String, String>> _extractPendingUsers(List<DepositModel> depositList, List<WithdrawModel> withdrawList) {
//     Map<String, Map<String, String>> userMap = {};
//     for (var deposit in depositList.where((deposit) => deposit.stateOfUser == 'inActive' && deposit.status == 'Approved')) {
//       if (userMap.containsKey(deposit.userId)) {
//         double currentAmount = double.parse(userMap[deposit.userId]!['amount']!);
//         double newAmount = currentAmount + double.parse(deposit.amount.toString());
//         userMap[deposit.userId]!['amount'] = newAmount.toString();
//       } else {
//         userMap[deposit.userId] = {
//           'id': deposit.id,
//           'userId': deposit.userId,
//           'name': deposit.userName,
//           'number': deposit.accountNumber,
//           'amount': deposit.amount.toString(),
//           'status': deposit.status,
//           'stateOfUser': deposit.stateOfUser,
//           'date': deposit.timestamp.toString(),
//         };
//       }
//     }
//
//     for (var withdraw in withdrawList) {
//       if (userMap.containsKey(withdraw.userId)) {
//         double currentAmount = double.parse(userMap[withdraw.userId]!['amount']!);
//         double newAmount = currentAmount - double.parse(withdraw.amount.toString());
//         userMap[withdraw.userId]!['amount'] = newAmount.toString();
//       }
//     }
//
//     return userMap.values.toList();
//   }
//
//   Future<void> updateDepositStatus(String depositId, String status) async {
//     await _depositService.updateDepositStatus(depositId, status);
//     _deposits = _deposits.map((deposit) {
//       if (deposit.id == depositId) {
//         deposit.status = status;
//       }
//       return deposit;
//     }).toList();
//     notifyListeners();
//   }
//
//
//
//   Future<void> updateBProAccountDetails(String depositId, String stateOfUser, String bProAccountUsername, String bProAccountUserPassword) async {
//
//     print("1 depostId $depositId");
//     print("2 state $stateOfUser");
//     print("3 username $bProAccountUsername");
//     print("4 password $bProAccountUserPassword");
//
//     await _depositService.updateBproAccountDetailsOfUser(depositId, stateOfUser, bProAccountUsername, bProAccountUserPassword);
//     _deposits = _deposits.map((deposit) {
//       if (deposit.id == depositId) {
//         deposit.stateOfUser = stateOfUser;
//       }
//       return deposit;
//     }).toList();
//     notifyListeners();
//   }
//
//
//
//
//
//   int getTodayDepositsCount(String status) {
//     final now = DateTime.now();
//     return _deposits.where((deposit) {
//       final depositDate = deposit.timestamp;
//       return deposit.status == status &&
//           depositDate.year == now.year &&
//           depositDate.month == now.month &&
//           depositDate.day == now.day;
//     }).length;
//   }
//
//   int getYesterdayDepositsCount(String status) {
//     final now = DateTime.now();
//     final yesterday = now.subtract(const Duration(days: 1));
//     return _deposits.where((deposit) {
//       final depositDate = deposit.timestamp;
//       return deposit.status == status &&
//           depositDate.year == yesterday.year &&
//           depositDate.month == yesterday.month &&
//           depositDate.day == yesterday.day;
//     }).length;
//   }
//
//   int getTodayRejectedDepositsCount() => getTodayDepositsCount('Rejected');
//   int getTodayApprovedDepositsCount() => getTodayDepositsCount('Approved');
//   int getYesterdayRejectedDepositsCount() => getYesterdayDepositsCount('Rejected');
//   int getYesterdayApprovedDepositsCount() => getYesterdayDepositsCount('Approved');
//   int getTodayPendingCount() => getTodayDepositsCount('pending');
//   int getYesterdayPendingCount() => getYesterdayDepositsCount('pending');
// }

class DepositDetailsProvider with ChangeNotifier {
  final DepositService _depositService = DepositService();
  final WithdrawService _withdrawService = WithdrawService();
  final TransferService _transferService = TransferService();

  List<DepositModel> _deposits = [];
  List<WithdrawModel> _withdrawals = [];
  List<TransferModel> _transfers = [];
  List<Map<String, String>> _pendingUsers = [];
  bool _isLoading = true;

  List<DepositModel> get deposits => _deposits.where((deposit) => deposit.status == 'pending').toList();
  List<Map<String, String>> get pendingUsers => _pendingUsers;
  bool get isLoading => _isLoading;

  DepositDetailsProvider() {
    _depositService.getDepositStream().listen((List<DepositModel> depositList) {
      _deposits = depositList;
      _updatePendingUsers();
      _isLoading = false;
      notifyListeners();
    });

    _withdrawService.getWithdrawStream().listen((List<WithdrawModel> withdrawList) {
      _withdrawals = withdrawList;
      _updatePendingUsers();
      _isLoading = false;
      notifyListeners();
    });

    _transferService.getTransferStream().listen((List<TransferModel> transferList) {
      _transfers = transferList;
      _updatePendingUsers();
      _isLoading = false;
      notifyListeners();
    });
  }

  void _updatePendingUsers() {
    _pendingUsers = _extractPendingUsers(_deposits, _withdrawals, _transfers);
  }

  List<Map<String, String>> _extractPendingUsers(List<DepositModel> depositList, List<WithdrawModel> withdrawList, List<TransferModel> transferList) {
    Map<String, Map<String, String>> userMap = {};

    for (var deposit in depositList.where((deposit) => deposit.stateOfUser == 'inActive' || (deposit.stateOfUser == 'active' && deposit.status == 'Approved'))) {
      if (userMap.containsKey(deposit.userId)) {
        double currentAmount = double.parse(userMap[deposit.userId]!['amount']!);
        double newAmount = currentAmount + double.parse(deposit.amount.toString());
        userMap[deposit.userId]!['amount'] = newAmount.toString();
      } else {
        userMap[deposit.userId] = {
          'id': deposit.id,
          'userId': deposit.userId,
          'name': deposit.userName,
          'number': deposit.accountNumber,
          'amount': deposit.amount.toString(),
          'status': deposit.status,
          'stateOfUser': deposit.stateOfUser,
          'date': deposit.timestamp.toString(),
        };
      }
    }

    for (var withdraw in withdrawList.where((withdraw) => withdraw.status == 'Approved')) {
      if (userMap.containsKey(withdraw.userId)) {
        double currentAmount = double.parse(userMap[withdraw.userId]!['amount']!);
        double newAmount = currentAmount - double.parse(withdraw.amount.toString());
        userMap[withdraw.userId]!['amount'] = newAmount.toString();
      }
    }

    for (var transfer in transferList.where((transfer) => transfer.status == 'accepted')) {
      if (userMap.containsKey(transfer.userId)) {
        double currentAmount = double.parse(userMap[transfer.userId]!['amount']!);
        if (transfer.accountTransferMethod == 'Wallet to BPro Account') {
          double newAmount = currentAmount - double.parse(transfer.amount.toString());
          userMap[transfer.userId]!['amount'] = newAmount.toString();
        } else if (transfer.accountTransferMethod == 'BPro Account to Wallet') {
          double newAmount = currentAmount + double.parse(transfer.amount.toString());
          userMap[transfer.userId]!['amount'] = newAmount.toString();
        }
      }
    }

    return userMap.values.toList();
  }

  Future<void> updateDepositStatus(String depositId, String status) async {
    await _depositService.updateDepositStatus(depositId, status);
    _deposits = _deposits.map((deposit) {
      if (deposit.id == depositId) {
        deposit.status = status;
      }
      return deposit;
    }).toList();
    notifyListeners();
  }

  Future<void> updateBProAccountDetails(String depositId, String stateOfUser, String bProAccountUsername, String bProAccountUserPassword) async {
    await _depositService.updateBproAccountDetailsOfUser(depositId, stateOfUser, bProAccountUsername, bProAccountUserPassword);
    _deposits = _deposits.map((deposit) {
      if (deposit.id == depositId) {
        deposit.stateOfUser = stateOfUser;
      }
      return deposit;
    }).toList();
    notifyListeners();
  }

  int getTodayDepositsCount(String status) {
    final now = DateTime.now();
    return _deposits.where((deposit) {
      final depositDate = deposit.timestamp;
      return deposit.status == status &&
          depositDate.year == now.year &&
          depositDate.month == now.month &&
          depositDate.day == now.day;
    }).length;
  }

  int getYesterdayDepositsCount(String status) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    return _deposits.where((deposit) {
      final depositDate = deposit.timestamp;
      return deposit.status == status &&
          depositDate.year == yesterday.year &&
          depositDate.month == yesterday.month &&
          depositDate.day == yesterday.day;
    }).length;
  }

  int getTodayRejectedDepositsCount() => getTodayDepositsCount('Rejected');
  int getTodayApprovedDepositsCount() => getTodayDepositsCount('Approved');
  dynamic getTodayTotalDepositsCount() {
    return getTodayDepositsCount('Rejected') + getTodayDepositsCount('Approved');
  }

  int getYesterdayRejectedDepositsCount() => getYesterdayDepositsCount('Rejected');
  int getYesterdayApprovedDepositsCount() => getYesterdayDepositsCount('Approved');
  int getYesterdayTotalDepositsCount() => getYesterdayDepositsCount('Approved') + getYesterdayDepositsCount('Rejected') + getYesterdayDepositsCount('pending');

  int getTodayRejectedWithdrawalsCount() => getTodayWithdrawalsCount('Rejected');
  int getTodayApprovedWithdrawalsCount() => getTodayWithdrawalsCount('Approved');
  int getTodayTotalWithdrawalsCount() => getTodayWithdrawalsCount('Approved') + getTodayWithdrawalsCount('Rejected') + getTodayWithdrawalsCount('pending');

  int getYesterdayRejectedWithdrawalsCount() => getYesterdayWithdrawalsCount('Rejected');
  int getYesterdayApprovedWithdrawalsCount() => getYesterdayWithdrawalsCount('Approved');
  int getYesterdayTotalWithdrawalsCount() => getYesterdayWithdrawalsCount('Approved') + getYesterdayWithdrawalsCount('Rejected') + getYesterdayWithdrawalsCount('pending');

  int getTodayPendingCount() => getTodayDepositsCount('pending');
  int getYesterdayPendingCount() => getYesterdayDepositsCount('pending');
  int getTodayPendingWithdrawCount() => getTodayWithdrawalsCount('pending');
  int getYesterdayPendingWithdrawCount() => getYesterdayWithdrawalsCount('pending');

  int getTodayWithdrawalsCount(String status) {
    final now = DateTime.now();
    return _withdrawals.where((withdraw) {
      final withdrawDate = withdraw.timestamp;
      return withdraw.status == status &&
          withdrawDate!.year == now.year &&
          withdrawDate.month == now.month &&
          withdrawDate.day == now.day;
    }).length;
  }

  int getYesterdayWithdrawalsCount(String status) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    return _withdrawals.where((withdraw) {
      final withdrawDate = withdraw.timestamp;
      return withdraw.status == status &&
          withdrawDate!.year == yesterday.year &&
          withdrawDate.month == yesterday.month &&
          withdrawDate.day == yesterday.day;
    }).length;
  }

  double get totalApprovedDeposit {
    double totalDeposit = _deposits.where((deposit) => deposit.status == 'Approved').fold(0.0, (sum, deposit) => sum + deposit.amount);

    for (var transfer in _transfers) {
      if (transfer.status == 'accepted') {
        if (transfer.accountTransferMethod == 'Wallet to BPro Account') {
          totalDeposit -= transfer.amount;
        } else if (transfer.accountTransferMethod == 'BPro Account to Wallet') {
          totalDeposit += transfer.amount;
        }
      }
    }

    return totalDeposit;
  }

  double get availableBalance {
    double totalWithdrawnAmount = _withdrawals
        .where((withdraw) => withdraw.status == 'Approved')
        .fold(0.0, (sum, withdraw) => sum + withdraw.amount);
    return totalApprovedDeposit - totalWithdrawnAmount;
  }
}


