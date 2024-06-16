import 'package:flutter/material.dart';

class CompletedTransfers extends StatefulWidget {
  const CompletedTransfers({super.key});

  @override
  State<CompletedTransfers> createState() => _CompletedTransfersState();
}

class _CompletedTransfersState extends State<CompletedTransfers> {
  final List<Map<String, String>> pendingBetProAccount = [
    {
      'name': 'Jane Smith',
      'type': 'Withdraw',
      'amount': '200',
      'date': '2024-06-02',
      'approved': 'Completed'
    },
    {
      'name': 'Bob Brown',
      'type': 'Withdraw',
      'amount': '150',
      'date': '2024-06-04',
      'approved': 'Completed'
    },
    {
      'name': 'Diana Evans',
      'type': 'Withdraw',
      'amount': '100',
      'date': '2024-06-06',
      'approved': 'Completed'
    },
    {
      'name': 'Frank Green',
      'type': 'Withdraw',
      'amount': '300',
      'date': '2024-06-08',
      'approved': 'Completed'
    },
    {
      'name': 'Hank Irwin',
      'type': 'Withdraw',
      'amount': '350',
      'date': '2024-06-10',
      'approved': 'Completed'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.green,
          title: const Text('Completed Transfers',
              style: TextStyle(color: Colors.white, fontFamily: 'Kanit')),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Kanit'),
            tabs: [
              Tab(
                text: 'BETPRO ACCOUNT',
              ),
              Tab(text: 'WALLET'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: pendingBetProAccount.length,
                itemBuilder: (context, index) {
                  final transaction = pendingBetProAccount[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color.fromARGB(255, 26, 153, 30),
                              width: 2),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text(
                                'Transfered to Betpro Account',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Kanit',
                                    fontSize: 15,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                  'To BetPro Account\nusername: ${transaction['name']!}'),
                              leading: const Icon(Icons.download),
                              trailing: Text(
                                'Rs: ${transaction['amount']}',
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Kanit'),
                              ),
                            ),
                            Divider(),
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                Text('${transaction['approved']!}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Kanit',
                                        color: (transaction['approved'] ==
                                                'Pending')
                                            ? Colors.red
                                            : Colors.green)),
                                const Spacer(),
                                Text(transaction['date']!,
                                style: TextStyle(
                                  fontFamily: 'Kanit'
                                ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 5)
                          ],
                        ),
                      ),
                      SizedBox(height: 10)
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: pendingBetProAccount.length,
                itemBuilder: (context, index) {
                  final transaction = pendingBetProAccount[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color.fromARGB(255, 26, 153, 30),
                              width: 2),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text(
                                'Transfered to Wallet',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit'),
                              ),
                              subtitle: Text(
                                  'From BetPro Account\nusername: ${transaction['name']!}'),
                              leading: const Icon(Icons.download),
                              trailing: Text(
                                'Rs: ${transaction['amount']}',
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Kanit'),
                              ),
                            ),
                            Divider(),
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                Text('${transaction['approved']!}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Kanit',
                                        color: (transaction['approved'] ==
                                                'Pending')
                                            ? Colors.red
                                            : Colors.green)),
                                const Spacer(),
                                Text(transaction['date']!,
                                style: TextStyle(
                                  fontFamily: 'Kanit'
                                ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 5)
                          ],
                        ),
                      ),
                      SizedBox(height: 10)
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
