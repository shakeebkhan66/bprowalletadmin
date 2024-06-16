import 'package:bpro_wallet_admin/View/Transactions/transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingTransactions extends StatefulWidget {
  const PendingTransactions({super.key});

  @override
  State<PendingTransactions> createState() => _PendingTransactionsState();
}

class _PendingTransactionsState extends State<PendingTransactions> {
  // Sample data for deposit transactions
  final List<Map<String, String>> depositTransactions = [
    {
      'name': 'John Doe',
      'type': 'Deposit',
      'amount': '500',
      'date': '2024-06-01',
      'approved': 'Pending'
    },
    {
      'name': 'Alice Johnson',
      'type': 'Deposit',
      'amount': '300',
      'date': '2024-06-03',
      'approved': 'Pending'
    },
    {
      'name': 'Charlie Davis',
      'type': 'Deposit',
      'amount': '400',
      'date': '2024-06-05',
      'approved': 'Pending'
    },
    {
      'name': 'Eve Foster',
      'type': 'Deposit',
      'amount': '250',
      'date': '2024-06-07',
      'approved': 'Pending'
    },
    {
      'name': 'Grace Hall',
      'type': 'Deposit',
      'amount': '450',
      'date': '2024-06-09',
      'approved': 'Pending'
    },
  ];

  // Sample data for withdraw transactions
  final List<Map<String, String>> withdrawTransactions = [
    {
      'name': 'Jane Smith',
      'type': 'Withdraw',
      'amount': '200',
      'date': '2024-06-02',
      'approved': 'Pending'
    },
    {
      'name': 'Bob Brown',
      'type': 'Withdraw',
      'amount': '150',
      'date': '2024-06-04',
      'approved': 'Pending'
    },
    {
      'name': 'Diana Evans',
      'type': 'Withdraw',
      'amount': '100',
      'date': '2024-06-06',
      'approved': 'Pending'
    },
    {
      'name': 'Frank Green',
      'type': 'Withdraw',
      'amount': '300',
      'date': '2024-06-08',
      'approved': 'Pending'
    },
    {
      'name': 'Hank Irwin',
      'type': 'Withdraw',
      'amount': '350',
      'date': '2024-06-10',
      'approved': 'Pending'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // This should match the number of tabs
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
          title: const Text('Pending Transactions',
              style: TextStyle(color: Colors.white, fontFamily: 'Kanit')),

          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Kanit'),
            tabs: [
              Tab(
                text: 'DEPOSIT',
              ),
              Tab(text: 'WITHDRAW'),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
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
              child: ListView.builder(
                itemCount: depositTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = depositTransactions[index];
                  return GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Approve Transaction',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.bold
                            )
                            ),
                            content: Text('Do you want to approve this transaction?',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 15
                            ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    transaction['approved'] = 'Rejected';
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text('Reject',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                fontSize: 15,
                                color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    transaction['approved'] = 'Approved';
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text('Approve',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.black
                                ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Column(
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
                                                  'Approved')
                                              ? Colors.green
                                              : Colors.red)),
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
                    ),
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
                  return GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Approve Transaction',
                                style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            content: Text('Do you want to approve this transaction?',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                fontSize: 15
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    transaction['approved'] = 'Rejected';
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text('Reject',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  color: Colors.black,
                                  fontSize: 15
                                ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    transaction['approved'] = 'Approved';
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text('Approve',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Column(
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
                                subtitle: Text('To: ${transaction['name']!}'),
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
                                                  'Approved')
                                              ? Colors.green
                                              : Colors.red)),
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
