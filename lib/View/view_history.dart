import 'package:bpro_wallet_admin/providers/withdraw_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/deposit_detail_provider.dart';

class ViewHistory extends StatefulWidget {
  const ViewHistory({super.key});

  @override
  State<ViewHistory> createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  @override
  Widget build(BuildContext context) {
    final depositProvider = Provider.of<DepositDetailsProvider>(context, listen: false);
    // final withdrawProvider = Provider.of<WithdrawDetailProvider>(context, listen: false);
    // int totalApprovedDeposits = depositProvider.getTodayApprovedDepositsCount() +
    //     depositProvider.getYesterdayApprovedDepositsCount();
    // int totalRejectedDeposits = depositProvider.getTodayApprovedDepositsCount() +
    //     depositProvider.getYesterdayRejectedDepositsCount();
    // int totalDepositsCount = depositProvider.getTodayApprovedDepositsCount() +
    //     depositProvider.getTodayRejectedDepositsCount() +
    //     depositProvider.getYesterdayApprovedDepositsCount() +
    //     depositProvider.getYesterdayRejectedDepositsCount() +
    //     depositProvider.getTodayPendingCount() +
    //     depositProvider.getYesterdayPendingCount();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'History',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Kanit',
            ),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const ListTile(
                      leading: Icon(
                        Icons.currency_exchange,
                        size: 40,
                      ),
                      title: Text(
                        'Account Remaining Balance',
                        style: TextStyle(fontFamily: 'Kanit', fontSize: 15),
                      ),
                      subtitle: Text(
                        'Rs: 2473742',
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.green.withOpacity(0.8),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today Deposit History',
                              style: TextStyle(
                                  fontFamily: 'Kanit', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today Rejected Deposit',
                              style: TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              depositProvider.getTodayRejectedDepositsCount().toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today Approved Deposit',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffff9800),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              depositProvider.getTodayApprovedDepositsCount().toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffff9800),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today Total Deposit',
                              style: TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (depositProvider.getTodayApprovedDepositsCount() + depositProvider.getTodayRejectedDepositsCount()).toString(),
                              style: const TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yesterday Deposit History',
                              style: TextStyle(
                                  fontFamily: 'Kanit', fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Yesterday Rejected Deposit',
                              style: TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              depositProvider.getYesterdayRejectedDepositsCount().toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Yesterday Approved Deposit',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              depositProvider.getYesterdayApprovedDepositsCount().toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Yesterday Total Deposit',
                              style: TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (depositProvider.getYesterdayRejectedDepositsCount() + depositProvider.getYesterdayApprovedDepositsCount()).toString(),
                              style: const TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.green.withOpacity(0.8),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today Withdraw History',
                              style: TextStyle(
                                  fontFamily: 'Kanit', fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today Rejected Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              depositProvider.getTodayRejectedWithdrawalsCount().toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today Approved Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              depositProvider.getTodayApprovedWithdrawalsCount().toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today Total Withdraw',
                              style: TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (depositProvider.getTodayApprovedWithdrawalsCount() + depositProvider.getTodayRejectedWithdrawalsCount()).toString(),
                              style: const TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yesterday Withdraw History',
                              style: TextStyle(
                                  fontFamily: 'Kanit', fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Yesterday Rejected Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              depositProvider.getYesterdayRejectedWithdrawalsCount().toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Yesterday Approved Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              depositProvider.getYesterdayApprovedWithdrawalsCount().toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Yesterday Total Withdraw',
                              style: TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (depositProvider.getYesterdayApprovedWithdrawalsCount() + depositProvider.getYesterdayRejectedWithdrawalsCount()).toString(),
                              style: const TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.green.withOpacity(0.8),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Approved and Rejected Deposits',
                              style: TextStyle(
                                  fontFamily: 'Kanit', fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Approved',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffff9800),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text((depositProvider.getTodayApprovedDepositsCount() + depositProvider.getYesterdayApprovedDepositsCount()).toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffff9800),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Rejected',
                              style: TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                            Text((depositProvider.getTodayRejectedDepositsCount() + depositProvider.getYesterdayRejectedDepositsCount()).toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit', color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pending',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              depositProvider.getTodayPendingCount().toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       'Total',
                        //       style: TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       totalDepositsCount.toString(),
                        //       style: const TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.green.withOpacity(0.8),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Approved and Rejected Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit', fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Approved',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (depositProvider.getTodayApprovedWithdrawalsCount() + depositProvider.getYesterdayApprovedWithdrawalsCount()).toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffff9800),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Rejected',
                              style: TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (depositProvider.getTodayRejectedWithdrawalsCount() + depositProvider.getYesterdayRejectedWithdrawalsCount()).toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit', fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pending',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (depositProvider.getTodayPendingWithdrawCount() + depositProvider.getYesterdayPendingWithdrawCount()).toString(),
                              style: const TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       'Total',
                        //       style: TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       (withdrawProvider.getTodayApprovedWithdrawsCount().toString() +
                        //           withdrawProvider.getTodayRejectedWithdrawsCount().toString() +
                        //           withdrawProvider.getYesterdayApprovedWithdrawsCount().toString() +
                        //           withdrawProvider.getYesterdayRejectedWithdrawsCount().toString() +
                        //           withdrawProvider.getTodayPendingCount().toString() +
                        //           withdrawProvider.getYesterdayPendingCount().toString()),
                        //       style: const TextStyle(fontFamily: 'Kanit', fontSize: 15, fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
