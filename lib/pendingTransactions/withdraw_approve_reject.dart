import "dart:io";

import "package:bpro_wallet_admin/models/withdraw_model.dart";
import "package:bpro_wallet_admin/providers/withdraw_detail_provider.dart";
import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

import "../models/deposit_model.dart";
import "../providers/deposit_detail_provider.dart";

class WithdrawApproveOrReject extends StatefulWidget {
  WithdrawDetailProvider withdrawDetailProvider;
  WithdrawModel withdrawModel;
  WithdrawApproveOrReject({super.key, required this.withdrawDetailProvider, required this.withdrawModel});

  @override
  State<WithdrawApproveOrReject> createState() => _WithdrawApproveOrRejectState();
}

class _WithdrawApproveOrRejectState extends State<WithdrawApproveOrReject> {

  // Future<ImageProvider> _loadImage(String imageUrl) async {
  //   if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
  //     return NetworkImage(imageUrl);
  //   } else {
  //     return FileImage(File(imageUrl));
  //   }
  // }
  //
  //
  // ImageProvider _getImageProvider(String imageUrl) {
  //   if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
  //     return NetworkImage(imageUrl);
  //   } else {
  //     return FileImage(File(imageUrl));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Approve Transaction',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Do you want to approve this transaction?',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'User ID : ${widget.withdrawModel.accountTitle}',
              style: const TextStyle(
                fontFamily: 'Kanit',
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Ac Type : ${widget.withdrawModel.accountType}',
              style: const TextStyle(
                fontFamily: 'Kanit',
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Amount : ${widget.withdrawModel.amount}',
              style: const TextStyle(
                fontFamily: 'Kanit',
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Status : ${widget.withdrawModel.status}',
              style: const TextStyle(
                fontFamily: 'Kanit',
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Tax Type : ${widget.withdrawModel.accountTitle}',
              style: const TextStyle(
                fontFamily: 'Kanit',
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 20),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * .4,
            //   width: MediaQuery.of(context).size.width * .5,
            //   child: widget.deposit.image != null
            //       ? FutureBuilder(
            //     future: _loadImage(widget.deposit.image),
            //     builder: (context, AsyncSnapshot<ImageProvider> snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         if (snapshot.hasError) {
            //           return const Center(child: Text('Error loading image'));
            //         } else {
            //           return Image(image: snapshot.data!);
            //         }
            //       } else {
            //         return Shimmer.fromColors(
            //           baseColor: Colors.grey[300]!,
            //           highlightColor: Colors.grey[100]!,
            //           child: Container(
            //             color: Colors.green,
            //           ),
            //         );
            //       }
            //     },
            //   )
            //       : const Center(child: Text('No image')),
            // ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    widget.withdrawDetailProvider.updateDepositStatus(widget.withdrawModel.id, 'Rejected');
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Reject',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.withdrawDetailProvider.updateDepositStatus(widget.withdrawModel.id, 'Approved');
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Approve',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
