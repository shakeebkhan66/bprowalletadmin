import 'dart:ffi';

import 'package:bpro_wallet_admin/View/Transactions/pending.dart';
import 'package:bpro_wallet_admin/View/Transfers/pending_transaction_requests.dart';
import 'package:bpro_wallet_admin/View/pending_users.dart';
import 'package:bpro_wallet_admin/View/total_users.dart';
import 'package:bpro_wallet_admin/View/view_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../providers/deposit_detail_provider.dart';
import '../providers/payment_method_provider.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  bool isSwitchedAcc1 = false;
  bool isSwitchedAcc2 = false;
  TextEditingController aboutController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController processTimeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accountHolderController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  String? _selectedAccountMethod;

  String about =
      'Ab \'betprocash.com\' se aap apk download ker sakte hain or apne doston k sath share ker sakte hain.';
  String supportDetail = 'Contact Support 24/7  03103208154';
  String processTime = '30 Minutes';

  List<File> images = [];

  File? _image;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }



  void _showAddPaymentMethodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Payment Method'),
          content: Consumer<PaymentMethodProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: _accountHolderController,
                          decoration: const InputDecoration(labelText: 'Account Holder Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the account holder name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            Provider.of<PaymentMethodProvider>(context, listen: false)
                                .setAccountHolderName(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _selectedAccountMethod,
                          decoration: const InputDecoration(labelText: 'Account Method Type'),
                          items: <String>['Jazzcash', 'EasyPaisa', 'Bank Account']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            _selectedAccountMethod = newValue;
                            Provider.of<PaymentMethodProvider>(context, listen: false)
                                .setAccountMethodType(newValue!);
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select an account method type';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _accountNumberController,
                          decoration: const InputDecoration(labelText: 'Account Number'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the account number';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            Provider.of<PaymentMethodProvider>(context, listen: false)
                                .setAccountNumber(value);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            Consumer<PaymentMethodProvider>(
              builder: (context, provider, child) {
                return ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await provider.addPaymentMethod();
                      Navigator.of(context).pop();
                      await provider.fetchPaymentMethods();
                      _accountNumberController.clear();
                      _accountHolderController.clear();
                    }
                  },
                  child: const Text('Submit'),
                );
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: const Color.fromARGB(255, 1, 202, 98),
    //       title: const Column(
    //         children: [
    //           Text(
    //             'Admin Home v4.4',
    //             style: TextStyle(
    //               fontFamily: 'Kanit',
    //               fontSize: 25,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.white,
    //             ),
    //           ),
    //           Text(
    //             'betproaqib@gmail.com',
    //             style: TextStyle(
    //               fontSize: 16,
    //               fontFamily: 'Kanit',
    //               color: Colors.white,
    //             ),
    //           ),
    //         ],
    //       ),
    //       centerTitle: true,
    //     ),
    //     body: Theme(
    //       data: Theme.of(context).copyWith(
    //         textSelectionTheme: const TextSelectionThemeData(
    //           cursorColor: Colors.green, // Change global cursor color here
    //           selectionHandleColor: Colors.green, // Change handle color here
    //         ),
    //       ),
    //       child: Padding(
    //           padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    //           child: SingleChildScrollView(
    //               child: Column(children: [
    //             Row(
    //               children: [
    //                 Expanded(
    //                   child: Container(
    //                     margin: const EdgeInsets.only(top: 10),
    //                     height: 80,
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => const PendingTransactions()));
    //                       },
    //                       child: const Card(
    //                         color: Colors.green,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               'Transactions',
    //                               style: TextStyle(
    //                                   color: Colors.white,
    //                                   fontFamily: 'Kanit',
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 20),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Expanded(
    //                   child: Container(
    //                     margin: const EdgeInsets.only(top: 10),
    //                     height: 80,
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) =>
    //                                     PendingTransactionRequests()));
    //                       },
    //                       child: const Card(
    //                         color: Colors.green,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               'Transfers',
    //                               style: TextStyle(
    //                                   color: Colors.white,
    //                                   fontFamily: 'Kanit',
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 20),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Expanded(
    //                   child: Container(
    //                     height: 80,
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => PendingUsers(
    //                                       pendingUsers: pendingUserss,
    //                                     )));
    //                       },
    //                       child: Card(
    //                         color: Colors.green,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             const Text(
    //                               'Pending Users',
    //                               style: TextStyle(
    //                                   color: Colors.white,
    //                                   fontFamily: 'Kanit',
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 18),
    //                             ),
    //                             Container(
    //                               height: 25,
    //                               decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(8),
    //                                 color: Colors.white,
    //                               ),
    //                               margin: const EdgeInsets.all(10),
    //                               width: double.infinity,
    //                               child: Center(
    //                                   child: Text('${pendingUserss.length}',
    //                                       style: const TextStyle(
    //                                           color: Colors.red,
    //                                           fontFamily: 'Kanit',
    //                                           fontSize: 15))),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Expanded(
    //                   child: Container(
    //                     height: 80,
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => TotalUsers()));
    //                       },
    //                       child: const Card(
    //                         color: Colors.green,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               'Total Users',
    //                               style: TextStyle(
    //                                   color: Colors.white,
    //                                   fontFamily: 'Kanit',
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 20),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Expanded(
    //                   child: GestureDetector(
    //                     onTap: () {
    //                       Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (context) => ViewHistory()));
    //                     },
    //                     child: Container(
    //                       height: 65,
    //                       child: const Card(
    //                         color: Colors.green,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               'View History',
    //                               style: TextStyle(
    //                                   color: Colors.white,
    //                                   fontFamily: 'Kanit',
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 20),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Expanded(
    //                   child: Container(
    //                     height: 65,
    //                     child: const Card(
    //                       color: Colors.green,
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Text(
    //                             'Web',
    //                             style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontFamily: 'Kanit',
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 20),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Container(
    //                 margin: const EdgeInsets.only(top: 5),
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(8),
    //                   color: Colors.green,
    //                 ),
    //                 child: ListTile(
    //                   leading: const Icon(
    //                     Icons.info,
    //                     color: Colors.white,
    //                   ),
    //                   title: Text(
    //                     about,
    //                     style: const TextStyle(
    //                         color: Colors.white,
    //                         fontFamily: 'Kanit',
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 12),
    //                   ),
    //                   subtitle: Text(
    //                     supportDetail,
    //                     style: const TextStyle(
    //                         color: Colors.yellow,
    //                         fontFamily: 'Kanit',
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 12),
    //                   ),
    //                   trailing: IconButton(
    //                     icon: const Icon(
    //                       Icons.edit,
    //                       color: Colors.white,
    //                     ),
    //                     onPressed: () {
    //                       detailController.text = supportDetail;
    //                       aboutController.text = about;
    //                       showDialog(
    //                           context: context,
    //                           builder: (BuildContext context) {
    //                             return AlertDialog(
    //                               title: const Text('Edit Details'),
    //                               content: SizedBox(
    //                                 height: 150,
    //                                 child: Theme(
    //                                   data: Theme.of(context).copyWith(
    //                                     textSelectionTheme:
    //                                         const TextSelectionThemeData(
    //                                       cursorColor: Colors
    //                                           .green, // Change global cursor color here
    //                                       selectionHandleColor: Colors
    //                                           .green, // Change handle color here
    //                                     ),
    //                                   ),
    //                                   child: Column(
    //                                     children: [
    //                                       TextField(
    //                                         controller: aboutController,
    //                                         keyboardType: TextInputType.text,
    //                                         style: const TextStyle(
    //                                             color: Colors.black,
    //                                             fontFamily: 'Kanit'),
    //                                         decoration: InputDecoration(
    //                                           labelText:
    //                                               'Enter Support Details',
    //                                           hintText: 'Support Details',
    //                                           labelStyle: const TextStyle(
    //                                               color: Colors.black,
    //                                               fontFamily: 'Kanit'),
    //                                           hintStyle: const TextStyle(
    //                                               color: Colors.grey,
    //                                               fontFamily: 'Kanit'),
    //                                           enabledBorder:
    //                                               UnderlineInputBorder(
    //                                             borderSide: BorderSide(
    //                                                 color: Colors.black
    //                                                     .withOpacity(0.5)),
    //                                           ),
    //                                           focusedBorder:
    //                                               const UnderlineInputBorder(
    //                                             borderSide: BorderSide(
    //                                                 color: Colors.green),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       const SizedBox(height: 10),
    //                                       TextField(
    //                                         controller: detailController,
    //                                         keyboardType: TextInputType.text,
    //                                         style: const TextStyle(
    //                                             color: Colors.black,
    //                                             fontFamily: 'Kanit'),
    //                                         decoration: InputDecoration(
    //                                           labelText: 'Enter About',
    //                                           hintText: 'About',
    //                                           labelStyle: const TextStyle(
    //                                               color: Colors.black,
    //                                               fontFamily: 'Kanit'),
    //                                           hintStyle: const TextStyle(
    //                                               color: Colors.grey,
    //                                               fontFamily: 'Kanit'),
    //                                           enabledBorder:
    //                                               UnderlineInputBorder(
    //                                             borderSide: BorderSide(
    //                                                 color: Colors.black
    //                                                     .withOpacity(0.5)),
    //                                           ),
    //                                           focusedBorder:
    //                                               const UnderlineInputBorder(
    //                                             borderSide: BorderSide(
    //                                                 color: Colors.green),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ),
    //                               actions: [
    //                                 TextButton(
    //                                   onPressed: () {
    //                                     Navigator.pop(context);
    //                                   },
    //                                   child: const Text(
    //                                     'Cancel',
    //                                     style: TextStyle(
    //                                       color: Colors.black,
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 ElevatedButton(
    //                                   style: ElevatedButton.styleFrom(
    //                                     backgroundColor: Colors.green,
    //                                   ),
    //                                   onPressed: () {
    //                                     setState(() {
    //                                       about = aboutController.text;
    //                                       supportDetail = detailController.text;
    //                                       Navigator.pop(context);
    //                                     });
    //                                   },
    //                                   child: const Text(
    //                                     'Save',
    //                                     style: TextStyle(color: Colors.white),
    //                                   ),
    //                                 ),
    //                               ],
    //                             );
    //                           });
    //                     },
    //                   ),
    //                 )),
    //             Container(
    //               margin: const EdgeInsets.only(top: 10),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(8),
    //                 color: Colors.green,
    //               ),
    //               child: ListTile(
    //                 leading: const Icon(
    //                   Icons.info,
    //                   color: Colors.white,
    //                 ),
    //                 title: Text(
    //                   processTime,
    //                   style: const TextStyle(
    //                       color: Colors.white,
    //                       fontFamily: 'Kanit',
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 15),
    //                 ),
    //                 trailing: IconButton(
    //                   icon: const Icon(
    //                     Icons.edit,
    //                     color: Colors.white,
    //                   ),
    //                   onPressed: () {
    //                     processTimeController.text = processTime;
    //                     showDialog(
    //                         context: context,
    //                         builder: (BuildContext context) {
    //                           return AlertDialog(
    //                             title: const Text('Edit Process Time'),
    //                             content: SizedBox(
    //                               height: 90,
    //                               child: Theme(
    //                                 data: Theme.of(context).copyWith(
    //                                   textSelectionTheme:
    //                                       const TextSelectionThemeData(
    //                                     cursorColor: Colors
    //                                         .green, // Change global cursor color here
    //                                     selectionHandleColor: Colors
    //                                         .green, // Change handle color here
    //                                   ),
    //                                 ),
    //                                 child: TextField(
    //                                   controller: processTimeController,
    //                                   keyboardType: TextInputType.text,
    //                                   style: const TextStyle(
    //                                       color: Colors.black,
    //                                       fontFamily: 'Kanit'),
    //                                   decoration: InputDecoration(
    //                                     labelText: 'Enter Process Time',
    //                                     hintText: 'Process Time',
    //                                     labelStyle: const TextStyle(
    //                                         color: Colors.black,
    //                                         fontFamily: 'Kanit'),
    //                                     hintStyle: const TextStyle(
    //                                         color: Colors.grey,
    //                                         fontFamily: 'Kanit'),
    //                                     enabledBorder: UnderlineInputBorder(
    //                                       borderSide: BorderSide(
    //                                           color: Colors.black
    //                                               .withOpacity(0.5)),
    //                                     ),
    //                                     focusedBorder:
    //                                         const UnderlineInputBorder(
    //                                       borderSide:
    //                                           BorderSide(color: Colors.green),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             actions: [
    //                               TextButton(
    //                                 onPressed: () {
    //                                   Navigator.pop(context);
    //                                 },
    //                                 child: const Text(
    //                                   'Cancel',
    //                                   style: TextStyle(
    //                                     color: Colors.black,
    //                                   ),
    //                                 ),
    //                               ),
    //                               ElevatedButton(
    //                                 style: ElevatedButton.styleFrom(
    //                                   backgroundColor: Colors.green,
    //                                 ),
    //                                 onPressed: () {
    //                                   setState(() {
    //                                     processTime =
    //                                         processTimeController.text;
    //                                     Navigator.pop(context);
    //                                   });
    //                                 },
    //                                 child: const Text(
    //                                   'Save',
    //                                   style: TextStyle(color: Colors.white),
    //                                 ),
    //                               ),
    //                             ],
    //                           );
    //                         });
    //                   },
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               width: double.infinity,
    //               height: 60,
    //               margin: const EdgeInsets.only(top: 10),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(8),
    //                 color: Colors.white,
    //                 border: Border.all(color: Colors.green, width: 2),
    //               ),
    //               child: Container(
    //                   margin: const EdgeInsets.only(
    //                       top: 10, bottom: 10, left: 50, right: 50),
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(8),
    //                     color: Colors.white,
    //                     border: Border.all(
    //                         color: Colors.black.withOpacity(0.2), width: 2),
    //                   ),
    //                   child: Center(
    //                     child: Text(
    //                       'Add payment method',
    //                       style: TextStyle(
    //                           color: Colors.black.withOpacity(0.6),
    //                           fontSize: 20,
    //                           fontFamily: 'Kanit'),
    //                     ),
    //                   )),
    //             ),
    //             const SizedBox(height: 10),
    //             Container(
    //               width: double.infinity,
    //               child: SingleChildScrollView(
    //                 scrollDirection: Axis.horizontal,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     InkWell(
    //                       onTap: pickImage,
    //                       child: CircleAvatar(
    //                         radius: 30,
    //                         backgroundColor: Colors.green,
    //                         child: Icon(
    //                           Icons.add_photo_alternate,
    //                           color: Colors.white,
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(width: 10),
    //                     Row(
    //                       children: images.map((image) {
    //                         return Container(
    //                           padding: EdgeInsets.all(1),
    //                           margin: const EdgeInsets.only(right: 10),
    //                           height: 60,
    //                           width: 60,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(30),
    //                             border:
    //                                 Border.all(color: Colors.green, width: 2),
    //                           ),
    //                           child: CircleAvatar(
    //                             radius: 30,
    //                             backgroundImage: FileImage(image),
    //                             backgroundColor: Colors.green,
    //                           ),
    //                         );
    //                       }).toList(),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 10),
    //             Container(
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(8),
    //                 border: Border.all(color: Colors.green, width: 2),
    //               ),
    //               child: SwitchListTile(
    //                 title: const Text(
    //                   'Easypaisa',
    //                   style: TextStyle(
    //                     fontFamily: 'Kanit',
    //                   ),
    //                 ),
    //                 subtitle: Column(
    //                   children: [
    //                     Container(
    //                         width: double.infinity,
    //                         child: const Text('Acc # 03123456789',
    //                             style: TextStyle(
    //                               fontFamily: 'Kanit',
    //                             ))),
    //                     Container(
    //                         width: double.infinity,
    //                         child: const Text('Nadia Parveen',
    //                             style: TextStyle(
    //                               fontFamily: 'Kanit',
    //                             ))),
    //                   ],
    //                 ),
    //                 secondary: const Icon(Icons.account_balance),
    //                 value: isSwitchedAcc1,
    //                 onChanged: (value) {
    //                   setState(() {
    //                     isSwitchedAcc1 = value;
    //                   });
    //                 },
    //                 activeColor: Colors.green,
    //                 activeTrackColor: Colors.green.withOpacity(0.5),
    //                 inactiveThumbColor: Colors.grey,
    //                 inactiveTrackColor: Colors.grey.withOpacity(0.5),
    //               ),
    //             ),
    //             Container(
    //               margin: const EdgeInsets.only(top: 10),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(8),
    //                 border: Border.all(color: Colors.green, width: 2),
    //               ),
    //               child: SwitchListTile(
    //                 title: const Text('Easypaisa',
    //                     style: TextStyle(
    //                       fontFamily: 'Kanit',
    //                     )),
    //                 subtitle: Column(
    //                   children: [
    //                     Container(
    //                         width: double.infinity,
    //                         child: const Text('Acc # 03123456789',
    //                             style: TextStyle(
    //                               fontFamily: 'Kanit',
    //                             ))),
    //                     Container(
    //                         width: double.infinity,
    //                         child: const Text('Acc Title: Aftab Ahmed',
    //                             style: TextStyle(
    //                               fontFamily: 'Kanit',
    //                             ))),
    //                   ],
    //                 ),
    //                 secondary: const Icon(Icons.account_balance),
    //                 value: isSwitchedAcc2,
    //                 onChanged: (value) {
    //                   setState(() {
    //                     isSwitchedAcc2 = value;
    //                   });
    //                 },
    //                 activeColor: Colors.green,
    //                 activeTrackColor: Colors.green.withOpacity(0.5),
    //                 inactiveThumbColor: Colors.grey,
    //                 inactiveTrackColor: Colors.grey.withOpacity(0.5),
    //               ),
    //             ),
    //           ]))),
    //     ));
    Provider.of<PaymentMethodProvider>(context, listen: false).fetchPaymentMethods();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 202, 98),
        title: const Column(
          children: [
            Text(
              'Admin Home v4.4',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'betproaqib@gmail.com',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Kanit',
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Consumer<DepositDetailsProvider>(
        builder: (context, provider, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.green,
                selectionHandleColor: Colors.green,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 80,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const PendingTransactions(),
                                  ),
                                );
                              },
                              child: const Card(
                                color: Colors.green,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Transactions',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Kanit',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 80,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PendingTransactionRequests(),
                                  ),
                                );
                              },
                              child: const Card(
                                color: Colors.green,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Transfers',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Kanit',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 80,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PendingUsers(
                                      pendingUsers: provider.pendingUsers,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.green,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Pending Users',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Kanit',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      margin: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          '${provider.pendingUsers.length}',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'Kanit',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 80,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TotalUsers(),
                                  ),
                                );
                              },
                              child: const Card(
                                color: Colors.green,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total Users',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Kanit',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ViewHistory()));
                            },
                            child: const SizedBox(
                              height: 65,
                              child: Card(
                                color: Colors.green,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'View History',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Kanit',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 65,
                            child: Card(
                              color: Colors.green,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Web',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Kanit',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.green,
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          title: Text(
                            about,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Kanit',
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          subtitle: Text(
                            supportDetail,
                            style: const TextStyle(
                                color: Colors.yellow,
                                fontFamily: 'Kanit',
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              detailController.text = supportDetail;
                              aboutController.text = about;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Edit Details'),
                                      content: SizedBox(
                                        height: 150,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            textSelectionTheme:
                                            const TextSelectionThemeData(
                                              cursorColor: Colors
                                                  .green, // Change global cursor color here
                                              selectionHandleColor: Colors
                                                  .green, // Change handle color here
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller: aboutController,
                                                keyboardType: TextInputType.text,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Kanit'),
                                                decoration: InputDecoration(
                                                  labelText:
                                                  'Enter Support Details',
                                                  hintText: 'Support Details',
                                                  labelStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Kanit'),
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: 'Kanit'),
                                                  enabledBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black
                                                            .withOpacity(0.5)),
                                                  ),
                                                  focusedBorder:
                                                  const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              TextField(
                                                controller: detailController,
                                                keyboardType: TextInputType.text,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Kanit'),
                                                decoration: InputDecoration(
                                                  labelText: 'Enter About',
                                                  hintText: 'About',
                                                  labelStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Kanit'),
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: 'Kanit'),
                                                  enabledBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black
                                                            .withOpacity(0.5)),
                                                  ),
                                                  focusedBorder:
                                                  const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              about = aboutController.text;
                                              supportDetail = detailController.text;
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: const Text(
                                            'Save',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green,
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        title: Text(
                          processTime,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            processTimeController.text = processTime;
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Edit Process Time'),
                                    content: SizedBox(
                                      height: 90,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          textSelectionTheme:
                                          const TextSelectionThemeData(
                                            cursorColor: Colors
                                                .green, // Change global cursor color here
                                            selectionHandleColor: Colors
                                                .green, // Change handle color here
                                          ),
                                        ),
                                        child: TextField(
                                          controller: processTimeController,
                                          keyboardType: TextInputType.text,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Kanit'),
                                          decoration: InputDecoration(
                                            labelText: 'Enter Process Time',
                                            hintText: 'Process Time',
                                            labelStyle: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Kanit'),
                                            hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontFamily: 'Kanit'),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                            ),
                                            focusedBorder:
                                            const UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.green),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            processTime =
                                                processTimeController.text;
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showAddPaymentMethodDialog(context),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Container(
                            margin: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 50, right: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2), width: 2),
                            ),
                            child: Center(
                              child: Text(
                                'Add payment method',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 20,
                                    fontFamily: 'Kanit'),
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: pickImage,
                              child: const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: images.map((image) {
                                return Container(
                                  padding: const EdgeInsets.all(1),
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border:
                                    Border.all(color: Colors.green, width: 2),
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: FileImage(image),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //     border: Border.all(color: Colors.green, width: 2),
                    //   ),
                    //   child: SwitchListTile(
                    //     title: const Text(
                    //       'Easypaisa',
                    //       style: TextStyle(
                    //         fontFamily: 'Kanit',
                    //       ),
                    //     ),
                    //     subtitle: const Column(
                    //       children: [
                    //         SizedBox(
                    //             width: double.infinity,
                    //             child: Text('Acc # 03123456789',
                    //                 style: TextStyle(
                    //                   fontFamily: 'Kanit',
                    //                 ))),
                    //         SizedBox(
                    //             width: double.infinity,
                    //             child: Text('Nadia Parveen',
                    //                 style: TextStyle(
                    //                   fontFamily: 'Kanit',
                    //                 ))),
                    //       ],
                    //     ),
                    //     secondary: const Icon(Icons.account_balance),
                    //     value: isSwitchedAcc1,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         isSwitchedAcc1 = value;
                    //       });
                    //     },
                    //     activeColor: Colors.green,
                    //     activeTrackColor: Colors.green.withOpacity(0.5),
                    //     inactiveThumbColor: Colors.grey,
                    //     inactiveTrackColor: Colors.grey.withOpacity(0.5),
                    //   ),
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.only(top: 10),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //     border: Border.all(color: Colors.green, width: 2),
                    //   ),
                    //   child: SwitchListTile(
                    //     title: const Text('Easypaisa',
                    //         style: TextStyle(
                    //           fontFamily: 'Kanit',
                    //         )),
                    //     subtitle: const Column(
                    //       children: [
                    //         SizedBox(
                    //             width: double.infinity,
                    //             child: Text('Acc # 03123456789',
                    //                 style: TextStyle(
                    //                   fontFamily: 'Kanit',
                    //                 ))),
                    //         SizedBox(
                    //             width: double.infinity,
                    //             child: Text('Acc Title: Aftab Ahmed',
                    //                 style: TextStyle(
                    //                   fontFamily: 'Kanit',
                    //                 ))),
                    //       ],
                    //     ),
                    //     secondary: const Icon(Icons.account_balance),
                    //     value: isSwitchedAcc2,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         isSwitchedAcc2 = value;
                    //       });
                    //     },
                    //     activeColor: Colors.green,
                    //     activeTrackColor: Colors.green.withOpacity(0.5),
                    //     inactiveThumbColor: Colors.grey,
                    //     inactiveTrackColor: Colors.grey.withOpacity(0.5),
                    //   ),
                    // ),



                    Consumer<PaymentMethodProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (provider.paymentMethods.isEmpty) {
                          return const Center(child: Text('No payment methods found.'));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: provider.paymentMethods.length,
                            itemBuilder: (context, index) {
                              final paymentMethod = provider.paymentMethods[index];
                              return Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green, width: 2),
                                ),
                                child: SwitchListTile(
                                  title: Text(
                                    paymentMethod['accountMethodType'],
                                    style: const TextStyle(
                                      fontFamily: 'Kanit',
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Acc # ${paymentMethod['accountNumber']}',
                                        style: const TextStyle(
                                          fontFamily: 'Kanit',
                                        ),
                                      ),
                                      Text(
                                        paymentMethod['accountHolderName'],
                                        style: const TextStyle(
                                          fontFamily: 'Kanit',
                                        ),
                                      ),
                                    ],
                                  ),
                                  secondary: const Icon(Icons.account_balance),
                                  value: provider.switchStates[index],
                                  onChanged: (value) {
                                    provider.toggleSwitch(index, value);
                                    provider.toggleSwitch(index, value);
                                  },
                                  activeColor: Colors.green,
                                  activeTrackColor: Colors.green.withOpacity(0.5),
                                  inactiveThumbColor: Colors.grey,
                                  inactiveTrackColor: Colors.grey.withOpacity(0.5),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}
