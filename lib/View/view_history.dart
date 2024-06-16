import 'package:flutter/material.dart';

class ViewHistory extends StatefulWidget {
  const ViewHistory({super.key});

  @override
  State<ViewHistory> createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('History',
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
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.currency_exchange,
                        size: 40,
                      ),
                      title: Text('Account Remaining Balance',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 15
                      ),
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
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.green.withOpacity(0.8),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today Deposit History',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today Rejected Deposit',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today Approved Deposit',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today Total Deposit',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yesterday Deposit History',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yesterday Rejected Deposit',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yesterday Approved Deposit',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
            
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yesterday Total Deposit',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.green.withOpacity(0.8),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today Withdraw History',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today Rejected Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today Approved Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today Total Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yesterday Withdraw History',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yesterday Rejected Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yesterday Approved Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
            
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yesterday Total Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.green.withOpacity(0.8),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Approved and Rejected Deposits',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Approved',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rejected',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pending',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
            
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.green.withOpacity(0.8),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Approved and Rejected Withdraw',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Approved',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Color(0xffFF9800FF),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rejected',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pending',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
            
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
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
