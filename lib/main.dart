import 'package:bpro_wallet_admin/providers/deposit_detail_provider.dart';
import 'package:bpro_wallet_admin/providers/payment_method_provider.dart';
import 'package:bpro_wallet_admin/providers/transfer_provider.dart';
import 'package:bpro_wallet_admin/providers/withdraw_detail_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'View/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBadv6c0PmBUoIlR7-Z4UeviHxdioFmnCo',
      appId: '1:1012997214299:android:e257ec6672e24fa66aaf7e',
      messagingSenderId: '1012997214299',
      projectId: 'bpro-f4ef0',
      storageBucket: 'bpro-f4ef0.appspot.com',
    ),
  );
  runApp(
    const MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DepositDetailsProvider()),
        ChangeNotifierProvider(create: (_) => PaymentMethodProvider()),
        ChangeNotifierProvider(create: (_) => WithdrawDetailProvider()),
        ChangeNotifierProvider(create: (_) => TransferProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
