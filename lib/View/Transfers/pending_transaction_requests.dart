import 'package:bpro_wallet_admin/View/Transfers/completed_transfers.dart';
import 'package:flutter/material.dart';

class PendingTransactionRequests extends StatefulWidget {
  const PendingTransactionRequests({super.key});

  @override
  State<PendingTransactionRequests> createState() =>
      _PendingTransactionRequestsState();
}

class _PendingTransactionRequestsState
    extends State<PendingTransactionRequests> {
  final List<Map<String, String>> pendingBetProAccount = [
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
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
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
            tabs: [
              Tab(
                text: 'BETPRO ACCOUNT',
              ),
              Tab(text: 'WALLET (${pendingBetProAccount.length})'),
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
                    builder: (context) => const CompletedTransfers(),
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
                itemCount: pendingBetProAccount.length,
                itemBuilder: (context, index) {
                  final transaction = pendingBetProAccount[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              insetPadding: EdgeInsets.all(20),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Transfer Details',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Kanit'
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                child: Text(
                                                  'User Details',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Kanit'
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                      Text('Full Name',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Kanit',
                                                          fontSize: 15
                                                          )),
                                                      Text(
                                                        transaction['name']!,
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                        fontSize: 15
                                                        ),
                                                      ),
                                                    ]),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('WhatsApp Number',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Kanit',
                                                                  fontSize: 15
                                                              )),
                                                          Text(
                                                            '03123456789',
                                                            style: TextStyle(
                                                                fontFamily: 'Kanit',
                                                                fontSize: 15
                                                            ),
                                                          ),
                                                        ]),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('Wallet Balance',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Kanit',
                                                                  fontSize: 15
                                                              )),
                                                          Text(
                                                            transaction['amount']!,
                                                            style: TextStyle(
                                                                fontFamily: 'Kanit',
                                                                fontSize: 15
                                                            ),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                child: Text(
                                                  'BetPro Account',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Kanit'),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('Username',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Kanit',
                                                                  fontSize: 15
                                                              )),
                                                          Text(
                                                            transaction['name']!,
                                                            style: TextStyle(
                                                                fontFamily: 'Kanit',
                                                                fontSize: 15
                                                            ),
                                                          ),
                                                        ]),
                                                    SizedBox(height: 10,),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('Balance',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Kanit',
                                                                  fontSize: 15
                                                              )),
                                                          Text(
                                                            transaction['amount']!,
                                                            style: TextStyle(
                                                                fontFamily: 'Kanit',
                                                                fontSize: 15
                                                            ),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                'Confirm Transfer',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Kanit'),
                                                              ),
                                                              content: Text(
                                                                'Are you sure to transfer ${transaction['amount']} to BetPro Account?',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Kanit',
                                                                fontSize: 15
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'No',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Kanit',
                                                                      fontSize: 15,
                                                                      color: Colors.black),
                                                                    )),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Kanit',
                                                                      fontSize: 15,
                                                                      color: Colors.black
                                                                      ),
                                                                    )),
                                                              ],
                                                            ));
                                                  },
                                                  child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Accept',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily:
                                                                  'Kanit'),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                'Reject Transfer',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Kanit'),
                                                              ),
                                                              content: Text(
                                                                'Are you sure to reject the transfer',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Kanit',
                                                                fontSize: 15
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'No',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Kanit',
                                                                      fontSize: 15,
                                                                      color: Colors.black
                                                                      ),
                                                                    )),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Kanit',
                                                                      fontSize: 15,
                                                                      color: Colors.black
                                                                      ),
                                                                    )),
                                                              ],
                                                            ));
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                      ),
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                          'Reject',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily:
                                                                  'Kanit',
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
                                          icon: Icon(Icons.close),
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
                            border: Border.all(
                                color: const Color.fromARGB(255, 26, 153, 30),
                                width: 2),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text(
                                  'Transfer to Betpro Account',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Kanit',
                                      fontSize: 15),
                                ),
                                subtitle: Text(
                                  'To BetPro Account\nusername: ${transaction['name']!}',
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
                                  Text(
                                    transaction['date']!,
                                    style: TextStyle(fontFamily: 'Kanit'),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 5)
                            ],
                          ),
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
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              insetPadding: EdgeInsets.all(20),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Transfer Details',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Kanit'
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                child: Text(
                                                  'User Details',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Kanit'
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('Full Name',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Kanit',
                                                                  fontSize: 15
                                                              )),
                                                          Text(
                                                            transaction['name']!,
                                                            style: TextStyle(
                                                                fontFamily: 'Kanit',
                                                                fontSize: 15
                                                            ),
                                                          ),
                                                        ]),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('WhatsApp Number',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Kanit',
                                                                  fontSize: 15
                                                              )),
                                                          Text(
                                                            '03123456789',
                                                            style: TextStyle(
                                                                fontFamily: 'Kanit',
                                                                fontSize: 15
                                                            ),
                                                          ),
                                                        ]),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('Wallet Balance',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Kanit',
                                                                  fontSize: 15
                                                              )),
                                                          Text(
                                                            transaction['amount']!,
                                                            style: TextStyle(
                                                                fontFamily: 'Kanit',
                                                                fontSize: 15
                                                            ),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                child: Text(
                                                  'BetPro Account',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Kanit'),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('Username',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Kanit',
                                                                  fontSize: 15
                                                              )),
                                                          Text(
                                                            transaction['name']!,
                                                            style: TextStyle(
                                                                fontFamily: 'Kanit',
                                                                fontSize: 15
                                                            ),
                                                          ),
                                                        ]),
                                                    SizedBox(height: 10,),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('Balance',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Kanit',
                                                                  fontSize: 15
                                                              )),
                                                          Text(
                                                            transaction['amount']!,
                                                            style: TextStyle(
                                                                fontFamily: 'Kanit',
                                                                fontSize: 15
                                                            ),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                'Confirm Transfer',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    'Kanit'),
                                                              ),
                                                              content: Text(
                                                                'Are you sure to transfer ${transaction['amount']} to BetPro Account?',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    'Kanit',
                                                                    fontSize: 15
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'No',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                          'Kanit',
                                                                          fontSize: 15,
                                                                          color: Colors.black),
                                                                    )),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                          'Kanit',
                                                                          fontSize: 15,
                                                                          color: Colors.black
                                                                      ),
                                                                    )),
                                                              ],
                                                            ));
                                                  },
                                                  child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Accept',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily:
                                                              'Kanit'),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                'Reject Transfer',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    'Kanit'),
                                                              ),
                                                              content: Text(
                                                                'Are you sure to reject the transfer',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    'Kanit',
                                                                    fontSize: 15
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'No',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                          'Kanit',
                                                                          fontSize: 15,
                                                                          color: Colors.black
                                                                      ),
                                                                    )),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                          'Kanit',
                                                                          fontSize: 15,
                                                                          color: Colors.black
                                                                      ),
                                                                    )),
                                                              ],
                                                            ));
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                      ),
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                          'Reject',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                            'Kanit',
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
                                          icon: Icon(Icons.close),
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
                            border: Border.all(
                                color: const Color.fromARGB(255, 26, 153, 30),
                                width: 2),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text(
                                  'Transfer to Wallet',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Kanit'),
                                ),
                                subtitle: Text(
                                  'From BetPro Account\nusername: ${transaction['name']!}',
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
                                  Text(
                                    transaction['date']!,
                                    style: TextStyle(fontFamily: 'Kanit'),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 5)
                            ],
                          ),
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
  }
}
