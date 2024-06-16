import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final List<Map<String, String>> depositTransactions = [
    {
      'name': 'John Doe',
      'type': 'Deposit',
      'amount': '500',
      'date': '2024-06-01',
      'approved': 'Approved'
    },
    {
      'name': 'Alice Johnson',
      'type': 'Deposit',
      'amount': '300',
      'date': '2024-06-03',
      'approved': 'Approved'
    },
    {
      'name': 'Charlie Davis',
      'type': 'Deposit',
      'amount': '400',
      'date': '2024-06-05',
      'approved': 'Approved'
    },
    {
      'name': 'Eve Foster',
      'type': 'Deposit',
      'amount': '250',
      'date': '2024-06-07',
      'approved': 'Approved'
    },
    {
      'name': 'Grace Hall',
      'type': 'Deposit',
      'amount': '450',
      'date': '2024-06-09',
      'approved': 'Approved'
    },
  ];

  // Sample data for withdraw transactions
  final List<Map<String, String>> withdrawTransactions = [
    {
      'name': 'Jane Smith',
      'type': 'Withdraw',
      'amount': '200',
      'date': '2024-06-02',
      'approved': 'Approved'
    },
    {
      'name': 'Bob Brown',
      'type': 'Withdraw',
      'amount': '150',
      'date': '2024-06-04',
      'approved': 'Approved'
    },
    {
      'name': 'Diana Evans',
      'type': 'Withdraw',
      'amount': '100',
      'date': '2024-06-06',
      'approved': 'Approved'
    },
    {
      'name': 'Frank Green',
      'type': 'Withdraw',
      'amount': '300',
      'date': '2024-06-08',
      'approved': 'Approved'
    },
    {
      'name': 'Hank Irwin',
      'type': 'Withdraw',
      'amount': '350',
      'date': '2024-06-10',
      'approved': 'Approved'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // This should match the number of tabs
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
          title: const Text('Transactions',
              style: TextStyle(color: Colors.white, fontFamily: 'Kanit')),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Kanit'),
            isScrollable: true,
            tabs: [
              Tab(
                text: 'DEPOSIT',
              ),
              Tab(text: 'WITHDRAW'),
              Tab(
                text: 'CANCELED',
              ),
              Tab(
                text: 'REJECTED DEPOSIT',
              ),
              Tab(
                text: 'REJECTED WITHDRAW',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: depositTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = depositTransactions[index];
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
                                'Deposit',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit'),
                              ),
                              subtitle: Text(
                                'To: ${transaction['name']!}',
                                style: TextStyle(fontFamily: 'Kanit'),
                              ),
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
                                  ),),
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
                itemCount: withdrawTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = withdrawTransactions[index];
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
                                'Withdraw',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit'),
                              ),
                              subtitle: Text(
                                'To: ${transaction['name']!}',
                                style: TextStyle(fontFamily: 'Kanit'),
                              ),
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
                                  ),),
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
            Center(
                child: Text(
              'Canceled Content',
              style: TextStyle(fontFamily: 'Kanit'),
            )),
            Center(
                child: Text(
              'Rejected Deposit Content',
              style: TextStyle(fontFamily: 'Kanit'),
            )),
            Center(
                child: Text('Rejected Withdraw Content',
                    style: TextStyle(fontFamily: 'Kanit'))),
          ],
        ),
      ),
    );
  }
}
