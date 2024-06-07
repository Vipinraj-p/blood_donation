import 'package:blood_donation/donor.dart';
import 'package:blood_donation/home_page.dart';
import 'package:blood_donation/splash_screen.dart';
import 'package:blood_donation/update.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyBpRvwnOIe68458R3G4eMvbTaRa2hEueMg',
    appId: 'com.example.blood_donation',
    messagingSenderId: '475549901896',
    projectId: 'blood-donation-f8699',
    storageBucket: 'blood-donation-f8699.appspot.com',
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    // routes: {
    //   '/': (context) => SplashScreen(),
    //   '/Home': (context) => HomePage(),
    //   '/add': (context) => Donors(),
    //   '/update': (context) => UpdateDonor()
    // },
    home: SplashScreen(),
    //initialRoute: '/',
  ));
}
