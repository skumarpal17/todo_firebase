import 'package:crudopertion/crud.dart';
import 'package:crudopertion/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login/login.dart';
import 'login/register.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Note',
    home: Login(),
    onGenerateRoute: RouteServices.generateRoute,
  ),);
}
