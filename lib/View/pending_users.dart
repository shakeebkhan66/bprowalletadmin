import 'package:bpro_wallet_admin/View/admin_panel.dart';
import 'package:bpro_wallet_admin/providers/deposit_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingUsers extends StatefulWidget {
  final List<Map<String, String>> pendingUsers;

  const PendingUsers({super.key, required this.pendingUsers});

  @override
  State<PendingUsers> createState() => _PendingUsersState();
}

class _PendingUsersState extends State<PendingUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Pending Users',
            style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.green,
            selectionHandleColor: Colors.green,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView.builder(
            itemCount: widget.pendingUsers.length,
            itemBuilder: (context, index) {
              final transaction = widget.pendingUsers[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => UserDetailDialog(
                          depositUserId: transaction['id'].toString(),
                          stateOfUser: transaction['stateOfUser'].toString(),
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
                            title: Text(
                              transaction['name']!,
                              style: const TextStyle(color: Colors.black, fontFamily: 'Kanit', fontSize: 15),
                            ),
                            subtitle: Text(
                              transaction['number']!,
                              style: const TextStyle(color: Colors.black, fontFamily: 'Kanit', fontSize: 15),
                            ),
                            leading: const Icon(Icons.person),
                            trailing: Text(
                              'Rs: ${transaction['amount']}',
                              style: const TextStyle(fontSize: 15, fontFamily: 'Kanit'),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                transaction['stateOfUser'].toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Kanit',
                                    color: transaction['stateOfUser'] == 'inActive' ? Colors.red : Colors.green),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text(transaction['status']!,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Kanit',
                                      color: (transaction['status'] == 'BetPro Inactive') ? Colors.red : Colors.green)),
                              const Spacer(),
                              Text(
                                transaction['date']!,
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
              );
            },
          ),
        ),
      ),
    );
  }
}

class UserDetailDialog extends StatefulWidget {
  final String depositUserId;
  final String stateOfUser;

  const UserDetailDialog({super.key, required this.depositUserId, required this.stateOfUser});

  @override
  State<UserDetailDialog> createState() => _UserDetailDialogState();
}

class _UserDetailDialogState extends State<UserDetailDialog> {
  late bool isSwitched;
  bool _isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSwitched = widget.stateOfUser == 'active';
  }

  Future<void> _updateUserDetails() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    final String newStateOfUser = isSwitched ? 'active' : 'inActive';

    print("stateOfUser $newStateOfUser");

    try {
        print("abak");
          setState(() {
            _isLoading = true;
          });
          await Provider.of<DepositDetailsProvider>(context, listen: false)
              .updateBProAccountDetails(widget.depositUserId, newStateOfUser, username, password);
          await Future.delayed(const Duration(seconds: 2));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('BPro Account Created')));


    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating user details: $e')));
    }
    finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminPanel()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: Text(
                                    'BetPro Account',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Kanit',
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                    height: 45,
                                    child: TextField(
                                      controller: _usernameController,
                                      style: const TextStyle(fontFamily: 'Kanit'),
                                      decoration: InputDecoration(
                                        labelText: 'BetPro Username',
                                        labelStyle: const TextStyle(color: Colors.black, fontFamily: 'Kanit'),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.green, width: 2.0),
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        ),
                                      ),
                                    )),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: _passwordController,
                                  style: const TextStyle(fontFamily: 'Kanit'),
                                  decoration: InputDecoration(
                                    labelText: 'BetPro Password',
                                    labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Kanit',
                                    ),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SwitchListTile(
                                  title: const Text('Activate',
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                      )),
                                  value: isSwitched,
                                  onChanged: (value) async {
                                    setState(() {
                                      isSwitched = value;
                                    });
                                    await _updateUserDetails();
                                  },
                                  activeColor: Colors.green,
                                  activeTrackColor: Colors.green.withOpacity(0.5),
                                  inactiveThumbColor: Colors.grey,
                                  inactiveTrackColor: Colors.grey.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
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
