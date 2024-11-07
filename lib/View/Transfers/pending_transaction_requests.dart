import 'package:bpro_wallet_admin/View/Transfers/completed_transfers.dart';
import 'package:bpro_wallet_admin/providers/transfer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingTransactionRequests extends StatefulWidget {
  const PendingTransactionRequests({super.key});

  @override
  State<PendingTransactionRequests> createState() => _PendingTransactionRequestsState();
}

class _PendingTransactionRequestsState extends State<PendingTransactionRequests> {
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
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.green,
          title: const Text('Pending Transfers',
              style: TextStyle(color: Colors.white, fontFamily: 'Kanit')),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
            tabs: [
              Tab(
                text: 'BETPRO ACCOUNT',
              ),
              Tab(text: 'WALLET'),
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
                    builder: (context) => const CompletedTransfers(),
                  ),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Consumer<TransferProvider>(
              builder: (context, transferProvider, child) {
                if (transferProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final pendingTransfers = transferProvider.transfers;
                if (pendingTransfers.isEmpty) {
                  return const Center(child: Text('No transfers found.'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: pendingTransfers.length,
                  itemBuilder: (context, index) {
                    final transfer = pendingTransfers[index];
                    return transfer.accountTransferMethod == "BPro Account to Wallet"
                        ? Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                insetPadding: const EdgeInsets.all(20),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Stack(
                                    children: [
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Transfer Details',
                                              style: TextStyle(
                                                  fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'User Details',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Kanit'),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const Text('Full Name',
                                                                style: TextStyle(fontFamily: 'Kanit', fontSize: 15)),
                                                            Text(
                                                              transfer.accountTransferMethod,
                                                              style: const TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                          ]),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const Text('Wallet Balance',
                                                                style: TextStyle(fontFamily: 'Kanit', fontSize: 15)),
                                                            Text(
                                                              transfer.amount.toString(),
                                                              style: const TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'BetPro Account',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Kanit'),
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const Text('Username',
                                                                style: TextStyle(fontFamily: 'Kanit', fontSize: 15)),
                                                            Text(
                                                              transfer.accountTransferMethod,
                                                              style: const TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                          ]),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const Text('Balance',
                                                                style: TextStyle(fontFamily: 'Kanit', fontSize: 15)),
                                                            Text(
                                                              transfer.amount.toString(),
                                                              style: const TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            title: const Text(
                                                              'Confirm Transfer',
                                                              style: TextStyle(fontFamily: 'Kanit'),
                                                            ),
                                                            content: Text(
                                                              'Are you sure to transfer ${transfer.amount} to BetPro Account?',
                                                              style: const TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text(
                                                                    'No',
                                                                    style: TextStyle(
                                                                        fontFamily: 'Kanit',
                                                                        fontSize: 15,
                                                                        color: Colors.black),
                                                                  )),
                                                              TextButton(
                                                                  onPressed: () {
                                                                    transferProvider.updateTransfer(transfer.id.toString(), 'accepted');
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text(
                                                                    'Yes',
                                                                    style: TextStyle(
                                                                        fontFamily: 'Kanit',
                                                                        fontSize: 15,
                                                                        color: Colors.black),
                                                                  )),
                                                            ],
                                                          ));
                                                    },
                                                    child: Container(
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            'Accept',
                                                            style: TextStyle(
                                                                color: Colors.white, fontFamily: 'Kanit'),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            title: const Text(
                                                              'Reject Transfer',
                                                              style: TextStyle(fontFamily: 'Kanit'),
                                                            ),
                                                            content: const Text(
                                                              'Are you sure to reject the transfer',
                                                              style: TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text(
                                                                    'No',
                                                                    style: TextStyle(
                                                                        fontFamily: 'Kanit',
                                                                        fontSize: 15,
                                                                        color: Colors.black),
                                                                  )),
                                                              TextButton(
                                                                  onPressed: () {
                                                                    transferProvider.updateTransfer(transfer.id.toString(), 'rejected');
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text(
                                                                    'Yes',
                                                                    style: TextStyle(
                                                                        fontFamily: 'Kanit',
                                                                        fontSize: 15,
                                                                        color: Colors.black),
                                                                  )),
                                                            ],
                                                          ));
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        height: 50,
                                                        child: const Center(
                                                          child: Text(
                                                            'Reject',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily: 'Kanit',
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          top: -5,
                                          right: -5,
                                          child: IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color.fromARGB(255, 26, 153, 30), width: 2),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Transfer to Wallet',
                                    style: TextStyle(
                                        color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
                                  ),
                                  subtitle: Text(
                                    'From BetPro Account\nusername: ${transfer.accountTransferMethod}',
                                    style: const TextStyle(fontFamily: 'Kanit'),
                                  ),
                                  leading: const Icon(Icons.download),
                                  trailing: Text(
                                    'Rs: ${transfer.amount}',
                                    style: const TextStyle(fontSize: 15, fontFamily: 'Kanit'),
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    const Spacer(),
                                    Text(
                                      transfer.timestamp.toString(),
                                      style: const TextStyle(fontFamily: 'Kanit'),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                                const SizedBox(height: 5)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10)
                      ],
                    )
                        : Container();
                  },
                );
              },
            ),
            Consumer<TransferProvider>(
              builder: (context, transferProvider, child) {
                if (transferProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final pendingTransfers = transferProvider.transfers;
                if (pendingTransfers.isEmpty) {
                  return const Center(child: Text('No transfers found.'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: pendingTransfers.length,
                  itemBuilder: (context, index) {
                    final transfer = pendingTransfers[index];
                    return transfer.accountTransferMethod == "Wallet to BPro Account"
                        ? Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                insetPadding: const EdgeInsets.all(20),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Stack(
                                    children: [
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Transfer Details',
                                              style: TextStyle(
                                                  fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'User Details',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Kanit'),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const Text('Full Name',
                                                                style: TextStyle(fontFamily: 'Kanit', fontSize: 15)),
                                                            Text(
                                                              transfer.accountTransferMethod,
                                                              style: const TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                          ]),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const Text('Wallet Balance',
                                                                style: TextStyle(fontFamily: 'Kanit', fontSize: 15)),
                                                            Text(
                                                              transfer.amount.toString(),
                                                              style: const TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'BetPro Account',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Kanit'),
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const Text('Username',
                                                                style: TextStyle(fontFamily: 'Kanit', fontSize: 15)),
                                                            Text(
                                                              transfer.accountTransferMethod,
                                                              style: const TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                          ]),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const Text('Balance',
                                                                style: TextStyle(fontFamily: 'Kanit', fontSize: 15)),
                                                            Text(
                                                              transfer.amount.toString(),
                                                              style: const TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            title: const Text(
                                                              'Confirm Transfer',
                                                              style: TextStyle(fontFamily: 'Kanit'),
                                                            ),
                                                            content: Text(
                                                              'Are you sure to transfer ${transfer.amount} to BetPro Account?',
                                                              style: const TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text(
                                                                    'No',
                                                                    style: TextStyle(
                                                                        fontFamily: 'Kanit',
                                                                        fontSize: 15,
                                                                        color: Colors.black),
                                                                  )),
                                                              TextButton(
                                                                  onPressed: () {
                                                                    transferProvider.updateTransfer(transfer.id.toString(), 'accepted');
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text(
                                                                    'Yes',
                                                                    style: TextStyle(
                                                                        fontFamily: 'Kanit',
                                                                        fontSize: 15,
                                                                        color: Colors.black),
                                                                  )),
                                                            ],
                                                          ));
                                                    },
                                                    child: Container(
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            'Accept',
                                                            style: TextStyle(
                                                                color: Colors.white, fontFamily: 'Kanit'),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            title: const Text(
                                                              'Reject Transfer',
                                                              style: TextStyle(fontFamily: 'Kanit'),
                                                            ),
                                                            content: const Text(
                                                              'Are you sure to reject the transfer',
                                                              style: TextStyle(
                                                                  fontFamily: 'Kanit', fontSize: 15),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text(
                                                                    'No',
                                                                    style: TextStyle(
                                                                        fontFamily: 'Kanit',
                                                                        fontSize: 15,
                                                                        color: Colors.black),
                                                                  )),
                                                              TextButton(
                                                                  onPressed: () {
                                                                    transferProvider.updateTransfer(transfer.id.toString(), 'rejected');
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text(
                                                                    'Yes',
                                                                    style: TextStyle(
                                                                        fontFamily: 'Kanit',
                                                                        fontSize: 15,
                                                                        color: Colors.black),
                                                                  )),
                                                            ],
                                                          ));
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        height: 50,
                                                        child: const Center(
                                                          child: Text(
                                                            'Reject',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily: 'Kanit',
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          top: -5,
                                          right: -5,
                                          child: IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color.fromARGB(255, 26, 153, 30), width: 2),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Transfer to Wallet',
                                    style: TextStyle(
                                        color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
                                  ),
                                  subtitle: Text(
                                    'From BetPro Account\nusername: ${transfer.accountTransferMethod}',
                                    style: const TextStyle(fontFamily: 'Kanit'),
                                  ),
                                  leading: const Icon(Icons.download),
                                  trailing: Text(
                                    'Rs: ${transfer.amount}',
                                    style: const TextStyle(fontSize: 15, fontFamily: 'Kanit'),
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    const Spacer(),
                                    Text(
                                      transfer.timestamp.toString(),
                                      style: const TextStyle(fontFamily: 'Kanit'),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                                const SizedBox(height: 5)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10)
                      ],
                    )
                        : Container();
                  },
                );
              },
            )

          ],
        ),
      ),
    );
  }
}
