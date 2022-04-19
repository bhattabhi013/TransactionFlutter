import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';
import 'package:transactions/model/images_model.dart';
import 'package:transactions/model/transactions_model.dart';
import 'package:transactions/screens/offline_image_save.dart';
import 'package:transactions/screens/transaction_page.dart';
import 'package:unique_identifier/unique_identifier.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(ImageAdapter());
  // await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<Images>('images');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _identifier = 'Unknown';

  @override
  void initState() {
    super.initState();
    initUniqueIdentifierState();
  }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    setState(() {
      _identifier = identifier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // home: new Scaffold(
      //   appBar: new AppBar(
      //     title: const Text('Plugin example app'),
      //   ),
      //   body: new Center(
      //     child: new Text('Running on device with id: $_identifier\n'),
      //   ),
      // ),
      home: ImagesDemoScreen(),
    );
  }
}
