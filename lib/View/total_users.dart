import 'package:flutter/material.dart';

class TotalUsers extends StatefulWidget {
  const TotalUsers({super.key});

  @override
  State<TotalUsers> createState() => _TotalUsersState();
}

class _TotalUsersState extends State<TotalUsers> {
  final List<Map<String, String>> users = [
    {
      'name': 'Jane Smith',
      'number': '1234567890',
      'amount': '200',
      'accountStatus': 'BetPro Activated',
      'userStatus': 'User Active',
      'whatsappNumber' : '5544661212',
      'email' : 'abc@gmail.com'
    },
    {
      'name': 'John Doe',
      'number': '0987654321',
      'amount': '300',
      'accountStatus': 'BetPro Inactive',
      'userStatus': 'User Inactive',
      'whatsappNumber' : '55441212',
      'email' : 'def@gmail.com'
    },
    {
      'name': 'Alice Johnson',
      'number': '5555555555',
      'amount': '400',
      'accountStatus': 'BetPro Activated',
      'userStatus': 'User Active',
      'whatsappNumber' : '1234661212',
      'email' : 'ghi@gmail.com'
    },
  ];

  List<Map<String, String>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = users;
  }


  void filterUsers(String query) {
    final queryLower = query.toLowerCase();
    final List<Map<String, String>> filtered = users.where((user) {
      final nameLower = user['name']!.toLowerCase();
      final numberLower = user['number']!;
      final whatsappNumberLower = user['whatsappNumber']!;
      final emailLower = user['email']!.toLowerCase();

      return nameLower.contains(queryLower) ||
          numberLower.contains(queryLower) ||
          whatsappNumberLower.contains(queryLower) ||
          emailLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredUsers = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Total Users (${users.length})',
          style: const TextStyle(
              color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
        ),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.green, // Change global cursor color here
            selectionHandleColor: Colors.green, // Change handle color here
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Enter Name, Email, WA# or Email",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Kanit'

                  ),
                  hintStyle: TextStyle(
                      fontFamily: 'Kanit'
                  ),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),

                ),
                onChanged: (value) {
                  filterUsers(value);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final transaction = filteredUsers[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => UserDetailDialog(),
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
                                  title: Text(
                                    transaction['name']!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Kanit',
                                        fontSize: 15),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${transaction['number']!}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Kanit',
                                            fontSize: 15),
                                      ),
                                      Text(
                                        'WA: ${transaction['whatsappNumber']!}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Kanit',
                                            fontSize: 15),
                                      ),
                                      Text(
                                        transaction['email']!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Kanit',
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  leading: const Icon(Icons.person),
                                  trailing: Text(
                                    'Current Balance \n Rs: ${transaction['amount']}',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 15, fontFamily: 'Kanit'),
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Text('${transaction['accountStatus']!}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Kanit',
                                            color:
                                                (transaction['accountStatus'] ==
                                                        'BetPro Inactive')
                                                    ? Colors.red
                                                    : Colors.green)),
                                    const Spacer(),
                                    Text(transaction['userStatus']!,
                                    style: TextStyle(
                                      fontFamily: 'Kanit'
                                    ),
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDetailDialog extends StatefulWidget {
  const UserDetailDialog({super.key});

  @override
  State<UserDetailDialog> createState() => _UserDetailDialogState();
}

class _UserDetailDialogState extends State<UserDetailDialog> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 18),
                  Container(
                      height: 45,
                      child: TextField(
                        style: TextStyle(
                            fontFamily: 'Kanit'
                        ),
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Kanit'
                          ),
                          border:
                          OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),

                        ),
                      )),
                  const SizedBox(height: 10),
                  Container(
                      height: 45,
                      child: TextField(
                        style: TextStyle(
                            fontFamily: 'Kanit'
                        ),
                        decoration: InputDecoration(
                          labelText: 'Login By',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Kanit',

                          ),
                          border:
                          OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      )),
                  const SizedBox(height: 10),
                  Container(
                      height: 45,
                      child: TextField(
                        style: TextStyle(
                            fontFamily: 'Kanit'
                        ),
                        decoration: InputDecoration(
                          labelText: 'WhatsApp',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Kanit'
                          ),
                          border:
                          OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      )),
                  const SizedBox(height: 10),
                  Container(
                      height: 45,
                      child: TextField(
                        style: TextStyle(
                            fontFamily: 'Kanit'
                        ),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Kanit'
                          ),
                          border:
                          OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      )),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(10),
                            ),
                            child: TextField(
                              style: TextStyle(
                                  fontFamily: 'Kanit'
                              ),
                              decoration: InputDecoration(
                                labelText: 'Amount',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Kanit'
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        10)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder:
                                    (context) =>
                                    AlertDialog(
                                      title: const Text(
                                        'Confirmation',
                                        style: TextStyle(
                                            fontFamily: 'Kanit'

                                        ),
                                      ),
                                      content:
                                      const Text(
                                        'Are you sure you want to update',
                                        style: TextStyle(
                                            fontFamily: 'Kanit'

                                        ),),
                                      actions: [
                                        TextButton(
                                            onPressed:
                                                () {
                                              Navigator.pop(context);
                                            },
                                            child:
                                            const Text('No',
                                              style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: Colors.black

                                              ),)),
                                        TextButton(
                                            onPressed:
                                                () {
                                              Navigator.pop(context);
                                            },
                                            child:
                                            const Text('Yes',
                                              style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  color: Colors.black

                                              ),)),
                                      ],
                                    ));
                          },
                          child: Container(
                              decoration:
                              BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                BorderRadius
                                    .circular(10),
                              ),
                              height: 45,
                              child: const Center(
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                      fontFamily: 'Kanit',
                                      color: Colors
                                          .white),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding:
                      const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 45,
                            child: const Text(
                              'BetPro Account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight:
                                  FontWeight.bold,
                                  fontFamily: 'Kanit',
                                  fontSize: 20),
                            ),
                          ),
                          Container(
                              height: 45,
                              child: TextField(
                                style: TextStyle(
                                    fontFamily: 'Kanit'
                                ),
                                decoration: InputDecoration(
                                  labelText:
                                  'BetPro Username',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Kanit'

                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 10),
                          Container(
                              child: TextField(
                                style: TextStyle(
                                    fontFamily: 'Kanit'
                                ),
                                decoration: InputDecoration(
                                  labelText:
                                  'BetPro Password',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Kanit',
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 10),
                          SwitchListTile(
                            title: const Text(
                                'Activate',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                )),
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            },
                            activeColor: Colors.green,
                            activeTrackColor: Colors
                                .green
                                .withOpacity(0.5),
                            inactiveThumbColor:
                            Colors.grey,
                            inactiveTrackColor: Colors
                                .grey
                                .withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding:
                      const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          const Text(
                            'CONNECT TO WHATSAPP',
                            style: TextStyle(
                                fontFamily: 'Kanit'
                            ),
                          ),
                          Image.asset(
                            'assets/images/whatsapp_icon.png',
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                          'ENABLE/DISABLE USER',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Kanit'
                          ),
                        )),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                          'SHOW USER HISTORY',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Kanit'
                          ),
                        )),
                  ),
                ],
              ),
              Positioned(
                top: -15,
                right: -15,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
