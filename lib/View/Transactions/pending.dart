import 'dart:io';
import 'package:bpro_wallet_admin/View/Transactions/transactions.dart';
import 'package:bpro_wallet_admin/pendingTransactions/approve_or_reject_transaction.dart';
import 'package:bpro_wallet_admin/pendingTransactions/withdraw_approve_reject.dart';
import 'package:bpro_wallet_admin/providers/withdraw_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/deposit_detail_provider.dart';

class PendingTransactions extends StatefulWidget {
  const PendingTransactions({super.key});

  @override
  State<PendingTransactions> createState() => _PendingTransactionsState();
}

class _PendingTransactionsState extends State<PendingTransactions> {

  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      return NetworkImage(imageUrl);
    } else {
      return FileImage(File(imageUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.green,
          title: const Text('Pending Transactions', style: TextStyle(color: Colors.white, fontFamily: 'Kanit')),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
            tabs: [
              Tab(
                text: 'DEPOSIT',
              ),
              Tab(text: 'WITHDRAW'),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.done_all_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Transactions(),
                  ),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Consumer<DepositDetailsProvider>(
                builder: (context, depositProvider, child) {
                  if (depositProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final pendingDeposits = depositProvider.deposits;
                  if (pendingDeposits.isEmpty) {
                    return const Center(child: Text('No transactions found.'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: pendingDeposits.length,
                    itemBuilder: (context, index) {
                      final deposit = pendingDeposits[index];
                      return ListTile(
                        onTap: () async {
                          bool? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ApproveOrRejectTransaction(deposit: deposit, depositProvider: depositProvider),
                            ),
                          );
                          if (result == true) {
                            setState(() {});
                          }
                        },
                        leading: CircleAvatar(
                          backgroundImage: deposit.image != null
                              ? _getImageProvider(deposit.image!)
                              : const NetworkImage(
                              'https://www.flaticon.com/free-icon/man_4140037?term=person&page=1&position=9&origin=search&related_id=4140037')
                          as ImageProvider,
                        ),
                        title: Text("${deposit.userName} \t ${deposit.accountNumber}"),
                        subtitle: Text(
                          'Amount: ${deposit.amount}\nStatus: ${deposit.status}',
                        ),
                        trailing: Text(deposit.timestamp.toString()),
                      );
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Consumer<WithdrawDetailProvider>(
                builder: (context, withdrawProvider, child) {
                  if (withdrawProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final pendingWithdraws = withdrawProvider.withdraws;
                  if (pendingWithdraws.isEmpty) {
                    return const Center(child: Text('No withdraws found.'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: pendingWithdraws.length,
                    itemBuilder: (context, index) {
                      final withdraw = pendingWithdraws[index];
                      return ListTile(
                        onTap: () async {
                          bool? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WithdrawApproveOrReject(withdrawModel: withdraw, withdrawDetailProvider: withdrawProvider),
                            ),
                          );
                          if (result == true) {
                            setState(() {});
                          }
                        },
                        title: Text("${withdraw.accountTitle} \t ${withdraw.accountNumber}"),
                        subtitle: Text(
                          'Amount: ${withdraw.amount}\nStatus: ${withdraw.status}',
                        ),
                        trailing: Text(withdraw.accountTitle.toString()),
                      );
                    },
                  );
                },
              ),
            ),

            // Previous Layout Design for Withdraw
            // Padding(
            //   padding: const EdgeInsets.all(5.0),
            //   child: ListView.builder(
            //     itemCount: withdrawTransactions.length,
            //     itemBuilder: (context, index) {
            //       final transaction = withdrawTransactions[index];
            //       return GestureDetector(
            //         onTap: () {
            //           showDialog(
            //             context: context,
            //             builder: (context) {
            //               return AlertDialog(
            //                 title: const Text('Approve Transaction',
            //                     style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.bold)),
            //                 content: const Text(
            //                   'Do you want to approve this transaction?',
            //                   style: TextStyle(fontFamily: 'Kanit', fontSize: 15),
            //                 ),
            //                 actions: [
            //                   TextButton(
            //                     onPressed: () {
            //                       setState(() {
            //                         transaction['approved'] = 'Rejected';
            //                       });
            //                       Navigator.pop(context);
            //                     },
            //                     child: const Text(
            //                       'Reject',
            //                       style: TextStyle(fontFamily: 'Kanit', color: Colors.black, fontSize: 15),
            //                     ),
            //                   ),
            //                   TextButton(
            //                     onPressed: () {
            //                       setState(() {
            //                         transaction['approved'] = 'Approved';
            //                       });
            //                       Navigator.pop(context);
            //                     },
            //                     child: const Text(
            //                       'Approve',
            //                       style: TextStyle(fontFamily: 'Kanit', fontSize: 15, color: Colors.black),
            //                     ),
            //                   ),
            //                 ],
            //               );
            //             },
            //           );
            //         },
            //         child: Column(
            //           children: [
            //             Container(
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(10),
            //                 border: Border.all(color: const Color.fromARGB(255, 26, 153, 30), width: 2),
            //               ),
            //               child: Column(
            //                 children: [
            //                   ListTile(
            //                     title: const Text(
            //                       'Withdraw',
            //                       style:
            //                           TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
            //                     ),
            //                     subtitle: Text('To: ${transaction['name']!}'),
            //                     leading: const Icon(Icons.download),
            //                     trailing: Text(
            //                       'Rs: ${transaction['amount']}',
            //                       style: const TextStyle(fontSize: 15, fontFamily: 'Kanit'),
            //                     ),
            //                   ),
            //                   const Divider(),
            //                   Row(
            //                     children: [
            //                       const SizedBox(width: 10),
            //                       Text('${transaction['approved']!}',
            //                           style: TextStyle(
            //                               fontSize: 15,
            //                               fontFamily: 'Kanit',
            //                               color: (transaction['approved'] == 'Approved') ? Colors.green : Colors.red)),
            //                       const Spacer(),
            //                       Text(
            //                         transaction['date']!,
            //                         style: const TextStyle(fontFamily: 'Kanit'),
            //                       ),
            //                       const SizedBox(width: 10),
            //                     ],
            //                   ),
            //                   const SizedBox(height: 5)
            //                 ],
            //               ),
            //             ),
            //             const SizedBox(height: 10)
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}
